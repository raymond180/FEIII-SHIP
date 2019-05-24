import pandas as pd
import numpy as np
from sklearn import preprocessing

import gensim
from gensim.test.utils import datapath

import itertools
import logging
import sys

from manage_path import *

def read_data(file_name='BofL6country.zip',is_zip=True):
    # Ignore 'trade_update_date', 'run_date', 'vessel_name', 'secondary_notify_party_1','container_number'
    usecols = ['identifier','port_of_unlading','estimated_arrival_date','foreign_port_of_lading'
               ,'record_status_indicator','place_of_receipt', 'port_of_destination'
               ,'foreign_port_of_destination','actual_arrival_date'
               ,'consignee_name','consignee_address','consignee_contact_name'
               ,'consignee_comm_number_qualifier','consignee_comm_number'
               ,'shipper_party_name', 'shipper_address','shipper_contact_name'
               ,'shipper_comm_number_qualifier','shipper_comm_number'
               ,'description_sequence_number', 'piece_count', 'description_text'
               ,'harmonized_number', 'harmonized_value'
               ,'harmonized_weight','harmonized_weight_unit']
    dtype = {'identifier':str,'port_of_unlading':'category','foreign_port_of_lading':'category'
         ,'record_status_indicator':'category','place_of_receipt':'category'
         ,'port_of_destination':'category','foreign_port_of_destination':'category'
         ,'consignee_name':str,'consignee_address':str,'consignee_contact_name':str
         ,'consignee_comm_number_qualifier':str,'consignee_comm_number':str
         ,'shipper_party_name':str,'shipper_address':str,'shipper_contact_name':str
         ,'shipper_comm_number_qualifier':str,'shipper_comm_number':str
         ,'description_sequence_number':'int16', 'piece_count':'float32', 'description_text':str
         ,'harmonized_number':str, 'harmonized_value':'float32'
         ,'harmonized_weight':'float32','harmonized_weight_unit':'category'}
    parse_dates = ['estimated_arrival_date','actual_arrival_date']
    #build path from file_name
    path = get_dataset_directory() / file_name
    if is_zip:
        data= pd.read_csv(path,usecols=usecols,dtype=dtype,parse_dates=parse_dates,compression='zip')
    else:
        data= pd.read_csv(path,usecols=usecols,dtype=dtype,parse_dates=parse_dates)
    return data

def process_data(data):
    data = data.dropna(subset=['shipper_party_name','harmonized_number'])
    replace_char = ",.=_-><\'\":;()!~"
    replace_dict = {key:value for (key,value) in zip(replace_char,itertools.repeat(''))}
    data['cl_shipper_party_name'] = data['shipper_party_name'].str.translate(str.maketrans(replace_dict)).values
    data = data.assign(shipper_id=(data['cl_shipper_party_name']).astype('category').cat.codes)
    data['6_harmonized_number'] = data['harmonized_number'].apply(lambda x: str(x)[0:6])
    return data

def create_BoW_harmonized_shipper(data):
    bag_of_words = data.groupby(by=['6_harmonized_number','cl_shipper_party_name']).size().unstack(fill_value=0)
    return bag_of_words

def create_BoW_shipper_harmonized(data):
    bag_of_words = data.groupby(by=['cl_shipper_party_name','6_harmonized_number']).size().unstack(fill_value=0)
    return bag_of_words

def create_corpus(bag_of_words,corpus_save_name,save=True):
    # compute corpus from bag_of_words
    corpus = gensim.matutils.Dense2Corpus(bag_of_words.values,documents_columns=False)
    # save corpus
    if save:
        corpus_directory = get_corpus_directory()
        if not corpus_directory.is_dir():
            create_directory(corpus_directory)
        file_name = corpus_directory / "{}.mm".format(corpus_save_name)
        gensim.corpora.MmCorpus.serialize(str(file_name), corpus)
    else:
        pass
    return corpus

def load_corpus(file_name):
    """Load the saved corpus"""
    print("loading corpus...")
    corpus_directory = get_corpus_directory()
    file_name = corpus_directory / "{}.mm".format(file_name)
    file_name = str(file_name)
    corpus = gensim.corpora.MmCorpus(file_name)
    print("corpus successfully loaded!!")
    print(corpus)
    return corpus

def create_id2word(bag_of_words,id2word_save_name,save=True):
    le = preprocessing.LabelEncoder()
    le.fit(bag_of_words.columns)
    transform = le.transform(bag_of_words.columns)
    inverse_transform = le.inverse_transform(transform)
    id2word = dict(zip(transform, inverse_transform))
    if save:
        print("saving id2word ...")
        id2word_directory = get_id2word_directory()
        if not id2word_directory.is_dir():
            create_directory(id2word_directory)
        file_name = id2word_directory / "{}.npy".format(id2word_save_name)
        # save the id2word using numpy
        np.save(file_name, id2word)
        print("id2word saved!!")
    else:
        pass
    return id2word

def load_id2word(id2word_name):
    print("loading id2word ...")
    id2word_directory = get_id2word_directory()
    id2word_save_path = id2word_directory / "{}.npy".format(id2word_name)
    # load the id2word using numpy
    id2word = np.load(id2word_save_path,allow_pickle=True).item()
    print("id2word loaded!!")
    return id2word

def compute_lda(corpus_name,corpus,num_topics,id2word,workers=3,chunksize=10000,passes=30,iterations=400):
    lda_save_name = "{}_{}topics".format(corpus_name,num_topics)
    logs_directory = get_logs_directory()
    log_filename = logs_directory / "{}.log".format(lda_save_name)
    logging.basicConfig(filename=log_filename,format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    print("LdaMulticore Start!!")
    lda = gensim.models.ldamulticore.LdaMulticore(corpus=corpus,id2word=id2word,workers=workers, num_topics=num_topics, chunksize=chunksize, passes=passes,iterations=iterations,dtype=np.float64,random_state=1)
    print("LdaMulticore Done!!")

    print("Saving Model as "+lda_save_name)
    
    # create directory
    save_path = get_LDAModel_directory()
    # create sub-directory
    save_path = save_path / ("./{}/".format(lda_save_name))
    create_directory(save_path)
    
    save_path = save_path / lda_save_name
    save_path = datapath(str(save_path))

    lda.save(save_path)
    print("Model successfully save at" + save_path)
    return lda
    
def main():
    data = read_data()
    data = process_data(data)
    save_name = sys.argv[1]
    if save_name == 'harmonized_shipper':
        bag_of_words = create_BoW_harmonized_shipper(data)
    elif save_name == 'shipper_harmonized':
        bag_of_words = create_BoW_shipper_harmonized(data)
    else:
        print('not reconize')
    corpus = create_corpus(bag_of_words,save_name,save=True)
    id2word = create_id2word(bag_of_words,save_name,save=True)
    num_topics = sys.argv[2]
    compute_lda(save_name,corpus,num_topics,id2word)
    
    
    
if __name__== "__main__":
    main()
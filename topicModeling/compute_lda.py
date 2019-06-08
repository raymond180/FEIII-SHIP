import pandas as pd
import numpy as np
from sklearn import preprocessing

import gensim
from gensim.test.utils import datapath
from gensim.corpora import Dictionary
import pyLDAvis.gensim

import itertools
import logging
import sys

from manage_path import *

def read_data(file_name='BofL6country.zip',is_zip=True,from_http=False):
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
    # build path from file_name
    if from_http:
        path = file_name
    else:
        path = get_dataset_directory() / file_name
    # pandas read_csv
    if is_zip:
        data= pd.read_csv(path,usecols=usecols,dtype=dtype,parse_dates=parse_dates,compression='zip')
    else:
        data= pd.read_csv(path,usecols=usecols,dtype=dtype,parse_dates=parse_dates)
    return data

def shipper_frozenset(col1,col2):
    return frozenset([col1,col2])

def shipper_set(col1,col2):
    return {col1,col2}

def match_shipper():
    def create_set_master(master_left,master_right):
        if not master_left.isdisjoint(master_right):
            new_master = master_left.union(master_right)
        else:
            new_master = master_left
        return new_master
    #shipper_matching = pd.read_csv(get_match_result_directory() / 'Enigma_Enigma_2018.csv')
    shipper_matching = pd.read_csv(get_match_result_directory() / 'Enigma_Enigma_6countries.csv')
    shipper_matching  = shipper_matching[((shipper_matching['name_score']>0.9) & (shipper_matching['address_score']>0.6)) | (shipper_matching['address_score']>0.8)]
    shipper_frozenset_vectorize = np.vectorize(shipper_frozenset)
    shipper_matching['cl_shipper_frozenset'] = shipper_frozenset_vectorize(shipper_matching['cl_shipper_party_name_left'],shipper_matching['cl_shipper_party_name_right']) 
    # elinamate left-right mirror
    shipper_matching = shipper_matching.drop_duplicates(subset='cl_shipper_frozenset')
    shipper_set_vectorize = np.vectorize(shipper_set)
    create_set_master_vectorize = np.vectorize(create_set_master)
    shipper_matching['cl_shipper_set'] = shipper_set_vectorize(shipper_matching['cl_shipper_party_name_left'].values,shipper_matching['cl_shipper_party_name_right'].values)
    shipper_matching['cl_shipper_set_master'] = shipper_matching['cl_shipper_set'].copy()
    shipper_matching_copy = shipper_matching.copy()

    shift_steps = [i for i in range(len(shipper_matching)+1)]
    for step in shift_steps:
        #shipper_matching = pd.DataFrame(np.roll(shipper_matching,step,axis=0),columns=shipper_matching.columns).join(shipper_matching_copy['cl_shipper_set'],rsuffix='_right')
        shipper_matching['cl_shipper_set_right'] = np.roll(shipper_matching_copy['cl_shipper_set'],step)
        shipper_matching['cl_shipper_set_master'] = create_set_master_vectorize(shipper_matching['cl_shipper_set_master'].values,shipper_matching['cl_shipper_set_right'].values)
    return shipper_matching

def process_data(data):
    # Basic data cleaning
    data = data.dropna(subset=['shipper_party_name','harmonized_number'])
    replace_char = ",.+=_-><\'\":;()!?~/\\@#$%^&*~`[]{}"
    replace_dict = {key:value for (key,value) in zip(replace_char,itertools.repeat(''))}
    data['cl_shipper_party_name'] = data['shipper_party_name'].str.translate(str.maketrans(replace_dict)).copy()
    data = data.assign(shipper_id=(data['cl_shipper_party_name']).astype('category').cat.codes)
    data['6_harmonized_number'] = data['harmonized_number'].apply(lambda x: str(x)[0:6])
    
    # Merge same shipper entity of different names
    shipper_matching = match_shipper()
    shipper_matching = shipper_matching[['cl_shipper_party_name_left','cl_shipper_set_master']].copy()
    shipper_matching['cl_shipper_set_master'] = shipper_matching['cl_shipper_set_master'].apply(lambda x: str(frozenset(x))[10:-1])
    def combine_master(shipper,master):
        return shipper if pd.isnull(master) else master
    combine_master_vectorize = np.vectorize(combine_master)
    shipper_matching = shipper_matching.rename(columns={'cl_shipper_party_name_left':'cl_shipper_party_name'})
    data = data.merge(shipper_matching,on='cl_shipper_party_name',how='left')
    data['cl_shipper_set_master'] = combine_master_vectorize(data['cl_shipper_party_name'],data['cl_shipper_set_master'])
    return data

def create_BoW_harmonized_shipper(data):
    bag_of_words = data.groupby(by=['6_harmonized_number','cl_shipper_set_master']).size().unstack(fill_value=0)
    return bag_of_words

def create_BoW_shipper_harmonized(data):
    bag_of_words = data.groupby(by=['cl_shipper_set_master','6_harmonized_number']).size().unstack(fill_value=0)
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

def compute_lda(corpus_name,corpus,num_topics,id2word,workers=3,chunksize=10000,passes=60,iterations=400,alpha='symmetric'):
    lda_save_name = "{}_{}topics".format(corpus_name,num_topics)
    logs_directory = get_logs_directory()
    log_filename = logs_directory / "{}.log".format(lda_save_name)
    logging.basicConfig(filename=log_filename,format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    print("LdaMulticore Start!!")
    lda = gensim.models.ldamulticore.LdaMulticore(corpus=corpus,id2word=id2word,workers=workers, num_topics=num_topics, chunksize=chunksize, passes=passes,iterations=iterations,dtype=np.float64,random_state=1,alpha=alpha)
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

def save_pyldavis2html(model,corpus,dictionary,model_name,num_topics):
    print('preparing pyLDAvis ...')
    vis = pyLDAvis.gensim.prepare(model, corpus, dictionary, sort_topics=False)
    print('pyLDAvis done!!!')
    print('saving pyLDAvis to html ...')
    result_directory = get_result_directory()
    if not result_directory.is_dir():
        create_directory(result_directory)
    file_name = result_directory / '{}_{}topics.html'.format(model_name,num_topics)
    # Save visualization
    pyLDAvis.save_html(vis, str(file_name))
    print('pyLDAvis to html saved!!!')
    
def document_topic_distribution(corpus,bag_of_words,model,model_name,num_topics,minimum_probability=0.10):
    print('caculating document_topic_distribution ...')
    # minimum_probability is our threshold
    document_topics = model.get_document_topics(corpus,minimum_probability=minimum_probability)
    # convert document_topics, which is a gesim corpus, to numpy array
    document_topic_distribution_numpy = gensim.matutils.corpus2dense(document_topics,num_terms=int(num_topics))
    # need to transpose it because gensim represents documents on columns token on index
    document_topic_distribution_numpy = np.transpose(document_topic_distribution_numpy)
    # combine document_topic_distribution with index from matrix and columns represents gensim topics
    document_topic_distribution_pandas = pd.DataFrame(data=document_topic_distribution_numpy,index=bag_of_words.index,columns=np.arange(1,int(num_topics)+1,1))
    # Only get the top three topics per document
    #document_topic_distribution_pandas = document_topic_distribution_pandas[document_topic_distribution_pandas.rank(axis=1,method='max',ascending=False) <= 3]
    print('caculating document_topic_distribution done!!!')
    # Save the dataframe to csv
    print('saving document_topic_distribution...')
    result_directory = get_result_directory()
    if not result_directory.is_dir():
        create_directory(result_directory)
    file_name = result_directory / '{}_{}topics.csv'.format(model_name,num_topics)
    document_topic_distribution_pandas.to_csv(file_name)
    print('document_topic_distribution saved!!!')
    
def main():
    from_http = bool(int(sys.argv[1]))
    file_name= str(sys.argv[2])
    data = read_data(file_name=file_name,from_http=from_http)
    data = process_data(data)
    save_name = str(sys.argv[3])
    if save_name == 'harmonized_shipper_sym':
        bag_of_words = create_BoW_harmonized_shipper(data)
        alpha = 'symmetric'
    elif save_name == 'harmonized_shipper_asym':
        bag_of_words = create_BoW_harmonized_shipper(data)
        alpha = 'asymmetric'
    elif save_name == 'shipper_harmonized_sym':
        bag_of_words = create_BoW_shipper_harmonized(data)
        alpha = 'symmetric'
    elif save_name == 'shipper_harmonized_asym':
        bag_of_words = create_BoW_shipper_harmonized(data)
        alpha = 'asymmetric'
    else:
        print('not reconize')
    corpus = create_corpus(bag_of_words,save_name,save=True)
    id2word = create_id2word(bag_of_words,save_name,save=True)
    num_topics = int(sys.argv[4])
    model = compute_lda(save_name,corpus,num_topics,id2word,alpha=alpha)
    
    # Fro visualization
    dictionary = Dictionary.from_corpus(corpus,id2word=id2word)
    save_pyldavis2html(model, corpus, dictionary,save_name,num_topics)
    # For document_topic_distribution
    document_topic_distribution(corpus,bag_of_words,model,save_name,num_topics,minimum_probability=0.10)
    
    
    
if __name__== "__main__":
    main()

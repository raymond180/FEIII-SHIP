from manage_path import *
from compute_lda import load_corpus,load_id2word

import pandas as pd
import numpy as np

import sys

import gensim
import pyLDAvis.gensim
from gensim.corpora import Dictionary

def load_model(model_name,num_topics):
    """Load LDAModel for analysis"""
    print('Loading LDAModel ....')
    topic_name ="_{}topics".format(num_topics)
    file_name = model_name + topic_name
    LDAModel_directory = get_LDAModel_directory()
    load_path = LDAModel_directory / "{}/{}".format(file_name,file_name)
    load_path = str(load_path)
    lda = gensim.models.ldamulticore.LdaMulticore.load(load_path)
    print('LDAModel loaded!!!')
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
    
def main():
    model_name = str(sys.argv[1])
    num_topics = int(sys.argv[2])
    # Fro visualization
    corpus = load_corpus(model_name)
    id2word = load_id2word(model_name)
    dictionary = Dictionary.from_corpus(corpus,id2word=id2word)
    # Load LDAModel
    model = load_model(model_name,num_topics)
    save_pyldavis2html(model, corpus, dictionary,model_name,num_topics)

if __name__ == "__main__":
    main()
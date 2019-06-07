from compute_lda import *

def main():
    from_http = False
    file_name= 'BofL6country.zip'
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

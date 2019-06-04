from compute_lda import *

def main():
    from_http = False
    file_name= 'BofL6country.zip'
    data = read_data(file_name=file_name,from_http=from_http)
    data = process_data(data)
    save_name = str(sys.argv[3])
    if save_name == 'harmonized_shipper':
        bag_of_words = create_BoW_harmonized_shipper(data)
    elif save_name == 'shipper_harmonized':
        bag_of_words = create_BoW_shipper_harmonized(data)
    else:
        print('not reconize')
    corpus = create_corpus(bag_of_words,save_name,save=True)
    id2word = create_id2word(bag_of_words,save_name,save=True)
    num_topics = int(sys.argv[4])
    compute_lda(save_name,corpus,num_topics,id2word)
    
    
    
if __name__== "__main__":
    main()
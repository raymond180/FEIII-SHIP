import pandas as pd
import numpy as np
import re
from sklearn.feature_extraction.text import TfidfVectorizer
from scipy.sparse import csr_matrix
import sparse_dot_topn.sparse_dot_topn as ct
import time

from Levenshtein import distance,ratio
import multiprocessing
import itertools

def get_shipper():
    usecols = ['identifier', 'shipper_party_name', 'shipper_party_address_1',
           'shipper_party_address_2', 'shipper_party_address_3',
           'shipper_party_address_4', 'city', 'state_province', 'zip_code',
           'country_code']

    dtype = {'identifier':str,'shipper_party_name':str, 'shipper_party_address_1':str,
           'shipper_party_address_2':str, 'shipper_party_address_3':str,
           'shipper_party_address_4':str, 'city':'category', 'state_province':'category', 'zip_code':'category',
           'country_code':'category'}

    data = pd.read_csv('https://obj.umiacs.umd.edu/feiiiship/AMSShippers-2018.zip',usecols=usecols,dtype=dtype,compression='zip')
    return data

def shipper_matching():
    data = get_shipper()

    def ngrams(string, n=3):
        string = re.sub(r'[,-./]|\sBD',r'', string)
        ngrams = zip(*[string[i:] for i in range(n)])
        return [''.join(ngram) for ngram in ngrams]

    company_names = pd.Series(data['shipper_party_name'].unique()).dropna()
    vectorizer = TfidfVectorizer(min_df=1, analyzer=ngrams)
    tf_idf_matrix = vectorizer.fit_transform(company_names)

    def awesome_cossim_top(A, B, ntop, lower_bound=0):
        # force A and B as a CSR matrix.
        # If they have already been CSR, there is no overhead
        A = A.tocsr()
        B = B.tocsr()
        M, _ = A.shape
        _, N = B.shape

        idx_dtype = np.int32

        nnz_max = M*ntop

        indptr = np.zeros(M+1, dtype=idx_dtype)
        indices = np.zeros(nnz_max, dtype=idx_dtype)
        data = np.zeros(nnz_max, dtype=A.dtype)

        ct.sparse_dot_topn(
            M, N, np.asarray(A.indptr, dtype=idx_dtype),
            np.asarray(A.indices, dtype=idx_dtype),
            A.data,
            np.asarray(B.indptr, dtype=idx_dtype),
            np.asarray(B.indices, dtype=idx_dtype),
            B.data,
            ntop,
            lower_bound,
            indptr, indices, data)

        return csr_matrix((data,indices,indptr),shape=(M,N))
    
    t1 = time.time()
    matches = awesome_cossim_top(tf_idf_matrix, tf_idf_matrix.transpose(), 10, 0.8)
    t = time.time()-t1
    print("SELFTIMED:", t)

    def get_matches_df(sparse_matrix, name_vector, top=100):
        non_zeros = sparse_matrix.nonzero()

        sparserows = non_zeros[0]
        sparsecols = non_zeros[1]

        if top:
            nr_matches = top
        else:
            nr_matches = sparsecols.size

        left_side = np.empty([nr_matches], dtype=object)
        right_side = np.empty([nr_matches], dtype=object)
        similairity = np.zeros(nr_matches)

        for index in range(0, nr_matches):
            left_side[index] = name_vector[sparserows[index]]
            right_side[index] = name_vector[sparsecols[index]]
            similairity[index] = sparse_matrix.data[index]

        return pd.DataFrame({'left_side': left_side,
                              'right_side': right_side,
                               'similairity': similairity})

    matches_df = get_matches_df(matches, company_names, top=300000)
    matches_df.to_pickle('matches_df.pkl')

def apply_distance(col1,col2):
    return distance(col1,col2)

def apply_ratio(col1,col2):
    return ratio(col1,col2)

def multiprocess_apply_ratio(shipper,step=1):
    #apply_distance_vectorize = np.vectorize(apply_distance)
    apply_ratio_vectorize = np.vectorize(apply_ratio)
    result = pd.DataFrame({'left':shipper.values,'right':np.roll(shipper,step),'score':apply_ratio_vectorize(shipper.values,np.roll(shipper,step))})
    result = result[result['score']>=0.85]
    #print('shift step {} done'.format(step))
    return result

def match_by_levenshtein(start_index,end_index,file_name):
    print('getting shipper data...')
    data = get_shipper()
    shipper = pd.Series(data['shipper_party_name'].str.replace(',','',regex=False).str.replace('.','',regex=False).unique()).dropna()
    print('shift steps {} to {} start...'.format(start_index,end_index))
    shift_stpes = [i for i in range(start_index,end_index+1)]
    print('starting multiprocessing levenshtein ratio...')
    with multiprocessing.get_context('spawn').Pool(processes=multiprocessing.cpu_count()) as pool:
        try:
            pool_outputs = pool.starmap(multiprocess_apply_ratio, list(zip(itertools.repeat(shipper),shift_stpes)))
        finally:
            pool.close()
            pool.join()
    print('concating data frame for steps {} to {}...'.format(start_index,end_index))
    pd.concat(pool_outputs).to_pickle('match_by_levenshtein/{}'.format(file_name),compression='zip')
    print('steps {} to {} done!!'.format(start_index,end_index))
    
if __name__ == "__main__":
    import sys
    start_index = int(sys.argv[1])
    end_index = int(sys.argv[2])
    file_name = str(sys.argv[3])
    match_by_levenshtein(start_index,end_index,file_name)
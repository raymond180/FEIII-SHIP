import pandas as pd
import numpy as np

from Levenshtein import distance,ratio
import multiprocessing
import itertools
import os
import sys

def get_Enigma():
    usecols = ['identifier','shipper_party_name', 'shipper_address','harmonized_number']
    dtype = {'identifier':str,'shipper_party_name':str,'shipper_address':str,'harmonized_number':str}
    return pd.read_csv('export_sample_countries_challenge_with_orgs.csv.zip',usecols=usecols,dtype=dtype,compression='zip')

def apply_ratio(col1,col2):
    return ratio(col1,col2)

def multiprocess_apply_ratio(Enigma,step):
    #apply_distance_vectorize = np.vectorize(apply_distance)
    apply_ratio_vectorize = np.vectorize(apply_ratio)
    EnigmaL_join_EnigmaR = pd.DataFrame(np.roll(Enigma,step,axis=0),columns=Enigma.columns).join(Enigma,lsuffix='_left',rsuffix='_right')
    EnigmaL_join_EnigmaR['name_score'] = apply_ratio_vectorize(EnigmaL_join_EnigmaR['cl_shipper_party_name_left'].values,EnigmaL_join_EnigmaR['cl_shipper_party_name_right'].values)
    EnigmaL_join_EnigmaR['address_score'] = apply_ratio_vectorize(EnigmaL_join_EnigmaR['shipper_address_left'].values,EnigmaL_join_EnigmaR['shipper_address_right'].values)
    EnigmaL_join_EnigmaR = EnigmaL_join_EnigmaR[EnigmaL_join_EnigmaR['name_score']>=0.80]
    #result = result.loc[(result['score'] < 0.80) & (result['score']>=0.65)]
    #print('shift step {} done'.format(step))
    return EnigmaL_join_EnigmaR

def match_by_levenshtein(start_index,end_index,file_name):
    print('getting shipper data...')
    Enigma = get_Enigma()
    #Enigma = Enigma.rename(columns={'company_name':'E_com_name','company_address':'E_com_address'})
    Enigma = Enigma.dropna(subset='shipper_party_name')
    # Clean Enigma and Camaras and turn them into series
    replace_char = ",.=_-><\'\":;()!~"
    replace_dict = {key:value for (key,value) in zip(replace_char,itertools.repeat(''))}
    Enigma['cl_shipper_party_name'] = Enigma['shipper_party_name'].str.translate(str.maketrans(replace_dict))
    
    shift_steps = [i for i in range(start_index,end_index+1)]
    print('starting multiprocessing levenshtein ratio...')
    with multiprocessing.get_context('spawn').Pool(processes=multiprocessing.cpu_count()) as pool:
        try:
            pool_outputs = pool.starmap(multiprocess_apply_ratio, list(zip(itertools.repeat(Enigma),shift_steps)))
        finally:
            pool.close()
            pool.join()
    print('multiprocessing levenshtein ratio done, concating dataframes...')
    result = pd.concat(pool_outputs,ignore_index=True)
    result = result.drop_duplicates()
    result = result.sort_values(by=['cl_shipper_party_name_left','name_score'])
    
    columns_left = ['identifier_left','shipper_party_name_left','cl_shipper_party_name_left', 'shipper_address_left','harmonized_number_left'] 
    columns_right = ['identifier_right','shipper_party_name_right','cl_shipper_party_name_right', 'shipper_address_right','harmonized_number_right']
    # zip the columns
    columns = [i for j in zip(columns_left,columns_right) for i in j]
    result = result[columns]
    # Check if folder match_by_levenshtein exists, create it if not
    if not os.path.isdir('match_by_levenshtein/'):
        os.mkdir('match_by_levenshtein/')
    result.to_pickle('match_by_levenshtein/{}'.format(file_name),compression='zip')

if __name__ == "__main__":
    import sys
    start_index = int(sys.argv[1])
    end_index = int(sys.argv[2])
    file_name = str(sys.argv[3])
    match_by_levenshtein(start_index,end_index,file_name)

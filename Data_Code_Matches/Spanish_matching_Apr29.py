# -*- coding: utf-8 -*-
"""shipper_matching.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1fItbgy6RNnw_f_g-guHQisRzaPtBp1zl
"""

import pandas as pd
import numpy as np

from Levenshtein import distance,ratio
import multiprocessing
import itertools
import os
import sys

def get_Enigma():
    return pd.read_csv('enigma_19codes_spain_pipe.csv',sep='|')
def get_Camaras():
    usecols = ['code','company_name','company_address']
    return pd.read_csv('camaras_19codes_spain_pipe.csv',usecols=usecols,sep='|')
  
def apply_ratio(col1,col2):
    return ratio(col1,col2)

def multiprocess_apply_ratio(Enigma, Camaras,step):
    #apply_distance_vectorize = np.vectorize(apply_distance)
    apply_ratio_vectorize = np.vectorize(apply_ratio)
    Enigma_join_Camaras = pd.DataFrame(np.roll(Enigma,step,axis=0),columns=Enigma.columns).join(Camaras).dropna()
    Enigma_join_Camaras['name_score'] = apply_ratio_vectorize(Enigma_join_Camaras['E_cl_com_name'].values,Enigma_join_Camaras['C_cl_com_name'].values)
    Enigma_join_Camaras['address_score'] = apply_ratio_vectorize(Enigma_join_Camaras['E_com_address'].values,Enigma_join_Camaras['C_com_address'].values)
    Enigma_join_Camaras = Enigma_join_Camaras[Enigma_join_Camaras['name_score']>=0.80]
    #result = result.loc[(result['score'] < 0.80) & (result['score']>=0.65)]
    #print('shift step {} done'.format(step))
    return Enigma_join_Camaras

def match_by_levenshtein(file_name):
    print('getting shipper data...')
    Enigma = get_Enigma()
    Enigma = Enigma.rename(columns={'company_name':'E_com_name','company_address':'E_com_address'})
    Camaras = get_Camaras()
    Camaras = Camaras.rename(columns={'company_name':'C_com_name','company_address':'C_com_address'})
    
    # Clean Enigma and Camaras and turn them into series
    Enigma['E_cl_com_name'] = Enigma['E_com_name'].str.replace(',','',regex=False) \
                                                .str.replace('.','',regex=False) \
                                                .str.replace('"','',regex=False) \
                                                .str.replace('<','',regex=False)
    Camaras['C_cl_com_name'] = Camaras['C_com_name'].str.replace(',','',regex=False) \
                                                .str.replace('.','',regex=False) \
                                                .str.replace('"','',regex=False) \
                                                .str.replace('<','',regex=False)
    # Turn Camaras_ser into same length of Enigma_ser
    #Camaras = Camaras.append([np.nan]*(len(Enigma) - len(Camaras)),ignore_index=True)
    
    shift_steps = [i for i in range(0,len(Enigma))]
    print('starting multiprocessing levenshtein ratio...')
    with multiprocessing.get_context('spawn').Pool(processes=multiprocessing.cpu_count()) as pool:
        try:
            pool_outputs = pool.starmap(multiprocess_apply_ratio, list(zip(itertools.repeat(Enigma),itertools.repeat(Camaras),shift_steps)))
        finally:
            pool.close()
            pool.join()
    # Check if folder match_by_levenshtein exists, create it if not
    if not os.path.isdir('match_by_levenshtein/'):
        os.mkdir('match_by_levenshtein/')
    result = pd.concat(pool_outputs,ignore_index=True)
    result = result.sort_values(by=['E_cl_com_name','name_score'])
    columns = ['identifier', 'harmonized_code' , 'code', 'E_com_name' , 'C_com_name', \
               'name_score','E_cl_com_name' , 'C_cl_com_name', 'E_com_address', \
               'C_com_address','address_score']
    result.to_csv('match_by_levenshtein/{}'.format(file_name), sep='|',index=False,columns=columns)

if __name__ == "__main__":
    import sys
    file_name = str(sys.argv[1])
    match_by_levenshtein(file_name)

#!/bin/bash

source activate topicModeling
cd ~/Research/FEIII-SHIP/topicModeling/

python compute_lda.py 0 'BofL6country.zip' harmonized_shipper 5
python compute_lda.py 0 'BofL6country.zip' harmonized_shipper 15
python compute_lda.py 0 'BofL6country.zip' harmonized_shipper 25

python compute_lda.py 0 'BofL6country.zip' shipper_harmonized 5
python compute_lda.py 0 'BofL6country.zip' shipper_harmonized 15
python compute_lda.py 0 'BofL6country.zip' shipper_harmonized 25

python lda_analysis.py harmonized_shipper 5
python lda_analysis.py harmonized_shipper 15
python lda_analysis.py harmonized_shipper 25

python lda_analysis.py shipper_harmonized 5
python lda_analysis.py shipper_harmonized 15
python lda_analysis.py shipper_harmonized 25

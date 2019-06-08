#!/bin/bash

#source activate topicModeling
#cd ~/Research/FEIII-SHIP/topicModeling/
source ~/miniconda3/bin/activate
cd ~/FEIII-SHIP/topicModeling/

python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 10 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 20 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 30 

python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 10 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 20 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 30 

python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 10 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 20 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 30 

python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 10 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 20 
python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 30 

#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.output.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem 700gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda_mem.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2018.zip" 2018_harmonized_shipper_sym 50 &

#srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda_mem.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2018.zip" 2018_shipper_harmonized_sym 50 &

wait

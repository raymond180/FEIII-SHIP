#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.output.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=6
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=24
#SBATCH --mem 100gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 25 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 50 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 75 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 25 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 50 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 75 &

wait

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 25 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 50 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_asym 75 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 25 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 50 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_asym 75 &

wait

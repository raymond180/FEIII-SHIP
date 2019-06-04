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

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 10 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 20 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" harmonized_shipper_sym 30 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 10 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 20 &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 "https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BofL6country.zip" shipper_harmonized_sym 30 &


wait

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper_sym 10 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized_sym 10 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper_sym 20 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized_sym 20 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper_sym 30 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized_sym 30 &

wait

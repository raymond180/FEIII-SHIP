#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.output.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=24
#SBATCH --mem 100gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 1 50974 2018_0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 50975 101948 2018_1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 101949 152922 2018_2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 152923 203896 2018_3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 203897 254870 2018_4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 254871 305844 2018_5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 305845 356818 2018_6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 356819 407792 2018_7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 407793 458766 2018_8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 458767 509733 2018_9.pkl.zip &

wait

#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.output.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=24
#SBATCH --mem 64gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 1 11104 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 11105 22208 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 22209 33312 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 33313 44416 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 44417 55520 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 55521 66624 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 66625 77728 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 77729 88832 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 88833 99936 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 99937 111032 9.pkl.zip &

wait

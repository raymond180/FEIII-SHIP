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

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 1 103841 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 103842 207682 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 207683 311523 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 311524 415364 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 415365 519205 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 519206 623046 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 623047 726887 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 726888 830728 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 830729 934569 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching/Enigma_Enigma_matching.py 934570 1038408 9.pkl.zip &

wait

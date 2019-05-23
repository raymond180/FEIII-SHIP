#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.error.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=24
#SBATCH --mem 64gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1 11140 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 11141 22280 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 22281 33420 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 33421 44560 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 44561 55700 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 55701 66840 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 66841 77980 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 77981 89120 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 89121 100260 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 100261 111394 9.pkl.zip &


wait

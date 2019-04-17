#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output main.out.%j
#SBATCH --error main.out.%j
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem 64gb

source ~/miniconda3/bin/activate

srun python ~/FEIII-SHIP/shipper_matching.py
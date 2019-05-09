#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output main.out.%j
#SBATCH --error main.out.%j
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=60
#SBATCH --ntasks=60
#SBATCH --cpus-per-task=8
#SBATCH --mem 16gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1 63756 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 63757 127512 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 127513 191268 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 191269 255024 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 255025 318780 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 318781 382536 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 382537 446292 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 446293 510048 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 510049 573804 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 573805 637560 9.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 637561 701316 10.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 701317 765072 11.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 765073 828828 12.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 828829 892584 13.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 892585 956340 14.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 956341 1020096 15.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1020097 1083852 16.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1083853 1147608 17.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1147609 1211364 18.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1211365 1275120 19.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1275121 1338876 20.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1338877 1402632 21.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1402633 1466388 22.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1466389 1530144 23.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1530145 1593900 24.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1593901 1657656 25.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1657657 1721412 26.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1721413 1785168 27.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1785169 1848924 28.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1848925 1912680 29.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1912681 1976436 30.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1976437 2040192 31.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2040193 2103948 32.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2103949 2167704 33.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2167705 2231460 34.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2231461 2295216 35.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2295217 2358972 36.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2358973 2422728 37.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2422729 2486484 38.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2486485 2550240 39.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2550241 2613996 40.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2613997 2677752 41.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2677753 2741508 42.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2741509 2805264 43.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2805265 2869020 44.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2869021 2932776 45.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2932777 2996532 46.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2996533 3060288 47.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3060289 3124044 48.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3124045 3187800 49.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3187801 3251556 50.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3251557 3315312 51.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3315313 3379068 52.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3379069 3442824 53.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3442825 3506580 54.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3506581 3570336 55.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3570337 3634092 56.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3634093 3697848 57.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3697849 3761604 58.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 3761605 3825303 59.pkl.zip &

wait

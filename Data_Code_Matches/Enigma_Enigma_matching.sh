#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output main.out.%j
#SBATCH --error main.out.%j
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=60
#SBATCH --ntasks=60
#SBATCH --cpus-per-task=8
#SBATCH --mem 20gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1 50087 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 50088 100174 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 100175 150261 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 150262 200348 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 200349 250435 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 250436 300522 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 300523 350609 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 350610 400696 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 400697 450783 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 450784 500870 9.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 500871 550957 10.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 550958 601044 11.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 601045 651131 12.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 651132 701218 13.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 701219 751305 14.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 751306 801392 15.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 801393 851479 16.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 851480 901566 17.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 901567 951653 18.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 951654 1001740 19.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1001741 1051827 20.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1051828 1101914 21.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1101915 1152001 22.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1152002 1202088 23.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1202089 1252175 24.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1252176 1302262 25.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1302263 1352349 26.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1352350 1402436 27.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1402437 1452523 28.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1452524 1502610 29.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1502611 1552697 30.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1552698 1602784 31.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1602785 1652871 32.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1652872 1702958 33.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1702959 1753045 34.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1753046 1803132 35.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1803133 1853219 36.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1853220 1903306 37.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1903307 1953393 38.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 1953394 2003480 39.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2003481 2053567 40.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2053568 2103654 41.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2103655 2153741 42.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2153742 2203828 43.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2203829 2253915 44.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2253916 2304002 45.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2304003 2354089 46.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2354090 2404176 47.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2404177 2454263 48.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2454264 2504350 49.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2504351 2554437 50.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2554438 2604524 51.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2604525 2654611 52.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2654612 2704698 53.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2704699 2754785 54.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2754786 2804872 55.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2804873 2854959 56.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2854960 2905046 57.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2905047 2955133 58.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/Data_Code_Matches/Enigma_Enigma_matching.py 2955134 3005200 59.pkl.zip &

wait

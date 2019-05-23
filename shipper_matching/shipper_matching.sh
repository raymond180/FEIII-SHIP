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

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 1 12716 0.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 12717 25432 1.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 25433 38148 2.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 38149 50864 3.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 50865 63580 4.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 63581 76296 5.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 76297 89012 6.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 89013 101728 7.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 101729 114444 8.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 114445 127160 9.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 127161 139876 10.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 139877 152592 11.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 152593 165308 12.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 165309 178024 13.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 178025 190740 14.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 190741 203456 15.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 203457 216172 16.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 216173 228888 17.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 228889 241604 18.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 241605 254320 19.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 254321 267036 20.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 267037 279752 21.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 279753 292468 22.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 292469 305184 23.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 305185 317900 24.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 317901 330616 25.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 330617 343332 26.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 343333 356048 27.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 356049 368764 28.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 368765 381480 29.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 381481 394196 30.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 394197 406912 31.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 406913 419628 32.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 419629 432344 33.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 432345 445060 34.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 445061 457776 35.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 457777 470492 36.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 470493 483208 37.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 483209 495924 38.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 495925 508640 39.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 508641 521356 40.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 521357 534072 41.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 534073 546788 42.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 546789 559504 43.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 559505 572220 44.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 572221 584936 45.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 584937 597652 46.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 597653 610368 47.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 610369 623084 48.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 623085 635800 49.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 635801 648516 50.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 648517 661232 51.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 661233 673948 52.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 673949 686664 53.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 686665 699380 54.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 699381 712096 55.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 712097 724812 56.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 724813 737528 57.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 737529 750244 58.pkl.zip &
srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/shipper_matching.py 750245 762902 59.pkl.zip &

wait
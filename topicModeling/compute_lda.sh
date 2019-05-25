#!/bin/bash

#SBATCH --job-name=shipper_matching
#SBATCH --output %j.output.txt
#SBATCH --error %j.error.txt
#SBATCH --time=24:00:00
#SBATCH --qos=batch
#SBATCH --nodes=6
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=24
#SBATCH --mem 100gb

source ~/miniconda3/bin/activate

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V harmonized_shipper 25 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V shipper_harmonized 25 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V harmonized_shipper 50 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V shipper_harmonized 50 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V harmonized_shipper 75 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/compute_lda.py 1 https://obj.umiacs.umd.edu/feiiiship/Data/Dataset/BillofLadingSummary-2017.zip?Signature=1nRAReTcQeMJc%2F%2FB%2FPFmqaSfWDo%3D&Expires=1558861672&AWSAccessKeyId=LEWQ35PWV80BUR8TF23V shipper_harmonized 75 &

wait

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper 25 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized 25 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper 50 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized 50 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py harmonized_shipper 75 &

srun --nodes=1 --ntasks=1 --exclusive python ~/FEIII-SHIP/topicModeling/lda_analysis.py shipper_harmonized 75 &

wait

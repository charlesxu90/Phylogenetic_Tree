#!bin/bash
cd $1
filelist=`ls`
for filename in $filelist
do
	`perl ../1.pick_ref_seq.pl ../Ndr.hmm $filename`
	`perl ../2.select_seq_id.pl $filename`
	`perl ../3.get_final_seq.pl $filename`
done
cd ..
echo "Process finished!"
exit 0

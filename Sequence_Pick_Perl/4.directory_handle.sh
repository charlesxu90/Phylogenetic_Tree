#!/bin/bash
cd $1
filelist=`ls`
for filename in $filelist
do
	`perl perl/1.pick_ref_seq.pl perl/Ndr.hmm $filename
	perl perl/2.select_seq_id.pl $filename
	perl perl/3.get_final_seq.pl $filename`
done
cd ..
echo "Process finished!"
exit 0

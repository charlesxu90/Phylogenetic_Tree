#! /bin/bash/

echo "处理cyclin_C doamin:   输入文件夹名称，全蛋白质组序列格式为all_seq_文件夹名："


read -p "input the file  name:" file_name

#read -p "input the proteomics data name :" pro_name


#cp ~/work/hmm_script/*.pl $file_name/
#cp ../domain_select_new/*.hmm $file_name/





cd $file_name

perl 1.geneget.pl Cyclin_N.hmm all_seq_$file_name



perl 2.pre_remove.pl Cyclin_N.hmm


perl 3.remove.pl Cyclin_N.hmm


perl 4.getfinalid.pl Cyclin_N.hmm  all_seq_$file_name

cat Cyclin_N.hmm_final_seq.fasta | sed "s/>/>$file_name|/g" >>Cyclin_N.hmm_final_seq1.fasta

grep -v '^\S+|>$' Cyclin_N.hmm_final_seq1.fasta >>$file_name.N_final_seq.fa
cat Cyclin_N.hmm_final_id.txt>>$file_name.N_final_id.txt

cp $file_name.N_final_id.txt     ../all_N_seq/
cp $file_name.N_final_seq.fa     ../all_N_seq/

rm -fr Cyclin_C.hmm_final_id.txt
rm -fr Cyclin_C.hmm_final_seq1.fasta

cd ..

exit 0

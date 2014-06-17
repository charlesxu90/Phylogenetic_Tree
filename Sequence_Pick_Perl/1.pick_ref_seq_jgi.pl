#!/usr/bin/perl -w

# perl 1.pick_ref_seq Ndr.hmm Homo_sapiens.GRCh37.63.pep.all.fa
open(IN1,"hmmsearch -E 1e-8 $ARGV[0] $ARGV[1] |")or die "Cannot open step 1-1: $!\n";
open(OUT1,">>$ARGV[0]_ref_id.txt")or die"can't save step 1-1:$!";

while (<IN1>) {
	last if (/^Scores for complete sequences/);   #Find the line which starts with "Scores for complete sequences".
}

$n=0;	#count the number of the suitable resultes.
@Id_no="";
while (<IN1>) {  #use the  "while" cycle to find the suitable lines.
	chomp ($_);  #cut down the sign of"\n".
	if (index($_,"jgi|")!=-1) {# the index function is used to find lines containing the string of "ENSP".
		@data=split(/\s+/,$_);    #format the line into an array.
		my $id=$data[9]; my $score=$data[2];my $evalue=$data[1]; #assign the variable according to the index of the array.
		print "$id\t$score\t$evalue\n"; #output the informations.
		print OUT1 "$id\t$score\t$evalue\n";#save the informations into a file.
		$Id_no[$n]="$id";
		$n++;
	}
	last if (index ($_,"Domain annotation for each sequence")!=-1);#the condition on which to break the cycle.
}
print "the total amount of selected id is $n;\n";	#print $n.

close IN1;
close OUT1;






open(IN2,"$ARGV[1]")or die "can't open step 1-2: $!";
open (OUT2,">>$ARGV[1]_ref_seq.fasta")or die"can't save step 1-2:$!";
		
$/=">";#depart the sequence file according to the sign '>'.
print OUT2 ">";
while (<IN2>) {#search for sequences with the selected id
for ($i=0;$i<$n ;$i++) {

	@seq_data=split(/\s+/,$_);
	$seq_data=$seq_data[0];
	if (index ($seq_data,$Id_no[$i])!=-1) {
		print OUT2 $_;
		}
}
}


close IN2;
close OUT2;
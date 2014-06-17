#! usr/bin/perl -w
#
#
unless(open(IN1,"hmmsearch -E 1e-8 $ARGV[0] $ARGV[1] |")) {die " 1 step cannot be open :$!";}
open(OUT1,">>$ARGV[0]_id.txt") || die "1 step:$!";

while(<IN1>)
{
	last if(/^Scores for complete sequences/);
}


$n=0;
$id_noline="data id:";
while(<IN1>)
{
	chomp($_);                               #DELETE THE VAIN LINE
	if(index($_,"jgi|")!=-1)    #FIND THE DATA LINE.
	{	@data=split(/\s+/,$_);
		my $ida =$data[9];my $score=$data[2];my $evalue=$data[1];
#		print "$ida\t$score\t$evalue\n"; 
		print OUT1 "$ida\t$score\t$evalue\n";
		$id_noline=$id_noline."$ida"."$score"."$evalue";
		$n++;# caculate the amount of the id;
	}
	last if(index($_,"Domain annotation for each sequence")!=-1);  #stop when cometo the error region
}
print  "the total amount of selected id is $n";# print the number


close IN1;
close OUT1;
#
#
#
#
#
#
#
#
#
open(IN2_SOU,"$ARGV[1]") || die "2 step:$!";
#open(IN2_ID,"$ARGV[0]_noline_id.txt") || die "2 step:$!";
open(OUT2,">>$ARGV[0]_id_allseq.fasta") ||  die "2 step:$!";

$/=">";
print OUT2 ">";

while(<IN2_SOU>)
{
	@id2_data=split(/\s+/,$_);
	$id2_data=$id2_data[0];

	if(index($id_noline,$id2_data)!=-1)
	{print OUT2 $_;
#	print @id2_data;
#	print "\n";
	}
}

close IN2_SOU;
close OUT2;

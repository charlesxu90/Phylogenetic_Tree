#! usr/bin/perl -w
#
unless(open(IN,"infoseq $ARGV[0]_id_allseq.fasta |")){ die "cannot be open :$!";}
open(OUT,">>$ARGV[0]_id_pre_remove.txt")  || die "cannot be open:$!";
while(<IN>)
{
	if(/gene:(\S+)\s/)
	{print $1."\t";
	 print OUT $1."\t";
	}

	if(/\s+(\d+)\s+/)
	{
         print $1."\t";
	 print OUT $1."\t";
=comment
	if(/fasta:(\S+)\s/)
	{
	print $1."\n";
	 print OUT $1."\n"; 
 	}
=cut

	@pro=split(/\s+/,$_);
	print $pro[2]."\n";
	print OUT $pro[2]."\n";
	}	
}
close IN;
close OUT;

#!/usr/bin/perl -w
use strict;
use warnings;
# perl 2.select_seq_id Homo_sapiens.GRCh37.63.pep.all.fa
open(IN,"infoseq $ARGV[0]_ref_seq.fasta |")or die"can't open step 2-1:$!";
open(OUT,">>$ARGV[0]_pre_id.txt")or die"can't save step 2-1:$!";
while(<IN>)# this cycle can pick the ids for selection.
{
	if(/gene:(\S+)\s/)#$1 reffers to the string behind "gene:"
	{print $1."\t";
	 print OUT $1."\t";
	}

	if(/\s+(\d+)\s+/)
	{
         print $1."\t";
	 print OUT $1."\t";
	}

	if(/.fasta:(\S+)\s/)
	{
	print $1."\n";
	 print OUT $1."\n"; 
 	}
=comment
	@pro=split(/\s+/,$_);
	print $pro[2]."\n";
	print OUT $pro[2]."\n";
=cut	
}
close IN;
close OUT;





open(IN2,"<$ARGV[0]_pre_id.txt")or die"cannot be open step 2-2:$!";
open(OUT2,">>$ARGV[0]_aft_id.txt")or die "cannot save step 2-2:$!";
=comment
before the progam  use the "infoseq" commond to deal with the data

ENSTNIG00000014553          415 ENSTNIP00000017578
ENSTNIG00000007338          406 ENSTNIP00000010143
ENSTNIG00000015567          278 ENSTNIP00000018639
ENSXETG00000012081          154 ENSXETP00000057999
=cut
my %hash;
while(<IN2>){#this cycle can sellect the longest protein id of a gene
	chomp;
	my($gene,$len,$prot)=split(/\t/,$_);
	if(!exists $hash{$gene} || $hash{$gene}->{'len'}<$len){# if there exists a hash member whoes key is $gene,then compare 'len',if not create a hash member.
		$hash{$gene}->{'len'}=$len;
		$hash{$gene}->{'prot'}=$prot;
	}
}
close IN2;
foreach my $gene(keys %hash){#output the hash members.
	print OUT2 $gene."\t".$hash{$gene}->{'len'}."\t".$hash{$gene}->{'prot'}."\n";
}
close OUT2;
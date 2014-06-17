#!/usr/bin/perl -w
use warnings;

#  perl 3.get_final_seq  Homo_sapiens.GRCh37.63.pep.all.fa
open(IN1,"$ARGV[0]_aft_id.txt") || die  $!;
open (OUT1,">>$ARGV[0]_final_id.txt") || die $!;

$id_data="the id:\t";
while(<IN1>)
{
	@data=split(/\s+/,$_);
	$id=$data[2];
	$id_data=$id_data."$id\t\t";
	print OUT1 $id."\n";	
}
print $id_data;
close IN1;
close OUT1;
#
#
#
#
#
open(IN2,"$ARGV[0]")  || die $!;
open(OUT2,">>$ARGV[0]_final_seq.fasta") || die $!;

$/=">";
print OUT2 ">";
while(<IN2>)
{
	@id2_data=split(/\s+/,$_);
	$id2_data=$id2_data[0];

	if(index($id_data,$id2_data)!=-1)
	{print OUT2 $_;
	print @id2_data;
	print "\n";
	}
}

close IN2;
close OUT2;


#!/usr/bin/perl
=comment

before the progam  use the "infoseq" commond to deal with the data

ENSTNIG00000014553          415 ENSTNIP00000017578
ENSTNIG00000007338          406 ENSTNIP00000010143
ENSTNIG00000015567          278 ENSTNIP00000018639
ENSXETG00000012081          154 ENSXETP00000057999
=cut
use strict;
my %hash;
open(IN,"<$ARGV[0]_id_pre_remove.txt") or die $!;
open(OUT,">>$ARGV[0]_id_remove.txt")   or die $!;
while(<IN>){
	chomp;
	my($gene,$len,$prot)=split /\t/;
	if(!exists $hash{$gene} or $hash{$gene}->{'len'}<$len){
		$hash{$gene}->{'len'}=$len;
		$hash{$gene}->{'prot'}=$prot;
	}
}
close IN;
foreach my $gene(keys %hash){
	print OUT $gene."\t".$hash{$gene}->{'len'}."\t".$hash{$gene}->{'prot'}."\n";
}
close OUT;

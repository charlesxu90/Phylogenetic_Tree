#!/usr/bin/perl -w
## perl tree_build.pl output.txt
open(IN,"$ARGV[0]")or die "can't open step 1: $!";
open (OUT,">>$ARGV[0]_out.txt")or die"can't save step 2:$!";
		

my @seq_data;
my $Id="";
while (<IN>) {
	chomp ($_);
	@seq_data=split(/\s+/,$_); 

if(index($seq_data[0],">")!=-1) {
	print OUT "\n";
	print OUT ">";}
elsif (index($Id,$seq_data[0])!=-1) {
		print OUT $seq_data[1];}
	else{ $Id= $seq_data[0];
		print OUT $seq_data[0];
		print OUT "\n";
		print OUT $seq_data[1];
		 }
} 


close IN;
close OUT;

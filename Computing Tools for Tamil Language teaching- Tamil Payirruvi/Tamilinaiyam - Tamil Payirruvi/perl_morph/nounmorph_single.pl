# usr/bin/perl
#use warnings;
#use strict;
#######################
#Author: M.Anand kumar
# M-gen for Noun
# started MAY 25th 8.40 P.M 
#
#
#system("rm perl/Tamil_morpgen.txt");
####################### DECLARATIONS
my $nounin="perl/tamil.txt";
system("rm perl/Tamil_morpgen.txt");
my $nouninfile="perl/noun_in.txt";#"chennai ACC";
my $mlifile="perl/nountags.txt";
#my $nounroot=$ARGV[0];#chennai

#my $nouninfle=$ARGV[1];#ACC

my $i=1,$parnum,$j=1,$mlindex;
$mlindex=$ARGV[0];
my @allnoun,@allpar;
######################PARADIGM NUMBER IDENTIFICATION
my $nounlist="perl/nounallparno.txt";#"chennai-12";

open NR,"<:encoding(UTF-8)","$nounin" or die "I cant open the file  for reading";
while (<NR>)
{
chomp;
$nounroot=$_;
}




open NL,"<:encoding(UTF-8)","$nounlist" or die "I cant open the file  for reading";
while (<NL>)
{
chomp;
($allnoun[$i],$allpar[$i])=split("-",$_);
if($nounroot=~m/$allnoun[$i]$/)#$string =~ m/sought_text$/;
{
$parnum=$allpar[$i]-1;
last;
}
$i++;
}
close NL;
print "PARNUM ".$parnum;
##########################STEMMING SUBROUTINE
my $nounstem=&stemming;
#############################RETRIVING FROM INFLECTION TABLE
my $noundatafile="perl/database_noun.csv";
#whilemy $fil="database_new.csv";
my $finalout="perl/finalout.txt";
my @dat;
#my $i=1;
#my @aa;
open RH,"<:encoding(UTF-8)","$noundatafile" or die "I cant open the file map for reading";


my $row=1;
while(<RH>)
{
my $line=$_;
@aline=split(",",$line);
for($col=0;$col<=$#aline;$col++)
{
$dat[$row][$col]=$aline[$col];
}
$row++;
}
close RH;
########################MLI FILE
=pod
open ML,"<:encoding(UTF-8)","$mlifile" or die "I cant open the file  for reading";
while (<ML>)
{
chomp;
if($_ eq $nouninfle)
{
$mlindex=$j;
last;
}
$j++;
}
close ML;
=cut
######################## CUTTING PART
my $nounmod="perl/nounmod.txt";#"chennai-12";
open NM,"<:encoding(UTF-8)","$nounmod" or die "I cant open the file  for reading";
while (<NM>)
{
chomp;
($pno,$cut)=split(" ",$_);
if(($pno eq $parnum ) && ($cut ne "*"))
{
$nounroot=~s/$cut$//;
last;}}
close NM;
################print output
open WH,">:encoding(UTF-8)","$finalout" or die "I cant open the file map for reading";

print  "OUTPUT--->".$nounroot.$dat[$mlindex][$parnum];

print WH $nounroot.$dat[$mlindex][$parnum];
close WH;
####################### STEMMING
sub stemming
{
#writ abt stemming---------$cut;
print $parnum;
}
#print $nounstem;




#########################################
my $OUTP = "perl/Tamil_morpgen.txt";
my $ru_map = "perl/ROMAN_UNICODE_MAP.txt";
my @rom;
my @uni;

open MAP,"<:encoding(UTF-8)","$ru_map" or die "I cant open the file map for reading";
my $iter=0;
while(<MAP>){
  chomp;
  ( $rom[$iter], $uni[$iter] ) = split /\s*:\s*/;
  $iter++;
}
close MAP;
open INP,"<:encoding(UTF-8)","$finalout" or die "I cant open the file $fileout for reading";
open OUTP,">>:encoding(UTF-8)","$OUTP" or die "I cant open the file for writing";

while(<INP>){
  chomp;
  my $templine = $_;
  for(my $i=0;$i<=$#rom;$i++)
{    $rom[$i] =~ s/\s//g;
    $uni[$i] =~ s/\s//g;
    $templine =~ s/$rom[$i]/$uni[$i]/g;
$templine =~ s/[\@\+]//g;
} 
 print OUTP "$templine\n";
print "$templine\n";
}
close INP;
close OUTP;
#print "Done";

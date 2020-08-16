# usr/binperl
#use warnings;
#use strict;
#######################single gen program 
my $paad;
my $waada;
my $r;
my $h;
my @parnum;
my @word;
my @temp1;
my @key1;
my @value1;
my $mlenum=$ARGV[0];
my $inputword="";
my $temp=0;
my $paradimno="";
my $iter=1;
my $thr;
my $it=0;
my $ite=0;
my $rpar="perl/anandkumar.txt";
my $rparmod="perl/mod.txt";
my $three="perl/25_6.txt";
my $four="perl/25_8.txt";
my $padi="perl/25_padi_eng.txt";
my $wada="perl/26_wada_eng.txt";
my $outfile="perl/parnumb.txt";
my $file1 = "perl/tamil.txt";
my $file2 = "perl/eng.txt";
my $urmap = "perl/UNICODE_ROMAN_MAP.txt";
my @key;
my @value;
#my @past=("11","8","1","3","42","5","12","","","","");
#my @present=("22","19","13","14","46","16","23","","","","");
#my @future=("11","30","24","25","35","27","34","","","","");

#system("DEL perl\\Tamil_morpgen.txt");
system("rm perl/Tamil_morpgen.txt");
#my $sef = "perl/vc.txt";
open RHANDLEm,"<:encoding(UTF-8)","$urmap" or die "I cant open the file map for reading";
my $iter1=0;
while(<RHANDLEm>){
  chomp;
  ( $key[$iter1], $value[$iter1] ) = split /\s*:\s*/;
  $iter1++;
}
close RHANDLEm;
open RHANDLE,"<:encoding(UTF-8)","$file1" or die "I cant open the file tt2002 for reading";
open WHANDLE,">:encoding(UTF-8)","$file2" or die "I cant open the file tt2002 for writing";
while(<RHANDLE>){
  chomp;
  $_ =~  s//muu/g;  
  $_ =~  s//mu/g;
  $_ =~  s//ri/g;
  my $temp_sentence = $_;
  for(my $i=0;$i<=$#key;$i++){
    $key[$i] =~ s/\s//g;
    $value[$i] =~ s/\s//g;
    $temp_sentence =~ s/$key[$i]/$value[$i]/g;
  }
  print WHANDLE "$temp_sentence"."\n";
}
close RHANDLE;
close WHANDLE;
#print "Done";
######################################################################
open INP,"<:encoding(UTF-8)","$file2" or die "I cant open the file $file2 for reading";
##--------------------------------------------------------------------------------------------First WHILE INP
while(<INP>)
{
$temp=0;
$inputword=$_;

open THREE,"<:encoding(UTF-8)","$three" or die "I cant open the file $three for reading";
while(<THREE>)
{
chomp;
$thr=$_;
if($inputword =~m/$thr$/)
{
$paradimno="-25-6";
$temp=1;
last;
}
}
###########
if($temp==0)
{
open FOUR,"<:encoding(UTF-8)","$four" or die "I cant open the file $three for reading";
while(<FOUR>)
{
chomp;
$thr=$_;
if($inputword =~m/$thr$/)
{
$paradimno="-25-8";
$temp=1;
last;
}
}
}
###########
if($temp==0)
{
open PADI,"<:encoding(UTF-8)","$padi" or die "I cant open the file  for reading";
while(<PADI>)
{
chomp;
$paad=$_; 
chomp($inputword);
if($inputword =~ m/$paad$/)
{
print " PADI ENTERED ";
$paradimno="-25-N";
$temp=1;
last;
}#if
}#-------------------------------------------------------------------------------------------------while PADI
open WADA,"<:encoding(UTF-8)","$wada" or die "cant open for reading";
while(<WADA>)
{
chomp;
$waada=$_;
if($inputword =~ m/$waada$/)
{
if($temp==1)
{
$paradimno =~ s/-N/-26/;
}#if
else{
$paradimno ="-26-N";
}#else
$temp=1;
last;
}#main if
}#---------------------------------------------------------------------------------WHILE WADA
if($temp==0)
{
open RPAR,"<:encoding(UTF-8)","$rpar" or die "I cant open the file  for reading";
while (<RPAR>)
{
chomp;
my $rpar1=$_;
($r,$h)=split ( / /,$rpar1);
if($inputword =~ m/$r$/)
{
$paradimno=$h;
last;
}
else
{
$paradimno="Nill";
}
}
}
}
#-----------------------------------------------------------------------------------------WHILE RPAR
#-----------------------------------------------------------------------------------------if temp==$paradimno0
#$parnum[$ite]=$paradimno."_".$inputword;\
$parnum[$ite]=$paradimno."\n";
$ite++;
($temp1[0],$temp1[1],$temp1[2])=split(/-/,$paradimno);
open RPAR1,"<:encoding(UTF-8)","$rparmod" or die "I cant open the file  for reading";
while(<RPAR1>){
  chomp;
  ( $key1[$iter], $value1[$iter] ) = split /\s/;
  $iter++;
}
$word[$it]=$inputword;
$it++;
}
close INP;
#$outfile="temp_p_num.txt";
open (OUTFILE, ">$outfile") or die "Cannot open $outfile for writing \n";
print OUTFILE @parnum;
close OUTFILE;
#-------------------------------------------------------------------------------------------------------------------------------#
my $outfile1="perl/modroot.txt";
open (OUTFILE1, ">$outfile1") or die "Cannot open $outfile1 for writing \n";
print OUTFILE1 @word;
close OUTFILE1;
close PADI;
close WADA;
close RPAR;
#########-----------Adding Inflections Converting in to Tamil----------------------------####################
########to retrive######
##########################Data are Xed to variables
my $fil="perl/verb_conj.csv";#database_new.csv";#verbconj.csv";
my $finalout="perl/finalout.txt";
my @dat;
#my $i=1;
#my @aa;
open RH,"<:encoding(UTF-8)","$fil" or die "I cant open the file map for reading";
open WH,">:encoding(UTF-8)","$finalout" or die "I cant open the file map for reading";

my $row=1;
while(<RH>)
{
  chomp;
my $line=$_;
@aline=split(",",$line);
for($col=0;$col<=$#aline;$col++)
{
$dat[$row][$col]=$aline[$col];
}
$row++;
}
#################################
my $end= $value1[$temp1[1]];
my $coln=$temp1[1];
my @intr=("8","26","6","4","19","15");#@
my @tran=("25","12","30");#+
 if ($inputword =~ m/\@/)
{
for(my $t=0;$t<=$#intr;$t++)
{ 

#print "TEMP.$temp1[2]";
if($intr[$t] eq ( $temp1[2] || $temp1[1] ) )
{
$end= $value1[$intr[$t]];
$coln=$intr[$t];
#print "$temp1[2]\n";
}}}

my $mli;
my $inpw;
my $inpw1;
$inpw=$inputword;
$inpw1=$inpw;
#my $end= $value1[$temp1[1]];

if($end eq "*")
{}
else{
$inpw=~s/$end$//;
}
###########sent
=pod

if($temp1[2] ne "N")
{

$end= $value1[$temp1[2]];

if($end eq "*")
{}
else{
$inpw1=~s/$end$//;
}

chomp($inpw1);
open SE,"<:encoding(UTF-8)","$sef" or die "I cant open the file for writing";
while(<SE>)
{
$mli=$_;
#print WH $inpw1.$dat[$mli][$temp1[2]]."\n";
}
close SE;
=cut


chomp($inpw);
#open SE,"<:encoding(UTF-8)","$sef" or die "I cant open the file for writing";

#while(<SE>)
#{
  
#$mli=$_;
print WH $inpw.$dat[$mlenum][$coln]."\n";
#print $inpw.$dat[$mli][$temp1[1]]."\n";
#}
#close SE;
close RH;
close WH;
######################Convert into Unicode##############
#open WH1,"<:encoding(UTF-8)","$fileout" or die "I cant open the file map for reading";
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
}
close INP;
close OUTP;
#print "Done";
####################################################
close PARMOD;
close PARNO;
close PARMOD1;
#########--------------------------------------------------------------###################

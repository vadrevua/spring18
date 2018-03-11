#Aditya Vadrevu
#Programming Assignment 3
#POS Tagger Due 3/12/18
#CMSC 416
use strict;
use warnings;
# /"(\[)|(" ")|(\])"/
use Data::Dumper qw(Dumper);
my @trainArr;
my @testArr;
my $readingString;
my %trainingHash;
my $train;
my $test;

if($#ARGV == 1){
  $train = $ARGV[0];
  $test = $ARGV[1];
  if(((substr $train, -4) eq "\.txt") && ((substr $test, -4) eq "\.txt")){
  }
  else{
    exit;
  }
}
else{
  exit;
}

my $filename = $train;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
  chomp $row;
  my @words = split /\]|\[|\s+/, $row;
  foreach my $val (@words){
    if($val eq ""){
      next;
    }
    else{
      push(@trainArr, $val);
    }
  }
}

foreach my $wordTag (@trainArr){
  my $word;
  my $tag;
  my $slashWord;
  my $secWord;
  if($wordTag =~ m/\\\//){
    ($word, $slashWord) = split/\\/, $wordTag;
    my $update = substr $slashWord, 1;
    ($secWord, $tag) = split/\//,$update;
    # print "$secWord\n"
    $word = "$word/$secWord";
  }
  else{
    ($word, $tag) = split/\//, $wordTag;
  }

  if($trainingHash{$word}{$tag}){
    $trainingHash{$word}{$tag}++;
  }
  else{
    $trainingHash{$word}{$tag} = 1;
  }
}
# print Dumper \%trainingHash;


$filename = $test;
open($fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
  chomp $row;
  my @testwords = split /\]|\[|\s+/, $row;
  foreach my $val (@testwords){
    if($val eq ""){
      next;
    }
    else{
      push(@testArr, $val);
    }
  }
}
foreach my $woe (@testArr) {
  print "$woe\n";
}

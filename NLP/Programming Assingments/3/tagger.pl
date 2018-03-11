#Aditya Vadrevu
#Programming Assignment 3
#POS Tagger Due 3/12/18
#CMSC 416
use strict;
use warnings;
# /"(\[)|(" ")|(\])"/
my @wordsArr;
my $readingString;
my %hash;
my %totalhash;
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
        push(@wordsArr, $val);
      }
    }
  }

foreach my $wordTag (@wordsArr){
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

    %hash = ($tag,$word);
  # print "$tag\n";
}
print %hash;

#Aditya Vadrevu
#Programming Assignment 3
#POS Tagger Due 3/12/18
#CMSC 416
use strict;
use warnings;
use Data::Dumper qw(Dumper);
use Math::Round qw(nearest);
my @inputArr;
my @keyArr;
my %matrixHash;
my $input;
my $key;

#This if/else block is to check if the values inputted from console contain 2 files that end in .txt if they dont then it exits the program
if($#ARGV == 1){
  $input = $ARGV[0];
  $key = $ARGV[1];
  if(((substr $key, -4) eq "\.txt") && ((substr $input, -4) eq "\.txt")){
  }
  else{
    exit;
  }
}
else{
  exit;
}

my $filename = $key;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
#This while reads in the training file and splits the file by [] and spaces. the Word/Tag combo are then saved in an array for later manipulation
while (my $row = <$fh>) {
  chomp $row;
  my @words = split /\]|\[|\s+/, $row;
  foreach my $val (@words){
    if($val eq ""){
      next;
    }
    else{
      push(@keyArr, $val);
    }
  }
}

$filename = $input;
open($fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
  chomp $row;
  my @inputWords = split /\]|\[|\s+/, $row;
  foreach my $val (@inputWords){
    if($val eq ""){
      next;
    }
    else{
      push(@inputArr, $val);
    }
  }
}

my $counter = 0;
my $wrongCounter = 0;
for (my $var = 0; $var < $#inputArr; $var++) {
  if($inputArr[$var] eq $keyArr[$var]){
    $counter++;
  }
  else{
    addHash($inputArr[$var],$keyArr[$var]);
    $wrongCounter++;
  }
}
my $accuracy = ($counter/($counter+$wrongCounter))*100;
my $roundedAcc = nearest(.01,$accuracy);
print "Accuracy: $roundedAcc\n";
print Dumper \%matrixHash;


sub addHash{
  my ($inputStr, $keyStr) = @_;
  my $inTagW;
  my $inTag;
  my $keyTag;
  my $keyTagW;
  my $slashWord;
  my $secWord;
  if($inputStr =~ m/\\\//){
    ($inTagW, $slashWord) = split/\\/, $inputStr;
    my $update = substr $slashWord, 1;
    ($secWord, $inTag) = split/\//,$update;
  }
  else{
    ($inTagW, $inTag) = split/\//, $inputStr;
  }
    if($keyStr =~ m/\\\//){
      ($keyTagW, $slashWord) = split/\\/, $keyStr;
      my $update = substr $slashWord, 1;
      ($secWord, $keyTag) = split/\//,$update;
    }
    else{
      ($keyTagW, $keyTag) = split/\//, $keyStr;
    }
    if($matrixHash{$keyTag}{$inTag}){
      $matrixHash{$keyTag}{$inTag}++;
    }
    else{
      $matrixHash{$keyTag}{$inTag} = 1;
    }

}

#Aditya Vadrevu
#Programming Assignment 3
#DecisionList Due 3/26/18
#CMSC 416

#ALGOTHRM OVERVIEW:
# I first check to see if the input from the command line is satisfactory and then proceed to process the first file that is inputted.
#I split is key file by [] and white spaces and store it into an array called @keyArr
#Then I take the input file and store that into an array called @keyArr
#I check to see if the values are the same as well as incrementing and adding values to a hash
#then I print out the hash like a confusion matrix and the overall accuracy

#SAMPLE INPUT:
#perl scorer.pl pos-test-with-tags.txt pos-test-key>pos-tagging-report.txt
#perl scorer.pl *tagger output file* *test key File*

#SAMPLE OUTPUT:
# Accuracy: 58.06
#         phone   products
#phone      63       45
#product    7         9


use strict;
use warnings;
use Data::Dumper qw(Dumper); #to print out the hash as a confusion matrix
use Math::Round qw(nearest); #to properly format the accuracy
my @inputArr; #array of word/tag
my @keyArr; #array of correct word/tag
my %matrixHash;
my $input;#Soon to be file name for input data
my $key;#Soon to be file name for key data


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
#This while reads in the key file and splits the file by [] and spaces. the Word/Tag combo are then saved in an array for later manipulation
while (my $row = <$fh>) {
  chomp $row;
  my @words = split /\n/, $row;
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
#This while reads in the input file and splits the file by [] and spaces even though there are no [] I left it the same.
  #the Word/Tag combo are then saved in an array for later manipulation
while (my $row = <$fh>) {
  chomp $row;
  my @inputWords = split /\n/, $row;
  foreach my $val (@inputWords){
    if($val eq ""){
      next;
    }
    else{
      push(@inputArr, $val);
    }
  }
}

my $phcounter = 0; #initialize correctly tagged words counter
my $wrongphCounter = 0; #initialize correctly tagged words counter
my $procounter = 0; #initialize correctly tagged words counter
my $wrongproCounter = 0; #initialize correctly tagged words counter


#this for loop iterates from 0 to the length of the input array
for (my $var = 0; $var < $#inputArr; $var++) {

  my $inputValue = substr($inputArr[$var], -8, -3);
  my $keyValue = substr($keyArr[$var], -8, -3);

  if($inputValue eq $keyValue && ($inputValue eq "phone" && $keyValue eq "phone")){
    $phcounter++;
  }
  elsif($inputValue eq $keyValue && ($inputValue eq "oduct" && $keyValue eq "oduct")){
    $procounter++;
  }
  elsif($inputValue eq "phone" && $keyValue eq "oduct"){
    $wrongphCounter++;
  }
  elsif($inputValue eq "oduct" && $keyValue eq "phone"){
    $wrongproCounter++;
  }
}

my $acc = ($phcounter+$procounter)/($phcounter+$procounter+$wrongphCounter+$wrongproCounter);

print "Accuracy:$acc\n";

print "\tphone\tproduct\nphone\t$phcounter\t$wrongphCounter\nproduct\t$wrongproCounter\t$procounter\n";

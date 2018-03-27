#Aditya Vadrevu
#Programming Assignment 3
#POS Tagger Due 3/12/18
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
# Accuracy: 88.07
# $VAR1 = {
#           'EX' => {
#                     'EX' => 57
#                   },
#           '$' => {
#                    'NNP' => 4,
#                    '$' => 371
#                  },
#           'CD' => {
#                     'CD' => 1926,
#                     'NNP' => 7,
#                     'NN' => 2
#                   },
#           'RBS' => {
#                      'JJS' => 30
#                    },
#           'RB|JJ' => {
#                        'RB' => 2
#                      },
#           'JJ|IN' => {
#                        'NNP' => 1
#                      }


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
#This while reads in the input file and splits the file by [] and spaces even though there are no [] I left it the same.
  #the Word/Tag combo are then saved in an array for later manipulation
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

my $counter = 0; #initialize correctly tagged words counter
my $wrongCounter = 0; #initialize correctly tagged words counter
#this for loop iterates from 0 to the length of the input array
for (my $var = 0; $var < $#inputArr; $var++) {
  #if the arrays aren't the same length then it will quit the program
  if($#inputArr != $#keyArr){
    print "Error exiting due to both files not being identical";
    exit;
  }
  #this if/else goes through the values of the input array and checks to see if the input word/tag combo are equal to the key word/tag combo
  if($inputArr[$var] eq $keyArr[$var]){
    addHash($inputArr[$var],$keyArr[$var]);
    $counter++;
  }
  else{
    addHash($inputArr[$var],$keyArr[$var]); #subroutine functionality listed down below
    $wrongCounter++;
  }
}
my $accuracy = ($counter/($counter+$wrongCounter))*100; #calculates accuracy and multiplies by 100
my $roundedAcc = nearest(.01,$accuracy); #rounds to Hundreths places
print "Accuracy: $roundedAcc\n"; # prints accuracy
print Dumper \%matrixHash; #prints confusion matrix as raw hash
#This method splits the words and tags for both input and key Data
#then adds the key values to the key hash

#Like tagger.pl i am first checking to see if a '/' is present in the word so it doesn't cut up the tag eg. 1/2 is printed as 1\/2/(tag) for both Input and Key
#Lastly I am taking in the Key tag and the input tag and adding it to a hash.
sub addHash{
  my ($inputStr, $keyStr) = @_;
  my $inTagW; my $inTag;
  my $keyTag; my $keyTagW;
  my $slashWord; my $secWord;
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
    #if(they key => input tag exists then it increments else it adds key tag=> input tag to hash
    if($matrixHash{$keyTag}{$inTag}){
      $matrixHash{$keyTag}{$inTag}++;
    }
    else{
      $matrixHash{$keyTag}{$inTag} = 1;
    }

}

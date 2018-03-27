#Aditya Vadrevu
#Programming Assignment 3
#POS Tagger Due 3/12/18
#CMSC 416

#ALGORITHM OVERVIEW:
# I first check to see if the input from the command line is satisfactory and then proceed to process the first file that is inputted.
#The first file I split by [] and white spaces and store it into an array called @inputWords
#Then I take that array and split the values into tags and words and store them into a hash sorted by words=>tags
#After that I read in the test file and split words by [] and white spaces
#Then I read in each word in the array
#I apply some rules and some tag values if needed then print word with tags.

#SAMPLE INPUT:
#perl tagger.pl pos-train.txt pos-test.txt>pos-test-with-tags.txt
#perl tagger.pl *Training file* *Testing File*

#SAMPLE OUTPUT:
# No/DT
# ,/,
# it/PRP
# was/VBD
# n't/RB
# Black/NNP
# Monday/NNP
# ./.
# But/CC

use strict;
use warnings;
use Data::Dumper qw(Dumper); #to print out hash for debugging purposes
my $train; #Soon to be file name for training data
my $test; #Soon to be file name for test data
my @trainArr; #word/tag array from training file
my @testArr;  #word array from test file
my @tagList = qw(CC CD DT EX FW IN JJ JJR JJS LS MD NN NNS NNP NNPS PDT POS PRP PP$
                 RB RBR RBS RP SYM TO UH VB VBD VBG VBN VBP VBZ WDT WP WP$ WRB
                 # $ . , : ( ) "" `` ''); #tag list to check if word contains tag in the hash

my %trainingHash;


#This if/else block is to check if the values inputted from console contain 2 files that end in .txt if they dont then it exits the program
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

#This while reads in the training file and splits the file by [] and spaces. the Word/Tag combo are then saved in an array for later manipulation
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

#This foreach splits the Word/Tag combo into seperate word and tag values
foreach my $wordTag (@trainArr){
  my $word;
  my $tag;
  my $slashWord;
  my $secWord;
  #If checks to see if a / is present in the word so it doesn't cut up the tag eg. 1/2 is printed as 1\/2/(tag)
      #so when split regularly we end up with 1 as the word and 2 as the tag the if will split twice and add the 2 parts together and seperate the tag
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

  #if the combo of word and tag have been seen before then the value is incremented else initialize the value at 1
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

#same as above but reading in the test file and it is saved as just the word.
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

#this is a nested foreach where the first one pulls the word from the test file array and sets the default tag to NN
#then the second checks the tag list to see if the word/tag combo exists in the array
foreach my $keyword (@testArr) {
  my $countVar = 0;
  my $mostTagged = "NN";
  foreach my $tagger(@tagList){
    #the if checks to see if the word/tag combo exists without trowing uninitalized value errors
    if($trainingHash{$keyword}{$tagger}){
      #if value of one key is higher than the counter then update counter with number and tag
      if($trainingHash{$keyword}{$tagger} > $countVar){
        $countVar = $trainingHash{$keyword}{$tagger};
        $mostTagged = $tagger;
      }
    }
  }
   #rule 1 (IF THE WORD CONTAINS A NUMBER IT IS A CARDINAL NUMBER)
  if($keyword =~ m/[0-9]/){
    $mostTagged = "CD";
  }
   #rule 2 (IF THE FIRST LETTER IS CAPITALIZED AND IS NN BECAUSE IT HASN'T BEEN SEEN THEN IT IS A PROPER NOUN)
  elsif($keyword =~ m/^[A-Z]/ && $mostTagged eq "NN"){
    $mostTagged = "NNP";
  }
   #rule 3 (IF A WORD ENDS IN -LY THEN IT IS AN ADVERB)
  elsif($keyword =~ m/\w+ly/){
    $mostTagged = "RB";
  }
  #rule 4 (IF A WORD IS A NOUN AND ENDS IN AN S THEN IT IS A PLURAL NOUN)-----------------Decreases accuracy therfore commented out---------------------
  # elsif($keyword =~ m/\w+s/ && $mostTagged eq "NN"){
  #   $mostTagged = "NNS";
  # }
  #rule 5 (IF (of,to,in,for,on) IS IN THE STRING THEN IT IS A PREPOSITION)-----------------Decreases accuracy therfore commented out---------------------
  # elsif($keyword =~ m/(of)|(to)|(in)|(for)|(on)/){
  #   $mostTagged = "IN";
  # }

  #PRINT OUT TO CONSOLE
print "$keyword/$mostTagged\n";
}

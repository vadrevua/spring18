#!/usr/local/bin/perl –w
#Aditya Vadrevu
#Natural Language Processing CMSC 416
#Due date 2/19/2018
#Description of Problem: I am trying to create randomly generated sentances from various text files. Using "n-grams" specified by the user I am trying to create sentences that make sense.
#Program input: Perl ngram.pl n m (any number of Filenames)
    # n is how big of an n-gram that should be mused
    # m is how many randomly generated sentences you wants
    # (any number of Filenames) add any amount of files you would like. Filenames and extentions for example 1399.txt

#Algorithm
  #Firstly I take in the user inputed
  #Next I read in the text files the user inputted if all other inputs are correct.
  #After I read the text files I split the text files on . ? and !
  #Then I split the sentence array into word arrays
  #I create 2 different arrays 1 for ngrams and one for n-1 gram inorder to properly calculate relative frequency
  #I add both arrays into 2 $hashkeys
  #Then sort Both
  #Inorder to come up with random sentences I was unable to use relative frequencies
  #I created a random sentence using the sorted hash keys from the hash table
  #print the random sentences

use strict;
use warnings;
my @wordsArr;
my @lines;
my @totalArray;
my @nstrArr;
my @n_1strArr;
my $numArgs = $#ARGV - 2;
my $totalArgs = $#ARGV;
my $n = $ARGV[0];
my $m = $ARGV[1];
my %nHash = ();
my %n_1Hash = ();
if($totalArgs <= 0){#checks to see if the user inputed parameters
print "Please restart program and enter parameters\n(Number of files, Number of random sentences, Textfile name)\n";
exit;
}
else{
  if($ARGV[0] <= 0){#checks to see if n-Gram inputted by user is greater than 0
  print "Please restart program and enter valid number of ngrams\n";
  exit;
}
if($ARGV[1] <= 0){#checks to see if number of random sentences inputted by user is greater than 0
print "Please restart program and enter atleast 1 random sentence\n";
exit;
}
}
print "This Program Generates random sentences based on an Ngram Model\nCoded by Aditya Vadrevu\nCommand Line Settings: Ngram.pl $ARGV[0] $ARGV[1]\n";
print "\n";
while($numArgs >= 0) { #this loop takes in each file 1 by one and splits into sentences
my $filename = $ARGV[$numArgs+2];
my $contents = do { local(@ARGV, $/) = $filename; <> };
my @lines = split /[\.\?\!]/, $contents; #this only splits sentences by using . ? or ! sentences still contain \n characters
push(@totalArray, @lines);
$numArgs--;
}
my @arrarr; #A word array to build from the sentences array
for(my $arrNum = 0; $arrNum < $#totalArray; $arrNum++){ #splits sentences into word arrays
  my @tempArr = split /\s+/, $totalArray[$arrNum];
  push (@arrarr, @tempArr);
}
for(my $word = 0; $word < $#arrarr; $word++){ #this loop adds words into the string arrays for the ngram and the n_1gram
  $arrarr[$word] = lc($arrarr[$word]);
  if(defined $arrarr[$word+$n]){ #if the term has a value in the element +N of the value its true
    my $nString = "";
    my $n_1String = "";
    for(my $a = 0; $a<$n; $a++){
      $nString .= "$arrarr[$word+$a] ";
      push (@nstrArr, $nString);
    }
    for(my $b = 0; $b<$n-1; $b++){
      $n_1String .= $arrarr[$word+$b];
      push (@n_1strArr, $n_1String);
    }
  }
}
# print $#nstrArr;
# print "\n$#n_1strArr\n";
foreach my $nHashString (@nstrArr){
  # print "$nHashString\n";
  $nHash{$nHashString}++;
}
foreach my $n1HashString(@n_1strArr){
  $n_1Hash{$n1HashString}++;
}
foreach my $word(sort {$nHash{$b} <=> $nHash{$a}} keys %nHash){
  #print "$word : $nHash{$word}\n";
}
foreach my $word(sort {$n_1Hash{$b} <=> $n_1Hash{$a}} keys %n_1Hash){
  #print "$word : $n_1Hash{$word}\n";
}
my @hashkeys = keys %nHash;
while($m > 0){ #this loop produces output, using user input number of sentences
  my $sentance = "";
  my $numWords = (int(rand(10)));
  for(my $i = 0; $i<$numWords; $i++){
  my $randomHashKey = $hashkeys[rand@hashkeys];
  $sentance .= "$randomHashKey";
}
  $sentance .= "\.\n";
  print $sentance;
  $m--;
}

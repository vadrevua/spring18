#Aditya Vadrevu
#Programming Assignment 5
#DecisionList Due 4/16/18
#CMSC 416

#ALGORITHM OVERVIEW:
#first I take in input from user
#split up the input into an array and strip out the @words
#then I call Wikipedia with the search words and return what I got
#i then parse the answer and print what matches the input most correctly



#---------EXTRA INFO---------------#
#I was unable to fully grasp how to do this assignment and as a result I have not done too well on the answers,
#only what seems to work properly and everything else either crashes or produces shoddy output.

#SAMPLE INPUT:
#what is a car
#DO not put punctuation

#SAMPLE OUTPUT:
#A car is a is a wheeled motor vehicle used for transportation.



use strict;
use warnings;
use WWW::Wikipedia;

my $continueVar = 0;
my @words = ("is", "are", "a", "were", "the");
my $wiki = WWW::Wikipedia->new();
print "This is a QA system by Aditya Vadrevu. It will try to answer questions that start with Who, What, When or Where. Enter \"exit\" to leave the program.\n";

while($continueVar == 0){
  my $response;
  my $userQuestion = <STDIN>; #Gets user input
  chomp $userQuestion;
  my @sentenceArr = split / /, $userQuestion;
  my @ss = stripContext(@sentenceArr);
  my $query = "";
  my $temp = "@ss";
  $query = substr "@ss", 4;
  my @queryArr = split /\s+/, $query;
  my @qArr = grep(s/\s*$//g, @queryArr);
  $response = askWiki($query);
  $response = lc($response);
  $response =~s/[\! \? \- \< \> \{ \} \* \[ \] \= \| \/ \' \"]/ /g;
  my @split = split /[\.\n]/, $response;
  my @full = grep(s/\s*$//g, @split);


  if($sentenceArr[0] eq "exit"){
    print "Thank you, Good Bye!";
    $continueVar = 1;
    exit;
  }
  elsif($sentenceArr[0] eq "who" || $sentenceArr[0] eq "what" ||$sentenceArr[0] eq "when"||$sentenceArr[0] eq "where"){
    my @almostAns;
    my $finalAns;
    my $counter = 0;
    for(my $fullCount = 0; $fullCount < $#full; $fullCount++) {
      for(my $num = 0; $num <= $#qArr; $num++) {
        if (index($full[$fullCount],$qArr[$num])!= -1) {
          # print "::WORKING:: $full[$fullCount]\n";
          $counter++;
        }
        if($counter == $#qArr+1){
          push @almostAns, $full[$fullCount];
        }
      }
      $counter = 0;
    }
    # hard coded in values because I could not figure out how to parse properly
    if($sentenceArr[0] eq "what"){
      $finalAns = $almostAns[1];
    }elsif($sentenceArr[0] eq "who"){
      $finalAns = $almostAns[1];
    }elsif($sentenceArr[0] eq "when"){
      $finalAns = $almostAns[4];
    }else{
      $finalAns = $almostAns[0];
    }
    print "$finalAns\n";
  }
  else{
    print "I am sorry, I dont understand the question\n";
  }
}




sub stripContext{ #strip the @words out of the input to get query
  my(@sentence) = @_;
  my @stripped;
  my $valid = 0;
  foreach my $x (@sentence) {
    $valid = 0;
    foreach my $y(@words){
      if($x eq $y){
        $valid = 1;
      }
    }
    if($valid == 0){
      push @stripped, $x;
    }
  }
  return @stripped;
}

sub askWiki { #actual query of Wikipedia and returns raw answer
  my ($question) = @_;
  my $entry = $wiki->search($question);
  my $ans = $entry->fulltext();
  return $ans;
}

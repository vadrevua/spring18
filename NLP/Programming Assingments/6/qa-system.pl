#Aditya Vadrevu
#Programming Assignment 6
#qa-system Due 4/30/18
#CMSC 416

#ALGORITHM OVERVIEW:
#I redid assignment 5 because the query reformation wasn't good
#Expanded on assignment 5 by adding a feature where if no proper terms were found then it would check the "See Also section in Wikipedia"
#the way I keep track of accuracy is if it obtains the info first try then it recieves 1 and goes down by increments of .5 every retry.


#extra-----------------------------
#run by perl qa-system.pl
#input who what where when question.
#example
    #sample input: What is a car?
    #sample output: A car is a wheeled motor vehicle used for transportation.

use strict;
use warnings;
use WWW::Wikipedia;

my $continueVar = 0;
my $wiki = WWW::Wikipedia->new();
my $acc = 1.0;
print "This is a QA system by Aditya Vadrevu. It will try to answer questions that start with Who, What, When or Where. Enter \"exit\" to leave the program.\n";

while($continueVar == 0){#continues till exit var is typed
  my $response;
  my $userQuestion = <STDIN>; #Gets user input
  chomp $userQuestion;

  if($userQuestion=~/^who\s+.+$/i){#checks to see if it is a who question
    if($userQuestion=~/who\s+is\s+([^\?]*)/i || $userQuestion=~/who\s+was\s+([^\?]*)/i){#gets rid of useless words and gets word to search.
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"who");#goes to ask wiki method
      print "$result With an accuracy of $acc\n"; #prints output
      print "\nAsk another question\n";
      $acc = 1.0; #resets accuracy
    }
  }
  elsif($userQuestion=~/^what\s+.+$/i){
    if($userQuestion=~/what\s+is\s+([^\?]*)/i || $userQuestion=~/what\s+was\s+([^\?]*)/i || $userQuestion=~/what\s+are\s+([^\?]*)/i ){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"what");
      print "$result With an accuracy of $acc\n";
      print "\nAsk another question\n";
      $acc = 1.0;
    }
  }
  elsif($userQuestion=~/^where\s+.+$/i){
    if($userQuestion=~/where\s+is\s+([^\?]*)/i || $userQuestion=~/where\s+was\s+([^\?]*)/i){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"where");
      print "$result With an accuracy of $acc\n";
      print "\nAsk another question\n";
      $acc = 1.0;
    }
  }
  elsif($userQuestion=~/^when\s+.+$/i){
    if($userQuestion=~/when\s+is\s+([^\?]*)/i || $userQuestion=~/when\s+was\s+([^\?]*)/i){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"when");
      print "$result With an accuracy of $acc\n";
      print "\nAsk another question\n";
      $acc = 1.0;
    }
  }
  elsif($userQuestion=~/exit|quit|bye/i){
    print "See ya Later!";
    exit;
  }
  else{
    print "Sorry I didn't understand your question, Try again."
  }
}

sub askWiki { #actual query of Wikipedia and returns answer
my $question = $_[0];
my $context = $_[1];
my $ans;
my $entry = $wiki->search($question); #searches wiki for the input word
if($entry){ #if it worked then it will store the answer in $ans
  $ans = $entry->fulltext();
}else{return "Sorry could not find the answer to your question\n";}
return getAns($ans, $context,$question); #goes to getAns Method.
}

sub getAns {
  my $ans = $_[0];
  my $context = $_[1];
  my $question = $_[2];
  if($context eq "who"){#checks to see if context is who
    if($ans =~/(^[\S]*\'$question\'[^.]* is [^.]*\.)/i || $ans =~/([^\S]*[\']?$question[\']?[^.]* was [^.]*\.)/i){ #sorts through text to find "$question is/was"
    #if it present in the text then it stores the sentence in $ans and returns it
      $ans = $1;
      # print $ans;
      return $ans;
    }
    else{#if it is not present then goes on to the extend method.
      return(extend($ans));
    }
  }
  elsif($context eq "when"){
    if($ans =~/([^\S]*[\']?$question[\']?[^.]* celebrated on [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is on [^.]*\.)/i){
      $ans = $1;
      # print $ans;
      return $ans;
    }
    else{
      return(extend($ans));
    }
  }
  elsif($context eq "where"){
    if($ans =~/([^\S]*[\']?$question[\']?[^.]* located [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is [^.]*\.)/i){
      $ans = $1;
      # print $ans;
      return $ans;
    }
    else{
      return(extend($ans));
    }
  }
  elsif($context eq "what"){
    if($ans =~/([^\S]*[\']?$question[\']?[^.]* was [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is [^.]*\.)/i){
      $ans = $1;
      # print $ans;
      return $ans;
    }
    else{
      return(extend($ans,"what"));
    }
  }
  else{
    return "Sorry could not find the answer to your question. Please try again.";
  }
}

  sub extend { # extend method
    my $extender = $_[0];
    $acc = $acc/2; #decreases the accuracy by half
    if($acc < 0.1){ #if acc reaches below this threshold then exits
      if($extender=~/(\*[\s+?][\w\s+]*]*)/i){ #if case where see also \n * "word" exists
        $extender = substr($extender,2); #chop off *
        my $entry = $wiki->search($extender); #search by see also word
        if($entry){
          my $text = $entry->fulltext();
          return getAns($text,$_[1],$extender); #search and get answer then return it back to original query.
        }
      }
      return "Sorry could not find the answer to your question. Please try again."; #if it is above threshold then return 
      next;
    }
  }

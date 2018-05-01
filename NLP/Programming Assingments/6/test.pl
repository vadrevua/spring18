use strict;
use warnings;
use WWW::Wikipedia;

my $continueVar = 0;
my $wiki = WWW::Wikipedia->new();
print "This is a QA system by Aditya Vadrevu. It will try to answer questions that start with Who, What, When or Where. Enter \"exit\" to leave the program.\n";

while($continueVar == 0){
  my $response;
  my $userQuestion = <STDIN>; #Gets user input
  chomp $userQuestion;

  if($userQuestion=~/^who\s+.+$/i){
    if($userQuestion=~/who\s+is\s+([^\?]*)/i || $userQuestion=~/who\s+was\s+([^\?]*)/i){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"who");
      print "$result\n";
      print "\nAsk another question\n";
    }
  }
  elsif($userQuestion=~/^what\s+.+$/i){
    if($userQuestion=~/what\s+is\s+([^\?]*)/i || $userQuestion=~/what\s+was\s+([^\?]*)/i || $userQuestion=~/what\s+are\s+([^\?]*)/i ){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"what");
      print "$result\n";
      print "\nAsk another question\n";
    }
  }
  elsif($userQuestion=~/^where\s+.+$/i){
    if($userQuestion=~/where\s+is\s+([^\?]*)/i || $userQuestion=~/where\s+was\s+([^\?]*)/i){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"where");
      print "$result\n";
      print "\nAsk another question\n";
    }
  }
  elsif($userQuestion=~/^when\s+.+$/i){
    if($userQuestion=~/when\s+is\s+([^\?]*)/i || $userQuestion=~/when\s+was\s+([^\?]*)/i){
      my $term = $1;
      if($term=~/^(an|a)\s+(.*)/i){
        $term = $2
      }
      my $result = askWiki($term,"when");
      print "$result\n";
      print "\nAsk another question\n";
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
# print "$question\n";
# print "$context\n";
my $entry = $wiki->search($question);
if($entry){
  $ans = $entry->fulltext();
  print "$ans";
}else{return "Sorry could not find the answer to your question\n";}

if($context eq "who"){
  if($ans =~/(^[\S]*\'$question\'[^.]* is [^.]*\.)/i || $ans =~/([^\S]*[\']?$question[\']?[^.]* was [^.]*\.)/i){
    $ans = $1;
    # print $ans;
    return $ans;
  }
  else{print"Sorry Couldn't answer your question\n";}
}
elsif($context eq "when"){
  if($ans =~/([^\S]*[\']?$question[\']?[^.]* celebrated on [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is on [^.]*\.)/i){
    $ans = $1;
    # print $ans;
    return $ans;
  }
  else{print"Sorry Couldn't answer your question\n";}
}
elsif($context eq "where"){
  if($ans =~/([^\S]*[\']?$question[\']?[^.]* located [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is [^.]*\.)/i){
    $ans = $1;
    # print $ans;
    return $ans;
  }
  else{print"Sorry Couldn't answer your question\n";}
}
elsif($context eq "what"){
  if($ans =~/([^\S]*[\']?$question[\']?[^.]* was [^.]*\.)/i || $ans =~/([^\S]*\'$question\'[^.]* is [^.]*\.)/i){
    $ans = $1;
    # print $ans;
    return $ans;
  }
  else{print"Sorry Couldn't answer your question\n";}
}


}

use strict;
use warnings;
use WWW::Wikipedia;

my $continueVar = 0;
my @words = ("is", "are", "was", "a", "the");
my $wiki = WWW::Wikipedia->new();


while($continueVar == 0){
  my $response;
  my $userQuestion = <STDIN>; #Gets user input
  chomp $userQuestion;
  my $lcUQ = lc $userQuestion;
  my @sentenceArr = split / /, $userQuestion;
  my @ss= stripContext(@sentenceArr);
  my $query = "";
  if($ss[0] eq "what"){
    # my $temp = "@ss";
    $query = substr "@ss", 4;
    $response = askWiki($query);
    chomp $response;
    if($response eq "null"){
      print "I am sorry I dont know what $query is";
    }
    else{
      print $response;
    }
  }elsif($ss[0] eq "who"){
    print "who\n";
  }elsif($ss[0] eq "where"){
    print "where\n";
  }elsif($ss[0] eq "when"){
    print "when\n";
  }elsif($ss[0] eq "exit"){
    print "Thank you, Good Bye!";
    exit;
  }else{
    print "I am sorry, I dont understand the question\n";
  }

  # askWiki($userQuestion);
}




sub stripContext{
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

sub askWiki {
  my ($question) = @_;
  my $entry = $wiki->search($question);
  my $ans = $entry->text();
  my @cutFirst = split /(\}\}) | (\]\])/, $ans;
  my $counter = 0;
  my $countVal = -1;
  foreach my $val (@cutFirst) {
    if($val){
      if($val eq "}}" || $val eq "]]"){
        $countVal = $counter+1;
      }
      else{
        $counter++;
      }
    }
  }
  if($countVal>=0){
    my @result = split /(\.)/, $cutFirst[$countVal];
    return "$result[0]\n";
  }
  else{
    return "null";
  }

}

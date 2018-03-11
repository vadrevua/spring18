#!/usr/local/bin/perl –w
#Aditya Vadrevu
#Natural Language Processing CMSC 416
#Eliza Project
#Key words and Phrases I am looking for
  # "I Feel", "I AM", "I WANT" 'SAD', 'MAD', 'GLAD', 'HAPPY', 'CRAVE'
# TO quit and end type any of these words: "Quit", "End", "Done", "EXIT"



use strict;
use warnings;
my $quitVar = 0; # This variable is to quit and exit the chatbot
my $randNum = 0; # Random number place holder
my $answer = ""; # temporary String to hold user input
print "HELLO I\'M ELIZA.\n";
my $raw_user_input = <STDIN>; #Gets user input
my $inputUpper = uc($raw_user_input); #Capitalize user input

while ($quitVar == 0){ # When user types quit $quitVar is changed to -1 which ends this loop
  if($inputUpper =~ m/(\bHELLO\b)|(\bHI\b)|(\bGOOD\b)/){
    print "WHAT WOULD YOU LIKE TO TALK ABOUT?\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
    if($inputUpper =~ m/\bNOTHING\b/){ #checks if user input matches Nothing, if it does then prints and quits
      print "I GUESS WE ARE DONE HERE. BYE-BYE";
      $quitVar = -1;
    }
  }

  elsif($inputUpper =~ s/(I FEEL)|(MAKES ME)/WHY DO YOU FEEL/){ #checks to see if user inputted is "I Feel" or "Makes Me", then substitutes it to "Why do you feel"
    if($inputUpper=~ m/(\bSAD\b)|(\bMAD\b)/){ # checks to see if Sad or Mad is present in user response
      print "SORRY TO HEAR THAT, ";
      print "$inputUpper\n";
      $raw_user_input = <STDIN>;
      $inputUpper = uc($raw_user_input);
    }
    elsif($inputUpper=~ m/(\bHAPPY\b)|(\bGLAD\b)/){ # checks to see if Happy or Glad is present in user response
      print "GOOD FOR YOU! ";
      print "$inputUpper\n";
      $raw_user_input = <STDIN>;
      $inputUpper = uc($raw_user_input);
    }
    else{
      print "DOES THAT UPSET YOU? ";
      print "$inputUpper\n";
      $raw_user_input = <STDIN>;
      $inputUpper = uc($raw_user_input);
    }
  }

  elsif($inputUpper =~ s/(I AM)|(I'M)/WHY ARE YOU/){ #checks to see if user inputted is "I AM" OR "IM", then substitutes it to "Why are you"
    print $inputUpper;
    print "\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
  }

  elsif($inputUpper =~ m/\bCRAVE\b/){ #checks to see if user input is "Crave"
    print "TELL ME MORE ABOUT YOUR CRAVINGS\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
  }

  elsif($inputUpper =~ m/(\bYES\b)|(\bNO\b)/){#checks user input for yes or No
    $randNum = int(rand(3)); #3 random responses for the input
    if ($randNum == 0){ #if 1 just print are you sure
      $answer = "ARE YOU SURE?";
    }
    elsif ($randNum == 1 && $inputUpper =~ m/\bYES\b/){ # if 2 and input is yes print POSITIVE
      $answer = "YOU ARE QUITE POSITIVE, TELL ME MORE";
    }
    elsif ($randNum == 1 && $inputUpper =~ m/\bNO\b/){ # if 2 and input is no print NEGATIVE
      $answer = "What seems to be the cause of this?";
    }
    elsif ($randNum == 2){# if 3 then print more info
      $answer = "I SEE TELL ME MORE...";
    }
    print "$answer\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
    if($inputUpper =~ s/(\bYES\b)|(\bNO\b)/WHY ARE YOU REPEATING YOURSELF?/){ #MULTIPLE YES OR NO ANSWERS YEILDS wHY ARE YOU REPEATING YOURSELVE
      print $inputUpper;
      $raw_user_input = <STDIN>;
      $inputUpper = uc($raw_user_input);
    }
  }

  elsif($inputUpper =~ s/I WANT/WHY DO YOU WANT/){ #CHANGING WANT INTO AQUESTION
    print $inputUpper;
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
  }

  elsif($inputUpper =~ m/^(BECAUSE)$/){ #JUST ANSWERING BECAUSE DOESN'T RESULT IN RESPONSE
    print "TELL ME MORE...\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
  }

  elsif($inputUpper =~ m/(\bQUIT\b)|(\bEXIT\b)|(\bDONE\b)|(\bEND\b)/){ #QUIT METHOD
    print "TALK TO YOU LATER";
    $quitVar = -1;
  }

  else{ #CATCH ALL RANDOM INPUTS AND OTHERS
    print "I DON\'T UNDERSTAND. PLEASE TRY AGAIN\n";
    $raw_user_input = <STDIN>;
    $inputUpper = uc($raw_user_input);
  }

}

#Aditya Vadrevu
#Programming Assignment 4
#DecisionList Due 3/26/18
#CMSC 416

#ALGORITHM OVERVIEW:
# I first check to see if the input from the command line is satisfactory and then proceed to process the first file that is inputted.
#then I read in the test file line by line storing the classification in an array
#then i read in the sentences and store the proper words in the correct array
# 6 arrays,
  #all words >4 letters for phone and products
  #word before line/s for phone and products
  #word after line/s for phone and products
#read in test file
#store instanceid
#predict classification for before and After

#---------EXTRA INFO---------------#
#I was going to do a 3rd test for this project aside from the 2 listed. I was going to check all words >4 letters in the specific classification
#the problem I was facing is that it took incredibly long because I was running in O(n^3) time. I decided to not use this test anymore and went with the 2.

#SAMPLE INPUT:
#perl decision-list.pl line-train.txt line-test.txt my-decision-list.txt > my-line-answers.txt

#SAMPLE OUTPUT: MyDecision.txt is also outputted
#<answer instance="line-n.w8_059:8174:" senseid="phone"/>
#<answer instance="line-n.w7_098:12684:" senseid="product"/>
#<answer instance="line-n.w8_106:13309:" senseid="phone"/>

use warnings;
use strict;
use Data::Dumper qw(Dumper); #to print out hash for debugging purposes
my $train; #Soon to be file name for training data
my $test; #Soon to be file name for test data
my $decision; #Soon to be file name for my decision list data
my $lastClass;
my @trainData;
my @prodArr;
my @phoneArr;
my @oneAfter;
my @oneBefore;
my @prodOneAfter;
my @prodOneBefore;
my @instID;
my @finalB;
my @finalA;
my @bPredict;
my @aPredict;
my $counter = 0;
# my @finalT;

if($#ARGV == 2){
  $train = $ARGV[0];
  $test = $ARGV[1];
  $decision = $ARGV[2];
  if(((substr $train, -4) eq "\.txt") && ((substr $test, -4) eq "\.txt") && ((substr $decision, -4) eq "\.txt")){
  }
  else{
    exit;
  }
}
else{
  exit;
}


open(my $fh, '<:encoding(UTF-8)', $train)
or die "Could not open file '$train' $!";


while (my $row = <$fh>) {
  chomp $row;
  my @raw = split /\n/, $row;
  foreach my $val (@raw){
    if(substr($val , 1, 10) eq "answer ins"){ #if string value starts with answer, it contains classification so store that.
      $lastClass = substr($val, -8, -3);
    }
    elsif(substr($val , 1, 3) eq "<s>"){ # else if if the <s> tag is present that means this next part is a sentence containing our keyword.
      if($lastClass eq "oduct"){
        my @rawProdArr = split /\s+/, $val;
        foreach my $word (@rawProdArr){
          if(length($word) > 4 || length($word) == 1){
            push @prodArr, $word;
          }
        }
      }
      elsif($lastClass eq "phone"){
        my @rawPhoneArr = split /\s+/, $val;
        foreach my $word (@rawPhoneArr){
          if(length($word) > 4 || length($word) == 1){
            push @phoneArr, $word;
          }
        }
      }
    }
    else{
      next;
    }
  }
} #end of reading in training file

#adding word before and word after to an array (PHONE CASE)
my $lineRead = 0;
my $oneWordB = "";
foreach my $word (@phoneArr){
  if($lineRead == 0){
    if($word eq "<head>line</head>" || $word eq "<head>lines</head>"){
      $lineRead = 1;
      push @oneBefore, $oneWordB;
    }
    else{
      $oneWordB = $word;
      $lineRead = 0;
    }
  }
  else{
      push @oneAfter, $word;
      $lineRead = 0;
    }
}
#adding word before and word after to an array (product CASE)
my $prodOneWordB = "";
foreach my $prodword (@prodArr){
  if($lineRead == 0){
    if($prodword eq "<head>line</head>" || $prodword eq "<head>lines</head>"){
      $lineRead = 1;
      push @prodOneBefore, $prodOneWordB;
    }
    else{
      $prodOneWordB = $prodword;
      $lineRead = 0;
    }
  }
  else{
      push @prodOneAfter, $prodword;
      $lineRead = 0;
    }
}

my $prevWord;
open($fh, '<:encoding(UTF-8)', $test)
or die "Could not open file '$test' $!";
while (my $row = <$fh>) {
  chomp $row;
  my @rawTest = split /\n/, $row;
  foreach my $val (@rawTest){
    if(substr($val , 0, 13) eq "<instance id="){ #if string value starts with instanceid then it stores it to an array.
    push @instID, substr($val, 14, -3);
    }
    elsif(substr($val , 0, 4) eq " <s>" || substr($val , 0, 4) eq " <p>"){
      my @raw = split /<\/context>/, $val;
      foreach my $sentence (@raw){
        predictionBefore($sentence);
        predictionAfter($sentence);
        # predictionTotal($sentence);
      }
    }
  }
}

# foreach my $x (@finalB) {
#   print "$x\n";
# }

predictNPrint();

sub predictionBefore {#this method checks to see if the word before lines is in the before array
  my $sentence = $_[0];
  my @splitWords = split /\s+/, $sentence;
  foreach my $word (@splitWords){
      if($word eq "<head>line</head>" || $word eq "<head>lines</head>"){
        my $prodCounter = 1;
        my $phoneCounter = 1;
        foreach my $variable (@oneBefore){
          if($prevWord eq $variable){
            $phoneCounter++;
          }
        }
       foreach my $var2 (@prodOneBefore){
         if($prevWord eq $var2){
           $prodCounter++;
         }
        }
        #prod/phone
        my $logSense = log($prodCounter/$phoneCounter);
        my $prediction;

        if($logSense>0){
          $prediction = "product";
        }
        elsif($logSense<0){
          $prediction = "phone";
        }
        else{
          $prediction = "Cannot Predict";
        }

        my $finalBvariable = "Feature: Before, Log-Likelyhood Score: $logSense, Prediction: $prediction";
        push (@bPredict, $prediction);
        push (@finalB, $finalBvariable);
    }

    else{
       $prevWord = $word;
      }
    }
}

sub predictionAfter { #this method checks to see if the word after lines is in the after array
  my $sentence = $_[0];
  my @splitWords = split /\s+/, $sentence;
  foreach my $word (@splitWords){
    if($lineRead == 0){
      if($word eq "<head>line</head>" || $word eq "<head>lines</head>"){
        $lineRead = 1;
      }
    }
    if($lineRead == 1){
        my $wordAfter = $word;
        my $prodCounter = 1;
        my $phoneCounter = 1;
        foreach my $variable (@oneAfter){
          if($wordAfter eq $variable){
            $phoneCounter++;
            }
          }
          foreach my $var2 (@prodOneAfter){
           if($wordAfter eq $var2){
             $prodCounter++;
           }
          }
            #prod/phone
          my $logSense = log($prodCounter/$phoneCounter);
          my $prediction;
          if($logSense>0){
            $prediction = "product";
          }
          elsif($logSense<0){
            $prediction = "phone";
          }
          else{
            $prediction = "Cannot Predict";
          }
          my $finalAvariable = "Feature: After, Log-Likelyhood Score: $logSense, Prediction: $prediction";
          push (@aPredict, $prediction);
          push (@finalA, $finalAvariable);
         $lineRead = 0;
    }
  }
}

# sub predictionTotal {
#   my $prodCounter = 1;
#   my $phoneCounter = 1;
#   my $sentence = $_[0];
#   my @splitWords = split /\s+/, $sentence;
#    foreach my $word (@splitWords){
#     if(length($word) > 7){
#       foreach my $pro (@prodArr){
#         if($word eq $pro){
#           $prodCounter++;
#         }
#       foreach my $pho (@phoneArr){
#         if($word eq $pho){
#           $phoneCounter++;
#         }
#       }
#     }
#   }
  #
  # #prod/phone
  # my $logSense = log($prodCounter/$phoneCounter);
  # my $prediction;
  #
  # if($logSense>0){
  #   $prediction = "product";
  # }
  # elsif($logSense<0){
  #   $prediction = "phone";
  # }
  # else{
  #   $prediction = "Cannot Predict";
  # }
  #
  # my $finalTvariable = "Feature: Total, Log-Likelyhood Score: $logSense, Prediction: $prediction";
  # push (@finalT, $finalTvariable);
    # }
  # print "\n$phoneCounter\t $prodCounter\n";
#}

# foreach my $ksk (@finalT){
# print "$ksk\n";
# }

sub predictNPrint { #this is to predict and print the final output to check with key
  for (my $i = 0; $i < $#instID; $i++) {
    my $bTemp = $bPredict[$i];
    my $aTemp = $aPredict[$i];
    my $finalPrediction = "phone";

    if($bTemp eq $aTemp && ($bTemp ne "Cannot Predict" && $aTemp ne "Cannot Predict" && $aTemp ne "")){
      $finalPrediction = $aTemp;
    }
    elsif($bTemp eq "Cannot Predict" && $aTemp ne "Cannot Predict"){
      $finalPrediction = $aTemp;
    }
    elsif($aTemp eq "Cannot Predict" && $bTemp ne "Cannot Predict"){
      $finalPrediction = $bTemp;
    }

    print "<answer instance=\"$instID[$i]:\" senseid=\"$finalPrediction\"/>\n";
  }

}


# #THIS IS TO PRINT OUT TO DECISION LIST FILE

my $filename = $decision;

open(FH, '>', $filename) or die $!;

for (my $i = 0; $i < $#finalA; $i++) {
  print FH "\n$instID[$i]\t$finalA[$i]\n$instID[$i]\t$finalB[$i]\n"
}

close(FH);

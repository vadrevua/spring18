#print "Hello World\n";
#$a = 5;
#$hello = "Hello World\n";
#print $hello;
#print $a . "\n";
#@array = ("Larry", "Curly", "Moe");
#print @array[2]. "\n";
#print @array[3]. "\n";
#print $#array. "\n";
#$array_size = @array;
#print $array_size . "\n";

#!/usr/local/bin/perl
while(<>) {
      chomp;
      @words = split/\s+/;
       foreach $word(@words) {
             if($word=~s/ing$/ed/) {
							print "$word\n";
						 }
       }
}

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

#!/usr/local/bin/perl –w

@unsortedArray = (3,10,76,23,1,54);
@sortedArray = sort numeric @unsortedArray;

# prints 3 10 76 23 1 54
print "@unsortedArray\n";

# prints 1 3 10 23 54 76
print "@sortedArray\n";

sub numeric { $a <=> $b }

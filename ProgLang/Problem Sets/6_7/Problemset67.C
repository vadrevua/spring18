# include <stdio.h>
#include <stdlib.h>
#include <string.h>

gcd(int *a, int *b){
    int r = *b;
    while(r != 0){
        *b = r;
        r = *a % *b;
        *a = *b;
    }
}


main() {
char str[999];
FILE * file;
file = fopen( "chap6_7File.txt" , "r");
if (file) {
    while (fgets(str, 255,(FILE*)file)!= NULL){
        char *value = strtok(str, " ");
        int aval = atoi(value);
        value = strtok(0, " ");
        int bval = atoi(value);
        gcd(aval,bval);
        printf(*b);
    }
    fclose(file);
}


}
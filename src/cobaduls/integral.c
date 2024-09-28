#include <io.h>
#include <stdio.h>
#include <math.h>

//                                ==RUMUS PENJUMLAHAN LOOP==
int main(){
    int a = 0;
    int b = 4;
    int i, sum = 0;
    for(i=a;i<b;i++){
        sum = sum + i;
    }
    return sum;
}


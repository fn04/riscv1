#include <io.h>
#include <stdio.h>
#include <math.h>

int faktorial(int x) {
    int hasil = 1;
    for (int i = 1; i <= x; i++) {
        hasil *= i;
    }
    return hasil;
}

int main(){
    int n = 4;
    int jadi = faktorial(n);
    return jadi;
}
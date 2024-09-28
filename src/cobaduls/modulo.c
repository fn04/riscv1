#include <io.h>
#include <stdio.h>
#include <math.h>

int main() {
    int a = 40;
    int b = 7;
    int i;
    int c = 0;
    int d = b;

    for (i = 2; a >= d; i++) {
        c = a - d;
        d = b * i;
    }
    // return i-2; //hasil pembagian
	return c; //nilai modulo
}
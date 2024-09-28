#include <io.h>
#include <stdio.h>
#include <math.h>



//                                ==RUMUS PERMUTASI==
// Fungsi untuk menghitung faktorial dari suatu angka
int faktorial(int x) {
    int hasil = 1;
    for (int i = 1; i <= x; i++) {
        hasil *= i;
    }
    return hasil;
}

int main() {
    int n = 6;
    int r = 2;

    int atas = faktorial(n);        // n!
    // int bawah = faktorial(n - r);   // (n - r)! --> permutasi
	int bawah = faktorial(r) * faktorial(n - r);   // r!(n - r)! --> kombinasi
    int perm = atas / bawah;        // P(n, r)

    return perm;
}


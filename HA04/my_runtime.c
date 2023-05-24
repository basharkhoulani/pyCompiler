#include <stdio.h>

typedef signed long long i64;

i64 read_int() {
   i64 x;
   scanf("%lld", &x);
   return x;
}

void print(i64 x) {
   printf("%lld\n", x);
}
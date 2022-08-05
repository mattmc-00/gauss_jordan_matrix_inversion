#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <limits.h>

typedef int32_t FX_15_16;

#define FL_TO_FX(a) (int32_t)(a*65536.0)
#define FX_TO_FL(a) (float)(a/65536.0)
#define INT_TO_FX(a) (a<<16)
#define FX_TO_INT(a) (int32_t)(a>>16)

#define FX_ADD(a,b) (a+b)
#define FX_SUB(a,b) (a-b)
#define FX_MUL(a,b) (int32_t)((((int64_t)a) * b) >> 16)
#define FX_DIV(a,b) (int32_t)(((int64_t)a << 16) / ((int64_t)b))
#define FX_REM(a,b) ((a%b))

int32_t fx_mul(int32_t A, int32_t B) {
  int64_t C = (int64_t)A;
  C = C * B;
  if ((C >> 48) != 0) {
      printf("Overflow/Underflow detected in (A * B)\n");
      exit(-1);
  }
  A = (int32_t)(C >> 16);
  return(A);
}

int32_t fx_add(int32_t A, int32_t B) {
  int32_t C;
  if (__builtin_add_overflow(A, B, &C)) {
      printf("Overflow/Underflow detected in (A + B)\n");
      exit(-1);
  }
}

int main() {
    //2^15 - 1 = 32767
    //2^31 - 1 = 2147483647
    //2^30 = 1073741824
    int32_t one = 1 << 16;
    int32_t A = 32765 << 16, B = 1 << 16, C;

    //if A and B are scaled, return scaled C
    /*if (__builtin_add_overflow(A, B, &C)) {
        printf("Overflow/Underflow detected in (A + B)\n");
        return 1;
    }
    printf("A + B = %d\n", C);*/

    for (int i = 0; i < 10; i++) {
      printf("A = %d\n", A);
      printf("A (float) = %f\n", FX_TO_FL(A));
      printf("B = %d\n", B);
      printf("B (float) = %f\n", FX_TO_FL(B));
      C = fx_mul(A, B);
      printf("A * B = %d\n", C);
      printf("C (float) = %f\n", FX_TO_FL(C));
      A = A + one;
    }
    return 0;
}

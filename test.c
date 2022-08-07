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

void print1(int a[], int n){
  int i, j;
  printf("print1: [\n");
  for (i = 0; i < n; i++){
    printf("\t%d (%d)", a[i], i);
  }
  printf("\n]\n");
}

void print2(int a[], int n){
  int i, j;
  j = 0;
  printf("print2: [\n");
  i = j + 1;
  while (i - j != 0){
    printf("\t%d (%d)", a[i], i);
    i = (i + 1) % n;
  }
  printf("\t%d (%d)", a[j], j);
  printf("\n]\n");
}

/* Application logic */
int main() {
  int i, j;
  int n = 6;
  int a[] = {1, 2, 5, 2, 7, 8};
  print1(a, n);
  print2(a, n);
  return(0);
}

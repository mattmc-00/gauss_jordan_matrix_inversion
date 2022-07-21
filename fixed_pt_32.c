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

void print_a(FX_15_16* a[], int n){
  FX_15_16* ptr;
  int i, j;
  printf("Input Matrix:\nA = [");
  for (i = 0; i < n; i++) {
    ptr = a[i];
    printf("\t");
    for (j = 0; j < n; j++) {
      printf("%f, ", FX_TO_FL(*(ptr + j)));
    }
    if(i == (n - 1)){
      printf("]\n");
    } else {
      printf("\n");
    }
  }
}

void print_inv(FX_15_16* a[], int n, int indices[]){
  FX_15_16* ptr;
  int i, j;
  printf("Input Matrix:\nA = [");
  for (i = 0; i < n; i++) {
    ptr = a[i];
    printf("\t");
    for (j = 0; j < n; j++) {
      printf("%f, ", FX_TO_FL(*(ptr + indices[j])));
    }
    if(i == (n - 1)){
      printf("]\n");
    } else {
      printf("\n");
    }
  }
}

int main(){
  int n;
  printf("Input order of matrix:\n");
  scanf("%d", &n);

  FX_15_16* a[n];
  int i, j;
  for (i = 0; i < n; i++) {
    a[i] = malloc(sizeof(FX_15_16) * n);
  }

  FX_15_16* ptr;
  FX_15_16 input_int;
  float input;
  int indices[n];
  for (i = 0; i < n; i++) {
    ptr = a[i];
    indices[i] = i;
    for (j = 0; j < n; j++) {
      printf("Input a[%d][%d] as float, then enter:\n", i, j);
      scanf("%f", &input);
      input_int = FL_TO_FX(input);
      *(ptr + j) = input_int;
    }
  }
  printf("input\n");
  print_a(a, n);

  FX_15_16 pivot_vector[n];
  FX_15_16* pivot_ptr;
  FX_15_16* swap_row;
  FX_15_16 one = INT_TO_FX(1);
  FX_15_16 curr, max, sub, pivot_inv;
  int ii, jj, max_i;

  for(i = 0; i < n; i++) {
    //first perform swaps to bring max of column to pivot row
    max_i = i;
    max = abs(*(a[i] + i));
    for(ii = i + 1; ii < n; ii++){
      curr = abs(*(a[ii] + i));
      if(curr > max){
        max_i = ii;
        max = curr;
      }
    }

    if(i != max_i){
      swap_row = a[i];
      ii = indices[i];
      a[i] = a[max_i];
      indices[i] = indices[max_i];
      a[max_i] = swap_row;
      indices[max_i] = ii;
    }

    //pivot_vector[i] == pivot for this iteration
    pivot_ptr = a[i];
    pivot_vector[i] = *(pivot_ptr + i);
    *(pivot_ptr + i) = one;

    //normalize pivot row
    pivot_inv = FX_DIV(one, pivot_vector[i]);
    for (jj = 0; jj < n; jj++) {
      *(pivot_ptr + jj) = FX_MUL(*(pivot_ptr + jj), pivot_inv);
    }

    //reduce non-pivot rows
    for (j = 0; j < n; j++) {
      if (j != i) {
        ptr = a[j];
        //pivot_vector[j] == current row's pivot
        pivot_vector[j] = *(ptr + i);
        *(ptr + i) = 0;

        for (jj = 0; jj < n; jj++) {
          sub = FX_MUL(*(pivot_ptr + jj), pivot_vector[j]);
          *(ptr + jj) = FX_SUB(*(ptr + jj), sub);
        }
      }
    }
  }
  printf("done\n");
  print_inv(a, n, indices);

  return(0);
}

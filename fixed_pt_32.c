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
    printf("Row %d:\n", i);
    ptr = a[i];
    indices[i] = i;
    for (j = 0; j < n; j++) {
      scanf("%f", &input);
      input_int = FL_TO_FX(input);
      *(ptr + j) = input_int;
    }
  }
  printf("\n*******************************\n\n");

  printf("A = [\n");
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      input = FX_TO_FL(*(ptr + j));
      printf("\t%f", input);
    }
    printf("\n");
  }
  printf("]\n");
  printf("\n*******************************\n\n");

  FX_15_16 pivot_vector[n];
  FX_15_16* pivot_ptr;
  FX_15_16* swap_row;
  FX_15_16 one = INT_TO_FX(1);
  FX_15_16 curr, max, sub, pivot_inv;
  int norm, reduce, max_i;

  for (norm = 0; norm < n; norm++) {
    //first perform swaps to bring max of column to pivot row
    max_i = norm;
    max = abs(*(a[norm] + norm));
    for(i = norm + 1; i < n; i++){
      curr = abs(*(a[i] + norm));
      if(curr > max){
        max_i = i;
        max = curr;
      }
    }

    if(norm != max_i){
      swap_row = a[norm];
      i = indices[norm];
      a[norm] = a[max_i];
      indices[norm] = indices[max_i];
      a[max_i] = swap_row;
      indices[max_i] = i;
    }

    //pivot_vector[norm] == pivot for this iteration
    pivot_ptr = a[norm];
    pivot_vector[norm] = *(pivot_ptr + norm);
    *(pivot_ptr + norm) = one;

    //normalize pivot row
    pivot_inv = FX_DIV(one, pivot_vector[norm]);
    for (j = 0; j < n; j++) {
      *(pivot_ptr + j) = FX_MUL(*(pivot_ptr + j), pivot_inv);
    }

    for (reduce = 0; reduce < n; reduce++) {
      if (reduce != norm) {
        ptr = a[reduce];
        pivot_vector[reduce] = *(ptr + norm);
        //pivot_vector[reduce] == current row's pivot
        *(ptr + norm) = 0;

        //reduce non-pivot rows
        for (i = 0; i < n; i++) {
          sub = FX_MUL(*(pivot_ptr + i), pivot_vector[reduce]);
          *(ptr + i) = FX_SUB(*(ptr + i), sub);
        }
      }
    }
  }

  printf("\n*******************************\n\n");

  int print_cols[n];
  for (i = 0; i < n; i++) {
    print_cols[indices[i]] = i;
  }

  int indexed_col;
  printf("A-inv = [\n");
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      indexed_col = print_cols[j];
      input = FX_TO_FL(*(ptr + indexed_col));
      printf("\t%f", input);
    }
    printf("\n");
  }
  printf("]\n");
  printf("\n*******************************\n\n");

  return(0);
}

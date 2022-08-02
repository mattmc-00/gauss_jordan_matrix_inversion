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

int gauss(int n, FX_15_16* a[], int indices[]){
  FX_15_16* ptr;
  FX_15_16 input_int;
  float input;
  int i, j;

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

  return(0);
}

int file_in(char file_name[]){
  char ch;
  FILE *fp;

  fp = fopen(file_name, "r");
  if (fp == NULL){
    perror("Error while opening the file.\n");
    exit(-1);
  }

  int input_num = 0, num_ret_values = 0;
  num_ret_values = fscanf(fp, "%d", &input_num);
  int n = input_num;

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
      fscanf(fp, "%f", &input);
      input_int = FL_TO_FX(input);
      *(ptr + j) = input_int;
    }
  }
  fclose(fp);

  gauss(n, a, indices);

  for (i = 0; i < n; i++) {
    free(a[i]);
  }

  return(0);
}

int std_in() {
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

  gauss(n, a, indices);

  for (i = 0; i < n; i++) {
    free(a[i]);
  }

  return(0);
}

int print_file(char file_name[]){
  char ch;
  FILE *fp;

  fp = fopen(file_name, "r");
  if (fp == NULL){
    perror("Error while opening the file.\n");
    exit(-1);
  }

  int input_num = 0, num_ret_values = 0;
  num_ret_values = fscanf(fp, "%d", &input_num);
  int n = input_num;

  FX_15_16* a[n];
  int i, j;

  FX_15_16* ptr;
  FX_15_16 input_int;
  float input;

  printf("expected inverse = [\n");
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      fscanf(fp, "%f", &input);
      printf("\t%f", input);
    }
    printf("\n");
  }
  printf("]\n");
  fclose(fp);

  return(0);
}

int test_suite(){
  char file1[25] = "input/n4_m1.txt";
  char file1_out[25] = "output/n4_m1.txt";
  printf("\n\nTest 1: Matrix of size 4, %s\n", file1);
  file_in(file1);
  print_file(file1_out);

  char file2[25] = "input/n5_m1.txt";
  char file2_out[25] = "output/n5_m1.txt";
  printf("\n\nTest 2: Matrix of size 5, %s\n", file2);
  file_in(file2);
  print_file(file2_out);

  char file3[25] = "input/n5_m2.txt";
  char file3_out[25] = "output/n5_m2.txt";
  printf("\n\nTest 3: Matrix of size 5, %s\n", file3);
  file_in(file3);
  print_file(file3_out);

  return(0);
}

int main() {
  char input_form;
  printf("Input method:\n(f) = from file; (s) = from stdin; (t) = test suite\n");
  scanf("%c", &input_form);

  if (input_form == 'f'){
    char file_name[25];
    printf("Input file name:\n");
    scanf("%s", &file_name);
    file_in(file_name);
  } else if (input_form == 's'){
    std_in();
  } else if (input_form == 't'){
    test_suite();
  }
}

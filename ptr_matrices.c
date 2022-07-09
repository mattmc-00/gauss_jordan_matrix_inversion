#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define SHIFT_AMOUNT 8 // 2^8
#define SHIFT_MASK ((1 << SHIFT_AMOUNT) - 1) // 65535 (all LSB set, all MSB clear)
#define INT int16_t

int get_n_from_stdin(){
  int input_int;
  printf("Input order of matrix:\n");
  scanf("%d", &input_int);
  return(input_int);
}

void get_a_from_stdin(int32_t* a[], int n){
  INT* ptr;
  float input_float;
  INT input_int;
  for (int i = 0; i < n; i++) {
    ptr = a[i];
    for (int j = 0; j < n; j++) {
      printf("input a[%d][%d]\n", i, j);
      scanf("%f", &input_float);
      input_int =  (int)(input_float << SHIFT_AMOUNT);
      *(ptr + j) = input_int;
      printf("%d\n", input_int);
    }
  }
}

void print_a(int32_t* a[], int n){
  INT* ptr;
  float to_print;
  printf("Input Matrix:\nA = [");
  for (int i = 0; i < n; i++) {
    ptr = a[i];
    printf("\t");
    for (int j = 0; j < n; j++) {
      to_print = (*(ptr + j) >> SHIFT_AMOUNT);
      printf("%f, ", to_print);
    }
    if(i == (n - 1)){
      printf("]\n");
    } else {
      printf("\n");
    }
  }
}

void swap_rows(int32_t* a[], int n, int row_i, int row_j){
  INT* temp_row = a[row_i];
  a[row_i] = a[row_j];
  a[row_j] = temp_row;
}

int main(){
  int n = get_n_from_stdin();
  INT* a[n];
  int i, j;
  for (i = 0; i < n; i++) {
    a[i] = malloc(sizeof(int) * n);
  }

  get_a_from_stdin(a, n);
  /*
  INT* ptr;
  int num = 0;
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      *(ptr + j) = num << SHIFT_AMOUNT;
      num++;
    }
  }
  */

  print_a(a, n);
  /*
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      //*(ptr + j) = *(ptr + j) + (1 << SHIFT_AMOUNT);
      *(ptr + j) *= 2;
    }
  }
  */
  swap_rows(a, n, 1, 2);

  print_a(a, n);

  for (i = 0; i < n; i++) {
    free(a[i]);
  }

  return(0);
}

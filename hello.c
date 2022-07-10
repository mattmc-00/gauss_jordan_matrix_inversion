#include <stdio.h>
#include <stdlib.h>
#define SIZE 10
/*
 * Matrix Inversion using In-Place Gauss-Jordan Elimination, source of in-place alg:
 * http://dx.doi.org/10.4236/am.2013.410188
 *
 * Able to take input from stdin or file in pwd.
 * Currently does not perform pivots, only works on well-behaved matrices [those without 0's on the diagonal].
 */


int input_matrix_from_console(float a[SIZE][SIZE]){
  int input_int = 0;
  printf("Input order of matrix:\n");
  scanf("%d", &input_int);
  int n = input_int;

  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
      printf("input a[%d][%d]\n", i, j);
      scanf("%d", &input_int);
      a[i][j] = input_int;
    }
  }
  return(n);
}

int input_matrix_from_file(float a[SIZE][SIZE]){
  char ch;
  char file_name[25] = "simple_matrix_size_5.txt";
  FILE *fp;

  fp = fopen(file_name, "r");
  if (fp == NULL){
    perror("Error while opening the file.\n");
    exit(-1);
  }

  int input_num = 0, num_ret_values = 0;
  num_ret_values = fscanf(fp, "%d", &input_num);
  int n = input_num;

  int i = 0;
  int j = 0;
  while(fscanf(fp, "%d", &input_num) != EOF){
    a[i][j] = (float)input_num;
    j++;
    if(j == n){
      j = 0;
      i++;
    }
  }
  fclose(fp);
  return(n);
}

void display_matrix(float a[SIZE][SIZE], int n){
  printf("Input Matrix:\nA = [");
  for (int i = 0; i < n; i++) {
    printf("\t");
    for (int j = 0; j < n; j++) {
      printf("%f, ", a[i][j]);
    }
    if(i == (n - 1)){
      printf("]\n");
    } else {
      printf("\n");
    }
  }
}

int main() {

  float a[SIZE][SIZE];
  int n;

  //n = input_matrix_from_console(a);
  n = input_matrix_from_file(a);
  display_matrix(a, n);

  float pivot_vector[SIZE];
  int i;

  for (int norm = 0; norm < n; norm++) {
    pivot_vector[norm] = a[norm][norm];
    a[norm][norm] = 1;

    //normalize pivot row
    for (i = 0; i < n; i++) {
      a[norm][i] = a[norm][i] / pivot_vector[norm];
    }
    for (int reduce = 0; reduce < n; reduce++) {
      if (reduce != norm) {
        pivot_vector[reduce] = a[reduce][norm];
        a[reduce][norm] = 0;

        //reduce non-pivot rows
        for (i = 0; i < n; i++) {
          a[reduce][i] = a[reduce][i] - (a[norm][i] * pivot_vector[reduce]);
        }
      }
    }
  }

  display_matrix(a, n);

  for (i = 0; i < n; i++) {
    free(a[i]);
  }

  return(0);
}

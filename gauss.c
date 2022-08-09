#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <limits.h>
#include <time.h>

typedef int32_t FX_15_16;

#define FL_TO_FX(a) (int32_t)(a*65536.0)
#define FX_TO_FL(a) (float)(a/65536.0)
#define INT_TO_FX(a) (a<<16)
#define FX_TO_INT(a) (int32_t)(a>>16)

/* Optimization: Replace with inline functions
#define FX_ADD(a,b) (a+b)
#define FX_SUB(a,b) (a-b)
#define FX_MUL(a,b) (int32_t)((((int64_t)a) * b) >> 16)
#define FX_DIV(a,b) (int32_t)(((int64_t)a << 16) / ((int64_t)b))
*/

/* Function Prototypes */
void gauss(int n, FX_15_16* a[], int indices[]);
void calculate_inverse(int* n_ptr, char file_name[]);
void read_matrix_from_file(int n, int indices[n], FX_15_16* a[n], char file_name[]);
void read_expected_output_from_file(int n, char file_name[]);
void print_matrix(int n, int indices[], FX_15_16* a[], char* name);

/* Optimization: Inline Functions */
static inline int32_t fx_mul(int32_t a, int32_t b){
  int64_t mul = (int64_t)a;
  mul = mul * b;
  a = (int32_t)(mul >> 16);
  return(a);
}

static inline int32_t fx_div(int32_t a, int32_t b){
  int64_t a_64 = (int64_t)a;
  int64_t b_64 = (int64_t)b;
  a_64 = a_64 << 16;
  a = (int32_t)(a_64 / b_64);
  return(a);
}

/* Optimization: replaced calls to stdlib abs() with local abs_32() */
static inline int32_t abs_32(int32_t num){
  if (num < 0){
    return(-num);
  }
  return(num);
}

/* 
  Usage: 
    start timer:
      clock_t start_time = clock();

    run block of code...
    end timer:
      end_timer(start_time, string to prepend in printf);
  
*/
void end_timer(clock_t start_time){
  clock_t end_time = clock();
  double time_spent = (double)(end_time - start_time) / CLOCKS_PER_SEC;
  //printf("%s took %f seconds to execute \n", epilogue, time_spent);
  printf("%f\n", time_spent);
}

/* Gauss-Jordan Elimination Algorithm */
void gauss(int n, FX_15_16* a[], int indices[]){
  FX_15_16* ptr;
  register int norm, reduce, i;
  int max_i;

  FX_15_16 pivot_vector[n];
  FX_15_16* pivot_ptr;
  FX_15_16* swap_row;
  FX_15_16 one = INT_TO_FX(1);
  FX_15_16 curr, max, sub, pivot_inv;
  clock_t start_time;

  for (norm = 0; norm < n; norm++) {
    /* Time execution of pivot row selection */
    //start_time = clock();
    
    /* pivot: swap the row having largest element in current column with current pivot row */
    max_i = norm;
    /* Optimization: replaced calls to stdlib abs() with local abs_32() */
    max = abs_32(*(a[norm] + norm));
    for(i = norm + 1; i < n; i++){
      curr = abs_32(*(a[i] + norm));
      if(curr > max){
        max_i = i;
        max = curr;
      }
    }
    
    /* if the max element is distinct from current row's element, perform the swap */
    if(norm != max_i){
      swap_row = a[norm];
      i = indices[norm];
      a[norm] = a[max_i];
      indices[norm] = indices[max_i];
      a[max_i] = swap_row;
      indices[max_i] = i;
    }
    
    //end_timer(start_time);

    /* pivot_vector[norm] <- normalizing pivot element for this iteration */
    pivot_ptr = a[norm];
    pivot_vector[norm] = *(pivot_ptr + norm);
    if (pivot_vector[norm] == 0) {
      printf("A is not invertible\n");
      exit(-1);
    }

    /* normalize pivot row: divide row by pivot element */

    /* Before optimization:
    *(pivot_ptr + norm) = one;
    pivot_inv = FX_DIV(one, pivot_vector[norm]);
    for (j = 0; j < n; j++) {
      *(pivot_ptr + j) = FX_MUL(*(pivot_ptr + j), pivot_inv);
    }
    */

    /* Time execution of normalization of a row */
    //start_time = clock();
    
    /* Optimized loop: */
    i = (norm + 1) % n;
    pivot_inv = fx_div(one, pivot_vector[norm]);
    while ((i - norm) != 0){
      *(pivot_ptr + i) = fx_mul(*(pivot_ptr + i), pivot_inv);
      i = (i + 1) % n;
    }
    *(pivot_ptr + norm) = pivot_inv;
    
    //end_timer(start_time);


    /* Time execution of n row reductions */
    //start_time = clock();
    
    /* iterate through all non-pivot rows */
    for (reduce = 0; reduce < n; reduce++) {
      if (reduce != norm) {
        /* pivot_vector[reduce] <- reducing pivot element for current row */
        ptr = a[reduce];
        pivot_vector[reduce] = *(ptr + norm);

        /* reduce non-pivot rows */

        /* Before optimization:
        *(ptr + norm) = 0;
        for (i = 0; i < n; i++) {
          sub = FX_MUL(*(pivot_ptr + i), pivot_vector[reduce]);
          *(ptr + i) = FX_SUB(*(ptr + i), sub);
        }
        */

        /* Time execution of reduction of a row */
        //start_time = clock();
        
        /* Optimized loop: */
        i = (norm + 1) % n;
        while ((i - norm) != 0){
          sub = fx_mul(*(pivot_ptr + i), pivot_vector[reduce]);
          *(ptr + i) = *(ptr + i) - sub;
          i = (i + 1) % n;
        }
        *(ptr + norm) = fx_mul(*(pivot_ptr + norm), -pivot_vector[reduce]);
        
        //end_timer(start_time);
      }
    }
    
    //end_timer(start_time);
  }
}

/* Function wrapper for Gauss-Jordan algorithm function */
void calculate_inverse(int* n_ptr, char file_name[]){
  /* Take n as input from user to avoid extra accesses to input file */
  int n;
  printf("Input order of matrix:\n");
  scanf("%d", &n);
  *n_ptr = n;

  FX_15_16* a[n];
  int indices[n];
  int i;
  for (i = 0; i < n; i++) {
    a[i] = malloc(sizeof(FX_15_16) * n);
    indices[i] = i;
  }
  read_matrix_from_file(n, indices, a, file_name);
  /* print_matrix(n, indices, a, "A"); */
  
  /* start timer */
  clock_t start_time = clock();
  
  /* run algorithm */
  gauss(n, a, indices);
  
  /* end timer */
  end_timer(start_time);
  
  /* print_matrix(n, indices, a, "A_inv"); */
  
  for (i = 0; i < n; i++) {
    free(a[i]);
  }
}

void calculate_inverse_testbench(int n, char file_name[]){
  /* Take n as input from user to avoid extra accesses to input file */
  FX_15_16* a[n];
  int indices[n];
  int i;
  for (i = 0; i < n; i++) {
    a[i] = malloc(sizeof(FX_15_16) * n);
    indices[i] = i;
  }
  read_matrix_from_file(n, indices, a, file_name);
  /* print_matrix(n, indices, a, "A"); */
  
  /* start timer */
  clock_t start_time = clock();
  
  /* run algorithm */
  gauss(n, a, indices);
  
  /* end timer */
  end_timer(start_time);
  
  /* print_matrix(n, indices, a, "A_inv"); */
  
  for (i = 0; i < n; i++) {
    free(a[i]);
  }
}

/* I/O functions */
void read_matrix_from_file(int n, int indices[n], FX_15_16* a[n], char file_name[]){
  char ch;
  FILE *fp;
  fp = fopen(file_name, "r");
  if (fp == NULL){
    perror("Error while opening the file.\n");
    exit(-1);
  }

  FX_15_16* ptr;
  FX_15_16 input_int;
  float input;
  int i, j;
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      fscanf(fp, "%f", &input);
      input_int = FL_TO_FX(input);
      *(ptr + j) = input_int;
    }
  }
  fclose(fp);
}

void read_expected_output_from_file(int n, char file_name[]){
  int static_indices[n];
  int i;
  FX_15_16* a_exp[n];
  int indices[n];
  for (i = 0; i < n; i++) {
    a_exp[i] = malloc(sizeof(FX_15_16) * n);
    static_indices[i] = i;
  }

  read_matrix_from_file(n, indices, a_exp, file_name);
  print_matrix(n, static_indices, a_exp, "A_exp");
  for (i = 0; i < n; i++) {
    free(a_exp[i]);
  }
}

void print_matrix(int n, int indices[], FX_15_16* a[], char* name){
  FX_15_16* ptr;
  FX_15_16 input_int;
  float input_flt;
  int i, j;

  /* due to row interchanging, inverse matrices keep track of column indices */
  int print_cols[n];
  for (i = 0; i < n; i++) {
    print_cols[indices[i]] = i;
  }

  int indexed_col;
  printf("%s = [", name);
  for (i = 0; i < n; i++) {
    ptr = a[i];
    putchar('\n');
    for (j = 0; j < n; j++) {
      indexed_col = print_cols[j];
      input_int = *(ptr + indexed_col);
      input_flt = FX_TO_FL(input_int);
      printf("\t%.4f", input_flt);
    }
  }
  printf("\n]\n");
}

/* Application logic */
void main() {
  char action;
  printf("Select action:\n(f) = input matrix from file; (t) = run test suite; (0, 1) = run test from testbench\n");
  scanf("%c", &action);

  int n;
  int* n_ptr;
  n_ptr = &n;
  if (action == 'f'){
    /* action f: get input from local file */
    char file_name[50];
    printf("Input file name:\n");
    scanf("%s", &file_name);
    calculate_inverse(n_ptr, file_name);
  }
  else if (action == 't'){
    /* action t: run hard-coded test suite */
    int num_tests = 3;
    char* inputs[3] = {
      "input/n4_m1.txt",
      "input/n5_m1.txt",
      "input/n5_m2.txt"
    };
    char* outputs[3] = {
      "output/n4_m1.txt",
      "output/n5_m1.txt",
      "output/n5_m2.txt"
    };

    for (int i = 0; i < num_tests; i++){
      printf("Test %d Reading from %s\n", i + 1, inputs[i]);
      calculate_inverse(n_ptr, inputs[i]);
      read_expected_output_from_file(n, outputs[i]);
    }
  }
  else if (action == '0'){
    /* action 0: run testbench matrix 0 */
    char file_name[50] = "input/n100_1.txt";
    n = 100;
    for (int k = 0; k < 1; k++){
      calculate_inverse_testbench(n, file_name);
    }
  }
  else if (action == '1'){
    /* action 1: run testbench matrix 1 */
    char file_name[50] = "input/n250_1.txt";
    n = 250;
    for (int k = 0; k < 1; k++){
      calculate_inverse_testbench(n, file_name);
    }
  }
  else if (action == '2'){
    /* action 2: run testbench matrix 2 */
    char file_name[50] = "input/n100_ill.txt";
    n = 100;
    for (int k = 0; k < 1; k++){
      calculate_inverse_testbench(n, file_name);
    }
  }
}

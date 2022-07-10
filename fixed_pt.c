#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define SHIFT_AMOUNT 8 // 2^8
#define SHIFT_MASK ((1 << SHIFT_AMOUNT) - 1) // 65535 (all LSB set, all MSB clear)
#define INT int16_t
#define INT_PRODUCT int32_t

INT multiply(INT num1, INT num2){
  INT_PRODUCT product = num1 * num2;
  product = product + (((1 << (SHIFT_AMOUNT - 1)) & product) << 1);
  INT rounded_product = product >> SHIFT_AMOUNT;
  return(rounded_product);
}

void swap_rows(INT* a[], int n, int row_i, int row_j){
  INT* temp_row = a[row_i];
  a[row_i] = a[row_j];
  a[row_j] = temp_row;
}

void print_fixed_pt(INT fixed_pt){
  float fractional_part = ((float)(fixed_pt & SHIFT_MASK) / (1 << SHIFT_AMOUNT));
  float int_part = (float)(fixed_pt >> SHIFT_AMOUNT);
  printf("%f", int_part + fractional_part);
}

void print_a(INT* a[], int n){
  INT* ptr;
  printf("Input Matrix:\nA = [");
  for (int i = 0; i < n; i++) {
    ptr = a[i];
    printf("\t");
    for (int j = 0; j < n; j++) {
      print_fixed_pt(*(ptr + j));
      printf(", ");
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

  INT* a[n];
  int i, j;
  for (i = 0; i < n; i++) {
    a[i] = malloc(sizeof(INT) * n);
  }

  INT* ptr;
  INT_PRODUCT numerator, denominator;
  INT value;
  for (i = 0; i < n; i++) {
    ptr = a[i];
    for (j = 0; j < n; j++) {
      printf("Input a[%d][%d] in fractional form (a/b then enter):\n", i, j);
      scanf("%d/%d", &numerator, &denominator);
      value = (numerator << SHIFT_AMOUNT);
      value /= denominator;
      *(ptr + j) = value;
    }
  }
  print_a(a, n);

  INT pivot_vector[n];
  INT* pivot_ptr;
  INT_PRODUCT divider_sf = 1 << (2 * SHIFT_AMOUNT);
  INT reciprocal_pivot;

  for (int norm = 0; norm < n; norm++) {
    pivot_ptr = a[norm];
    pivot_vector[norm] = *(pivot_ptr + norm);
    *(pivot_ptr + norm) = 1 << SHIFT_AMOUNT;

    //normalize pivot row
    reciprocal_pivot = divider_sf / pivot_vector[norm];
    for (i = 0; i < n; i++) {
      *(pivot_ptr + i) = multiply(*(pivot_ptr + i), reciprocal_pivot);
    }
    for (int reduce = 0; reduce < n; reduce++) {
      if (reduce != norm) {
        ptr = a[reduce];
        pivot_vector[reduce] = *(ptr + norm);
        *(ptr + norm) = 0;

        //reduce non-pivot rows
        for (i = 0; i < n; i++) {
          *(ptr + i) = *(ptr + i) - multiply(*(pivot_ptr + i), pivot_vector[reduce]);
        }
      }
    }
  }

  //swap_rows(a, n, 0, 1);
  print_a(a, n);

  // fixed pt 1 = 1 << SHIFT_AMOUNT
  // addition of two fixed pt values a and b = a + b
  // multiplication of a fixed pt value by a constant = a * c
  // division of a fixed pt value by a constant =

  return(0);
}

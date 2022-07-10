#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define SHIFT_AMOUNT 8 // 2^8
#define SHIFT_MASK ((1 << SHIFT_AMOUNT) - 1)
#define INT int16_t
#define INT_PRODUCT int32_t

INT multiply(INT num1, INT num2){
  INT_PRODUCT product = num1 * num2;
  product = product + (((1 << (SHIFT_AMOUNT - 1)) & product) << 1);
  INT rounded_product = product >> SHIFT_AMOUNT;
  return(rounded_product);
}

INT fixed_pt_input(char* prologue, char* epilogue){
  INT_PRODUCT numerator, denominator;
  printf(prologue);
  scanf("%d/%d", &numerator, &denominator);
  printf(epilogue);
  INT input_value = numerator << SHIFT_AMOUNT;
  input_value /= denominator;
  return(input_value);
}

void print_fixed_pt(INT fixed_pt, char* prologue, char* epilogue){
  float fractional_part = ((float)(fixed_pt & SHIFT_MASK) / (1 << SHIFT_AMOUNT));
  float int_part = (float)(fixed_pt >> SHIFT_AMOUNT);
  printf("%s%f%s", prologue, (int_part + fractional_part), epilogue);
}

int main(){
  INT num1 = fixed_pt_input("Input first number in fractional form (a/b then enter):\n", "\n");
  INT num2 = fixed_pt_input("Input second number in fractional form (a/b then enter):\n", "\n");

  print_fixed_pt(num1, "num1: ", "\n");
  print_fixed_pt(num2, "num2: ", "\n");

  INT_PRODUCT divider_sf = 1 << (2 * SHIFT_AMOUNT);
  INT num1_reciprocal = divider_sf / num1;
  print_fixed_pt(num1_reciprocal, "num1_reciprocal: ", "\n");

  INT product = multiply(num2, num1_reciprocal);
  print_fixed_pt(product, "product: ", "\n");

  return(0);
}

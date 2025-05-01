---
nav_order: 1
parent: Lab 6 - Structures, Vectors and Strings
---

# Task: Fibonacci Sum

You will solve the exercises starting from the `fibo_sum.asm` file located in the `tasks/fibonacci` directory.
Starting from the `fibo_sum.asm` file, implement a program that calculates the sum of the first N numbers in the Fibonacci sequence using the `loop` instruction.
The sum of the first 9 numbers is 54.

To test the implementation, enter the `tests/` directory and run:

```console
make check
```

In case of a correct solution, you will get an output such as:

```text
./run_all_tests.sh

Test name format is test_fibo_sum_<N>_<sum to N>

test_fibo_sum_9_54               ........................ passed ...  25
test_fibo_sum_12_232             ........................ passed ...  25
test_fibo_sum_1_0                ........................ passed ...  25
test_fibo_sum_40_165580140       ........................ passed ...  25

========================================================================

Total:                                                           100/100
```

If you're having difficulties solving this exercise, go through [this](../../reading/structures.md) reading material.

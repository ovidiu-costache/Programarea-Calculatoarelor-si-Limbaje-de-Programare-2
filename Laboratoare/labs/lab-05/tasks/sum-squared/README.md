---
nav_order: 3
parent: Lab 5 - Registers and Memory Addressing
---

# Task: Sum of First N Natural Numbers Squared

You will solve this exercise starting from the `sum_n.asm` file located in the `tasks/sum-squared/support` directory.

In the `sum_n.asm` program, the sum of the first `num` natural numbers is calculated.

Follow the code, observe the constructions and registers specific to working with bytes.
Run the code.

> **IMPORTANT**: Proceed to the next step only after you have understood very well what the code does.
It will be difficult for you to do the next exercise if you have difficulties understanding the current one.

Start with the program `sum_n.asm` and create a program `sum_n_squared.asm` that calculates the sum of squares of the first `num` natural numbers (`num` <= 100).

> **TIP**: You will use the `eax` and `edx` registers for multiplication to compute the squares (using the `mul` instruction).
Therefore, you cannot easily use the `eax` register to store the sum of squares. To retain the sum of squares, you have two options:
>
> 1. (easier) Use the `ebx` register to store the sum of squares.
> 1. (more complex) Before performing operations on the `eax` register, save its value on the stack (using the `push` instruction), then perform the necessary operations, and finally restore the saved value (using the `pop` instruction).
>
> **NOTE**: For verification, the sum of squares of the first 100 natural numbers is `338350`.

## Testing

To test the implementation, enter the `tests/` directory and run:

```console
make check
```

In case of a correct solution, you will get an output such as:

```text
test_sum_100                     ........................ passed ...  50
test_sum_squares_100             ........................ passed ...  50

========================================================================

Total:                                                           100/100
```

If you're having difficulties solving this exercise, go through [this](../../reading/registers.md) reading material.

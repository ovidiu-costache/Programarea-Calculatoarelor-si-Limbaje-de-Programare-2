---
parent: Lab 1 - Number Representation
nav_order: 4
---

# Task: Length and Equality with Bitwise Operations

You will solve the exercise starting from the file `len_xor.c` located in the directory `tasks/len-xor/support/`.

For a given string of characters, display:

- the length of the string
- the address of each character at position i that is equal to the character at position $i + 2^i$ (if $i + 2^i$ exceeds the size of the string, use the modulo operation)

Use pointer operations and bitwise operations as much as possible!

> **NOTE**: Do not use functions such as `strlen()`, `sizeof()`, `pow()`, and do not check equality using `==`.
> Also, do not access string elements in the form of `s[i]`.
>
> **TIP**: For the string "aac":
>
>```text
> length = 3
> Address of a: 0x564c364482a0
> Address of a: 0x564c364482a1
>```
>
> For the string "ababababacccbacbacbacbacbabc":
>
> ```text
> length = 28
> Address of b: 0x563f0da6f2a1
> Address of a: 0x563f0da6f2a2
> Address of c: 0x563f0da6f2a9
> Address of a: 0x563f0da6f2b0
> Address of b: 0x563f0da6f2b2
> Address of b: 0x563f0da6f2b5
> Address of c: 0x563f0da6f2b7
> Address of a: 0x563f0da6f2b9
> ```
>
>**The above addresses are illustrative!**

To test the implementation, enter the `tests/` directory and run:

```console
make check
```

In case of a correct solution, you will get an output such as:

```text
./run_all_tests.sh
test_small_string             ........................ passed ...  33
test_medium_string            ........................ passed ...  33
test_big_string               ........................ passed ...  34

Total:                                                           100/100
```

If you're having difficulties solving this exercise, go through [this](../../reading/c-pointers.md) reading material.

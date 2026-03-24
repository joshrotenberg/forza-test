// Package calculator provides simple arithmetic operations for testing forza workflows.
package calculator

import (
	"errors"
	"math"
)

var ErrDivideByZero = errors.New("division by zero")
var ErrNegativeInput = errors.New("negative input")

// Add returns the sum of two integers.
func Add(a, b int) int {
	return a + b
}

// Subtract returns the difference of two integers.
func Subtract(a, b int) int {
	return a - b
}

// Multiply returns the product of two integers.
func Multiply(a, b int) int {
	return a * b
}

// Divide returns the quotient of two integers. Returns an error if b is zero.
func Divide(a, b int) (int, error) {
	if b == 0 {
		return 0, ErrDivideByZero
	}
	return a / b, nil
}

// Sqrt returns the integer square root of n. Returns an error if n is negative.
func Sqrt(n int) (int, error) {
	if n < 0 {
		return 0, ErrNegativeInput
	}
	return int(math.Sqrt(float64(n))), nil
}

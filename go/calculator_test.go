package calculator

import "testing"

func TestAdd(t *testing.T) {
	if got := Add(2, 3); got != 5 {
		t.Errorf("Add(2, 3) = %d, want 5", got)
	}
}

func TestSubtract(t *testing.T) {
	if got := Subtract(5, 3); got != 2 {
		t.Errorf("Subtract(5, 3) = %d, want 2", got)
	}
}

func TestMultiply(t *testing.T) {
	if got := Multiply(4, 3); got != 12 {
		t.Errorf("Multiply(4, 3) = %d, want 12", got)
	}
}

func TestDivide(t *testing.T) {
	got, err := Divide(10, 2)
	if err != nil || got != 5 {
		t.Errorf("Divide(10, 2) = %d, %v, want 5, nil", got, err)
	}
}

func TestDivideByZero(t *testing.T) {
	_, err := Divide(10, 0)
	if err == nil {
		t.Error("Divide(10, 0) should return error")
	}
}

func TestSqrt(t *testing.T) {
	got, err := Sqrt(9)
	if err != nil || got != 3 {
		t.Errorf("Sqrt(9) = %d, %v, want 3, nil", got, err)
	}
}

func TestSqrtNegative(t *testing.T) {
	_, err := Sqrt(-1)
	if err == nil {
		t.Error("Sqrt(-1) should return error")
	}
}

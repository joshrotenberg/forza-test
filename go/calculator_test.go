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

func TestPowerZeroExp(t *testing.T) {
	if got := Power(5, 0); got != 1 {
		t.Errorf("Power(5, 0) = %d, want 1", got)
	}
}

func TestPowerOneExp(t *testing.T) {
	if got := Power(5, 1); got != 5 {
		t.Errorf("Power(5, 1) = %d, want 5", got)
	}
}

func TestPower(t *testing.T) {
	if got := Power(2, 10); got != 1024 {
		t.Errorf("Power(2, 10) = %d, want 1024", got)
	}
}

/// A simple calculator module for testing forza workflows.
pub mod calculator {
    /// Add two numbers.
    pub fn add(a: i32, b: i32) -> i32 {
        a + b
    }

    /// Subtract two numbers.
    pub fn subtract(a: i32, b: i32) -> i32 {
        a - b
    }

    /// Multiply two numbers.
    pub fn multiply(a: i32, b: i32) -> i32 {
        a * b
    }

    /// Divide two numbers. Returns an error if divisor is zero.
    pub fn divide(a: i32, b: i32) -> Result<i32, &'static str> {
        if b == 0 {
            Err("division by zero")
        } else {
            Ok(a / b)
        }
    }

    /// Returns true if n is positive.
    pub fn is_positive(n: i32) -> bool {
        n > 0
    }

    /// Returns true if n is even, false if odd.
    pub fn is_even(n: i32) -> bool {
        n % 2 == 0
    }

    /// Compute the factorial of n. Returns an error if n is negative.
    pub fn factorial(n: i32) -> Result<u64, &'static str> {
        if n < 0 {
            Err("factorial of negative number")
        } else {
            Ok((1..=n as u64).product())
        }
    }
}

#[cfg(test)]
mod tests {
    use super::calculator::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }

    #[test]
    fn test_subtract() {
        assert_eq!(subtract(5, 3), 2);
    }

    #[test]
    fn test_multiply() {
        assert_eq!(multiply(4, 3), 12);
    }

    #[test]
    fn test_divide() {
        assert_eq!(divide(10, 2), Ok(5));
    }

    #[test]
    fn test_divide_by_zero() {
        assert_eq!(divide(10, 0), Err("division by zero"));
    }

    #[test]
    fn test_is_positive() {
        assert!(is_positive(5));
        assert!(!is_positive(0));
        assert!(!is_positive(-3));
    }

    #[test]
    fn test_is_even() {
        assert!(is_even(4));
        assert!(!is_even(3));
    }

    #[test]
    fn test_factorial() {
        assert_eq!(factorial(0), Ok(1));
        assert_eq!(factorial(1), Ok(1));
        assert_eq!(factorial(5), Ok(120));
        assert_eq!(factorial(10), Ok(3628800));
    }

    #[test]
    fn test_factorial_negative() {
        assert_eq!(factorial(-1), Err("factorial of negative number"));
    }
}

#[cfg(test)]
mod auto_merge_tests {
    use super::calculator::*;

    #[test]
    fn test_add_negative() {
        assert_eq!(add(-1, -2), -3);
    }

    #[test]
    fn test_multiply_by_zero() {
        assert_eq!(multiply(42, 0), 0);
    }
}

#[cfg(test)]
mod failing_tests {
    use super::calculator::*;

    #[test]
    fn test_broken_addition() {
        assert_eq!(add(2, 2), 4, "2 + 2 should equal 4");
    }
}

/// Cube a number (added on main).
pub fn cube(n: i32) -> i32 {
    n * n * n
}

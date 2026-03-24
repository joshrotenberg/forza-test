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

    /// Divide two numbers. Returns None if divisor is zero.
    pub fn divide(a: i32, b: i32) -> Option<i32> {
        if b == 0 { None } else { Some(a / b) }
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
        assert_eq!(divide(10, 2), Some(5));
    }

    #[test]
    fn test_divide_by_zero() {
        assert_eq!(divide(10, 0), None);
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
        // This test intentionally fails — forza should fix it
        assert_eq!(add(2, 2), 5, "2 + 2 should equal 5 (this is wrong)");
    }
}

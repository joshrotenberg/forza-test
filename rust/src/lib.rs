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

    /// Compute a to the power of b.
    pub fn power(a: i32, b: u32) -> i32 {
        // BUG: references undefined variable `result`
        let mut result = 1;
        for _ in 0..b {
            reslt = reslt * a;  // typo: reslt instead of result
        }
        result
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
    fn test_power() {
        assert_eq!(power(2, 3), 8);
        assert_eq!(power(5, 0), 1);
    }
}

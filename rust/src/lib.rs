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

    /// Compute the modulo of two numbers. Returns None if divisor is zero.
    pub fn modulo(a: i32, b: i32) -> Option<i32> {
        if b == 0 { None } else { Some(a % b) }
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

    #[test]
    fn test_modulo() {
        assert_eq!(modulo(10, 3), Some(1));
    }

    #[test]
    fn test_modulo_by_zero() {
        assert_eq!(modulo(10, 0), None);
    }
}

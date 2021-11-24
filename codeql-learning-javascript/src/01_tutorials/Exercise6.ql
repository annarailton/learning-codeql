/** Computes first 10 Fibonacci numbers */
int idxLimit() { result = 10 }

int getFibPredicate(int idx) {
  idx <= idxLimit() and // avoid getting infinite result
  (
    result = 1 and idx = 0
    or
    result = 1 and idx = 1
    or
    result = getFib(idx - 1) + getFib(idx - 2) and
    idx >= 2
  )
}

class FibonacciNumber extends int {
  int idx;

  int getIdx() { result = idx }

  FibonacciNumber() {
    idx < idxLimit() and
    (
      idx = 0 and this = 1
      or
      idx = 1 and this = 1
      or
      this = getFib(idx - 1) + getFib(idx - 2) and
      idx >= 2
    )
  }
}

FibonacciNumber getFib(int idx) { result.getIdx() = idx }

from int idx, FibonacciNumber fib
where fib = getFib(idx)
select idx, fib

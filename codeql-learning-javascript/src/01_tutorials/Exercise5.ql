/** Computes Pythagorian triples between 1 and 10 */
class SmallInt extends int {
  SmallInt() { this in [1 .. 10] } // Characteristic predicate

  int square() { result = this * this } // Member predicate
}

from SmallInt x, SmallInt y, SmallInt z
where x.square() + y.square() = z.square()
select x, y, z

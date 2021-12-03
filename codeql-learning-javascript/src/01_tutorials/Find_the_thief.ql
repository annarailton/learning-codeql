/** Code to solve the puzzle https://codeql.github.com/docs/writing-codeql-queries/find-the-thief/ */

import tutorial

/**
 * Predicate with a result (does not need `predicate` keyword, just the return tupe)
 *
 * Useage:
 *
 * from Person p
 * where isBaldWithResult(p) = true
 * select p
 */
// Predicate with a result (does not need `predicate` keyword, just the return tupe)
boolean isBaldWithResult(Person p) {
  exists(p.getHairColor()) and result = false
  or
  not exists(p.getHairColor()) and result = true
}

/**
 * Predicate without a result (needs keyword `predicate`)
 *
 * Useage:
 *
 * from Person p
 * where isBaldWithoutResult(p)
 * select p
 */
predicate isBaldWithoutResult(Person p) { not exists(p.getHairColor()) }

predicate isOldest(Person p) { not exists(Person q | p != q and q.getAge() > p.getAge()) }

/** `isOldest` with an aggregate: https://codeql.github.com/docs/ql-language-reference/expressions/#aggregations */
predicate isOldestAggregate(Person p) {
  p.getAge() = max(int a | exists(Person q | q.getAge() = a) | a)
}

/**
 * `isOldest` with an ordered aggregate
 *
 * There are no restrictions on what people to consider so the `<logical formula>` clause in the
 * middle is empty
 *
 * <aggregate>(<variable declarations> | <logical formula> | <expression>)
 */
predicate isOldestOrderedAggregate(Person p) { p = max(Person q | | q order by q.getAge()) }

from Person t
where
  // Taller than 150cm? YES
  t.getHeight() > 150 and
  // // Have blond hair? NO
  exists(string s | t.getHairColor() = s and s != "blond") and
  // // Is bald? NO
  not isBaldWithoutResult(t) and
  // Younger than 30? NO
  t.getAge() >= 30 and
  // Live east of castle? YES
  t.getLocation() = "east" and
  // Black or brown hair? YES
  (t.getHairColor() = "black" or t.getHairColor() = "brown") and
  // Taller than 180cm and shorter than 190cm? NO
  not (t.getHeight() > 180 and t.getHeight() < 190) and
  // Oldest person in village? NO
  not isOldest(t) and 
  // Tallest person in village: NO
  t != max(Person p | | p order by p.getHeight()) and
  // Shorter than average height: YES
  t.getHeight() < avg(Person p | | p.getHeight()) and
  // Oldest person in eastern part of the village: YES
  t = max(Person p | p.getLocation() = "east" | p order by p.getAge())
  select t

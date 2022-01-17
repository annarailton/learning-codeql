/**
 * Code to solve the   *     from Person p
 *     where isSouthern(p)
 *     select puzzle https://codeql.github.com/docs/writing-codeql-queries/catch-the-fire-starter/
 */

import tutorial

// Defining a predicate:
// 1) Keyword `predicate` (for preciates without results), else type of result
// 2) Name of predicate (start with lowercase letter)
// 3) Arguments to preciate (type + identifier)
// 4) Predicate body, enclosed in braces {}
//
// Predicates without result: if a value satisfies the logical property in the body, then the
// predicate holds for that value.
//
// Predicates with result: replace keyword `predicate` with type of result. Introduce the special
// variable `result`
/**
 * Predicate without result for southerners.
 *
 *
 * Example use:
 *     from Person p
 *     where isSouthern(p)
 *     select p
 *
 * This could be more efficient as this looks at every `Person p` then restricts the result to those
 * who satisfy `isSouthern(p)`.
 */
predicate isSouthern(Person p) { p.getLocation() = "south" }

/**
 * A class in QL represents a logical property, i.e. when a value satisfies that property, it is a member
 * of that class. A value can be in multiple classes.
 *
 * The expression `isSouthern(this)` is the _characteristic predicate_ of the class. It is NOT the same as
 * a constructor, it's a logical property which doesn't create any objects. 
 * 
 * Example use:
 *      from Southerner s
 *      select s
 */
class Southerner extends Person {
  Southerner() { isSouthern(this) }
}

/** Overriding a predicate */
class Child extends Person {
    /* Characteristic predicate */
    Child() { this.getAge() < 10 }

    /* Member predicate we're overriding, encoding "children are not alolowed to travel out of their home region" */
    override predicate isAllowedIn(string region) {
        region = this.getLocation()
    }

}

predicate isBald(Person p) {
    not exists (string c | p.getHairColor() = c)
  }

from Southerner s 
where s.isAllowedIn("north") and isBald(s)
select s
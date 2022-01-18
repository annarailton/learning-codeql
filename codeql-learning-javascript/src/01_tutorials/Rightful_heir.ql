/**
 * Code to solve the puzzle https://codeql.github.com/docs/writing-codeql-queries/crown-the-rightful-heir/
 */

import tutorial


/** Named predicate 
 * 
 * This is a recursive predicate as `ancestorOf` is used in its own definition
 * 
 * The transitive closure of a preciate is a recursive predicate whose results are obtained by repeatedly
 * applying the original predicate. 
 * 
 * Transitive closure `+`: apply predicate to itself one or more times
 * Reflexive transitive closure `*`: apply predicate to itself zero or more times
 * 
*/
Person ancestorOf(Person p) {
    result = parentOf(p) or
    result = parentOf(ancestorOf(p))
    // This is equivalent to `parentOf+(p)`
}

/** Person is related if they have a common ancestor
 * 
 * 
 * parentOf+(p) applies parentOf() one or more times (equivalent of ancestorOf)
 * parentOf*(p) applies parentOf() zero or more times (results an ancestor of `p` or `p` itself)
 */
Person relativeOf(Person p) {
    parentOf*(result) = parentOf*(p)
}

predicate hasCriminalRecord(Person p) {
    p = "Charlie" or
    p = "Hugh" or 
    p = "Hester"
}

from Person p
where 
    p = relativeOf("King Basil") and 
    not p.isDeceased() and
    not hasCriminalRecord(p)
select p

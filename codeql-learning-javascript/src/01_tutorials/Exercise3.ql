/**
 * Exercise 3 from: 
 * https://codeql.github.com/docs/writing-codeql-queries/introduction-to-ql/
 */

 from boolean x
 where x = false
 select x.booleanNot()
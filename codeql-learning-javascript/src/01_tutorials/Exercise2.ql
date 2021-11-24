/**
 * Exercise 2 from: 
 * https://codeql.github.com/docs/writing-codeql-queries/introduction-to-ql/
 */

 from float x, float y 
 where x = 3.pow(5) and y = 245.6
 select x.minimum(y).sin()
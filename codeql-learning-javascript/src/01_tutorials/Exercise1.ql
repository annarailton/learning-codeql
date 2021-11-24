/**
 * Exercise 1 from: 
 * https://codeql.github.com/docs/writing-codeql-queries/introduction-to-ql/
 */

 from string s 
 where s = "lgtm"
 select s.length()
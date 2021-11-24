/**
 * Exercise 4 from: 
 * https://codeql.github.com/docs/writing-codeql-queries/introduction-to-ql/
 * "Write a query which computes the number of days between June 10 and September 28, 2017"
 */

from date start, date finish
where start = "2017-06-10".toDate() and finish = "2017-09-28".toDate()
select start.daysTo(finish)

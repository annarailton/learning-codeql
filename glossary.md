# Glossary
<!-- MarkdownTOC -->

- [Glossary](#glossary)
    - [annotation](#annotation)
    - [binding](#binding)
    - [binding set](#binding-set)
    - [control flow](#control-flow)
    - [declarative programming](#declarative-programming)
    - [imperative programming](#imperative-programming)
    - [predicate](#predicate)
      - [predicate without result](#predicate-without-result)
      - [predicate with result](#predicate-with-result)
      - [non-member predicate](#non-member-predicate)
      - [member predicate](#member-predicate)
      - [characteristic predicate](#characteristic-predicate)
      - [infinite predicate](#infinite-predicate)
      - [database predicate](#database-predicate)

<!-- /MarkdownTOC -->

### annotation

### binding

### binding set

Annotation where you can allow an infinite predicate because you intend to use it on a restricted set of arguments. 
```codeql
bindingset[i]
int multiplyBy4(int i) {
  result = i * 4
}

from int i
where i in [1 .. 10]
select multiplyBy4(i)
```
Can also state multiple binding states:
```codeql
bindingset[x] bindingset[y]  // independent binding sets; bindingset[x, y] requires both to be bound
predicate plusOne(int x, int y) {
  x + 1 = y
}

from int x, int y
where y = 42 and plusOne(x, y)
select x, y
```
```codeql
bindingset[str, len]
string truncate(string str, int len) {
  if str.length() > len
  then result = str.prefix(len)
  else result = str
}
...
select truncate("hello world", 5)
```

### control flow

The order in which individual statements / instructions / function calls of an imperative program are executed / evaluated. A `control flow statement` is a statement that results in a choice of which of two or more paths to follow. 

### declarative programming

A programming paradigm that expresses the logic of a computation without describing exactly how it has to be done (its [`control flow`](#control-flow)). CodeQL is a language with a declarative nature (pretty common for database query languages, as well as in logic programming). It also attempts to minimize / eliminate side effects.

### imperative programming

A programming paradigm that uses statements to change a program's state. It focusses on _how_ a program operates, implementing algorithms in explicit steps. 

### predicate

Used to describe logical relations that make up a CodeQL program. Evaluate to a set of tuples

#### predicate without result

If value satisfies the logical property in the body, then the predicate holds for that value
```codeql
predicate isSmall(int i) {
  i in [1 .. 9]
}
```

#### predicate with result

Replace keyword `predicate` with the type of result and introduces special variable `result`
```codeql
int getSuccessor(int i) {
  result = i + 1 and
  i in [1 .. 9]
}
```

#### non-member predicate

Predicates defined outside a class _i.e._ not members of any class. 
```codeql
int getSuccessor(int i) {
  result = i + 1 and
  i in [1 .. 9]
}
```

#### member predicate


#### characteristic predicate


#### infinite predicate

A predicate contains variables that aren't constrained to a finite set of values, _e.g._:
```codeql
int multiplyBy4(int i) {
  result = i * 4
}
```

#### database predicate

Each database contains tables expressing relations between values, which can be treated in the same way as other predicates in CodeQL. 

For example, if a database contains a table for persons, you can write `persons(x, firstName, _, age)` to constrain `x`, `firstName`, and `age` to be the first, second, and fourth columns of rows in that table.

They cannot be explicitly defined as they are defined by the underlying database. 

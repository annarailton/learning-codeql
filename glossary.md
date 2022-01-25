# Glossary
<!-- MarkdownTOC -->

- [Glossary](#glossary)
  - [annotation](#annotation)
  - [binding](#binding)
  - [binding set](#binding-set)
  - [built-ins](#built-ins)
  - [class](#class)
    - [class body](#class-body)
  - [control flow](#control-flow)
  - [declarative programming](#declarative-programming)
  - [imperative programming](#imperative-programming)
  - [field](#field)
  - [final](#final)
  - [predicate](#predicate)
    - [predicate without result](#predicate-without-result)
    - [predicate with result](#predicate-with-result)
    - [non-member predicate](#non-member-predicate)
    - [member predicate](#member-predicate)
    - [characteristic predicate](#characteristic-predicate)
    - [infinite predicate](#infinite-predicate)
    - [database predicate](#database-predicate)
  - [query](#query)
  - [query predicate](#query-predicate)
  - [query module](#query-module)
  - [namespace](#namespace)
  - [select clause](#select-clause)
  - [type](#type)
    - [primitive types](#primitive-types)
    - [type compatibility](#type-compatibility)

<!-- /MarkdownTOC -->

## annotation

:warning: TODO

## binding

:warning: TODO

## binding set

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

## built-ins

:warning: TODO

## class

Can define own types in CodeQL using a class. This allows you to:

- group together related values
- define [`member predicates`](#member-predicate) on those values
- define subclasses that override member predicates 

*N.B.* a class in CodeQL does not create a new object, it just represents a logical property.

```codeql
class OneTwoThree extends int {
  OneTwoThree() { // characteristic predicate
    this = 1 or this = 2 or this = 3
  }

  string getAString() { // member predicate
    result = "One, two or three: " + this.toString()
  }

  predicate isEven() { // member predicate
    this = 2
  }
}
```

To be valid, a class:

- must not extend itself
- must not extend a [`final`](#final) class
- must not extend [types that are incompatible](#type-compatibility)

### class body

Body of a class can contain:

- a [`characteristic predicate`](#characteristic-predicate) declaration 
- any number of [`member predicates`](#member-predicate)
- any number of [`field`](#field) declarations

## control flow

The order in which individual statements / instructions / function calls of an imperative program are executed / evaluated. A `control flow statement` is a statement that results in a choice of which of two or more paths to follow. 

## declarative programming

A programming paradigm that expresses the logic of a computation without describing exactly how it has to be done (its [`control flow`](#control-flow)). CodeQL is a language with a declarative nature (pretty common for database query languages, as well as in logic programming). It also attempts to minimize / eliminate side effects.

## imperative programming

A programming paradigm that uses statements to change a program's state. It focusses on _how_ a program operates, implementing algorithms in explicit steps.

## field

:warning: TODO

## final

:warning: TODO

## predicate

Used to describe logical relations that make up a CodeQL program. Evaluate to a set of tuples

### predicate without result

If value satisfies the logical property in the body, then the predicate holds for that value

```codeql
predicate isSmall(int i) {
  i in [1 .. 9]
}
```

### predicate with result

Replace keyword `predicate` with the type of result and introduces special variable `result`

```codeql
int getSuccessor(int i) {
  result = i + 1 and
  i in [1 .. 9]
}
```

### non-member predicate

Predicates defined outside a class _i.e._ not members of any class. 

```codeql
int getSuccessor(int i) {
  result = i + 1 and
  i in [1 .. 9]
}
```

### member predicate


### characteristic predicate

Predicates defined inside the body of a class. Logical properties that use the variable `this` to restrict the possible values in the class.

### infinite predicate

A predicate contains variables that aren't constrained to a finite set of values, _e.g._:

```codeql
int multiplyBy4(int i) {
  result = i * 4
}
```

### database predicate

Each database contains tables expressing relations between values, which can be treated in the same way as other predicates in CodeQL. 

For example, if a database contains a table for persons, you can write `persons(x, firstName, _, age)` to constrain `x`, `firstName`, and `age` to be the first, second, and fourth columns of rows in that table.

They cannot be explicitly defined as they are defined by the underlying database. 

## query

Output of a QL program; evaluate to sets of results.

There are two kinds of query:

1. [Select clause](#select-clause)

```codeql
from /* ... variable declarations ... */
where /* ... logical formula ... */
select /* ... expressions ... */
```

1. [query predicate](#query-predicate) in that module's predicate [`namespace`](#namespace).

## query predicate

A [`non-member predicate`](#non-member-predicate) with a `query` annotation. Returns all the tuples that the [predicate](#predicate) evaluates to, *e.g.*

```codeql
query int getProduct(int x, int y) {
  x = 3 and
  y in [0 .. 2] and
  result = x * y
}
```

More useful than a [select clause](#select-clause) as can call predicate in other parts of the code, *e.g.*

```codeql
class MultipleOfThree extends int {
  MultipleOfThree() { this = getProduct(_, _) }
}
```

Can also put `query` in front a a predicate you're writing to debug it. 

## query module

Defined by a `.ql` file.

- Cannot be imported
- Must have at least one query in its [`namespace`](#namespace)

## namespace

:warning: TODO

## select clause

Kind of query, usually found at the end of a `.ql` file.

```codeql
from /* ... variable declarations ... */
where /* ... logical formula ... */
select /* ... expressions ... */
```

- `from` and `where` are optional
- can also include `as` keyword, followed by a name (gives label to results column)
- can also include `order by` keywords, followed by name of results column. `asc` or `desc` can also be added. Determines order to display results

Anonymous predicate, so cannot call it elsewhere (unlike a [query predicate](#query-predicate)).

## type

A set of values. CodeQL is a statically typed language so each variable must have a declared type. 

### primitive types

Types built into CodeQL and available in the global [`namespace`](#namespace), independent of the database you are analyzing. 

- `boolean`
- `float`
- `int`
- `string`
- `date` (dates and optionally times)

There are a range of [`build-in`](#built-ins) operations defined on primitive types.

### type compatibility
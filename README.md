# learning-codeql

Repo containing everything as I grind out learning [CodeQL](https://codeql.github.com/docs/).

There will be a JavaScript bias, certainly to begin with.

## Setup

Include the submodules, either by `git clone --recursive` or by `git submodule update --init --remote` after clone. 

 Use `git submodule update --remote` regularly to keep the submodules up to date.

## Current plan of attack

- [ ] [QL tutorials](https://codeql.github.com/docs/writing-codeql-queries/ql-tutorials/)
- [ ] [QL language reference](https://codeql.github.com/docs/ql-language-reference/)
- [ ] [CodeQL for JavaScript](https://codeql.github.com/docs/codeql-language-guides/codeql-for-javascript/)
    * [ ] [Basic query](https://codeql.github.com/docs/codeql-language-guides/basic-query-for-javascript-code/)
    * [ ] [CodeQL library for JS](https://codeql.github.com/docs/codeql-language-guides/codeql-library-for-javascript/)
    * [ ] [AST classes](https://codeql.github.com/docs/codeql-language-guides/abstract-syntax-tree-classes-for-working-with-javascript-and-typescript-programs/)
    * [ ] [Analysing dataflow](https://codeql.github.com/docs/codeql-language-guides/analyzing-data-flow-in-javascript-and-typescript/)
- [ ] [JS CVE queries](https://github.com/github/codeql/tree/main/javascript/ql/src/Security)
    - Look at test results by running `codeql test run $DIR --keep-databases`
    


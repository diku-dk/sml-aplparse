# sml-aplparse [![CI](https://github.com/diku-dk/sml-aplparse/workflows/CI/badge.svg)](https://github.com/diku-dk/sml-aplparse/actions)

This Standard ML library implements an APL parser.

## Overview of MLB files

- `lib/github.com/diku-dk/sml-aplparse/aplparse.mlb`:

  - **signature** [`REGION`](lib/github.com/diku-dk/sml-aplparse/REGION.sig)
  - **signature** [`APL_PARSE`](lib/github.com/diku-dk/sml-aplparse/APL_PARSE.sig)
  - **signature** [`PARSE_COMB`](lib/github.com/diku-dk/sml-aplparse/PARSE_COMB.sig)
  - **structure** `Region` :> `REGION`
  - **structure** `AplParse` :> `APL_PARSE`
  - **structure** `ParseComb` :> `PARSE_COMB`

## Use of the package

This library is set up to work well with the SML package manager
[smlpkg](https://github.com/diku-dk/smlpkg).  To use the package, in
the root of your project directory, execute the command:

```
$ smlpkg add github.com/diku-dk/sml-aplparse
```

This command will add a _requirement_ (a line) to the `sml.pkg` file in your
project directory (and create the file, if there is no file `sml.pkg`
already).

To download the library into the directory
`lib/github.com/diku-dk/sml-aplparse` (along with other necessary
libraries), execute the command:

```
$ smlpkg sync
```

You can now reference the `mlb`-file using relative paths from within
your project's `mlb`-files.

Notice that you can choose either to treat the downloaded package as
part of your own project sources (vendoring) or you can add the
`sml.pkg` file to your project sources and make the `smlpkg sync`
command part of your build process.

## Try it!

The parser compiles with either [MLton](http://mlton.org) or
[MLKit](http://www.elsman.com/mlkit/).

Now write

    $ smlpkg sync

The implementation builds on the unicode library available at
[https://github.com/diku-dk/sml-unicode](https://github.com/diku-dk/sml-unicode),
but `smlpkg` will arrange for this library to be fetched and installed
automatically.

Then simply write `make test` in your shell.

To use the MLKit as a compiler, write instead:

    $ MLCOMP=mlkit make clean test

## Example

The APL program

```apl
diff ← {1↓⍵−¯1⌽⍵}
signal ← {¯50⌈50⌊50×(diff 0,⍵)÷0.01+⍵}
```

parses into the following abstract syntax tree (pretty printed):

    [Assign(diff,Lam(App2(Drop,1,App2(Sub,Omega,App2(Rot,-1,Omega))))),
     Assign(signal,Lam(App2(Max,-50,
                         App2(Min,50,
                           App2(Times,50,
                             App2(Div,
                               App1(diff,App2(Cat,0,Omega)),
                               App2(Add,0.01,Omega)
                             )
                           )
                         )
                       )
                      )
           )
    ]

The test parses the APL programs in the
[`tests`](lib/github.com/diku-dk/sml-aplparse/test/tests) directory.

## Limitations

Todo: improved error handling. Although position information is now
maintained in the parser, not all parser errors are reported with
relevant position information.

## Authors

Copyright (c) 2015-2021 Martin Elsman, Martin Dybdal, University of Copenhagen.

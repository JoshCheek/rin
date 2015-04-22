Ruby Inspect Numbers
====================

Change the base that numbers display with in Ruby.


The executable
--------------

Prints whatever the script evaluates to.
Default inspect is hex.

```sh
$ rin 'AA + 11'
BB
```

Can be told what base to use by passing the base as a flag.

```sh
$ rin -8 '7 + 7'
```

You can put whatever Ruby you want in there,
It has a naive preprocessor that swaps them to the correct values.


From a Ruby commandline script
------------------------------

From the shell, you can require rin, and output will be set by default to hex,
or to the base of the first argument to the script.

```sh
$ ruby -rin -e 'p 15'
0xF

$ ruby -rin -e 'p 15' -8
017
```


Polite Ruby script
------------------

Use in Ruby without fucking with the environment.

```ruby
require 'rin'
rin.hex { 15 }  # => "0xF"
rin.oct { 15 }  # => "017"
rin.bin { 15 }  # => "0b1111"
rin.dec { 15 }  # => "15"
```


Invasive Ruby script
--------------------

But less annoying to use

```
15 # => 15

rin.hex!
15 # => 0xF

rin.dec!
15 # => 15
```

Other things that could be fun
------------------------------

But that I don't intend to do,
unless I use this much.

* exit statuses be meaningful
  eg `rin 'BB == (AA + 11)` exits with 0
* `0d123` for decimal
* Case insensitive
* env var for for config:
  * preferred base
  * preferred format (eg uppercase/lowercase/whatev)

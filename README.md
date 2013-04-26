[![Build Status](https://secure.travis-ci.org/kjellm/shellout.png)](http://travis-ci.org/kjellm/shellout)

Shellout
========

Shellout is a collection of tools for writing user interfaces for the terminal. It contains classes for
printing tables and boxes, using unicode box drawing and block element characters.


Install
-------

    gem install shellout


Usage
-----

    require 'shellout'
    include Shellout

### Shadowboxes

    > Shadowbox("Hello world").print
    
    ┌──────────────────────────────────────────┐ 
    │               Hello world                │▒
    └──────────────────────────────────────────┘▒
      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

### Tables

    > Table(headers: %w{Team Points},
    	       rows: [['Man City', 22],
    	              ['Man Utd', 20],
    	              ['Chelsea', 19],
    	              ['Newcastle', 16]]).print
	
    ┌───────────┬────────┐
    │   Team    │ Points │
    ├───────────┼────────┤
    │ Man City  │     22 │
    │ Man Utd   │     20 │
    │ Chelsea   │     19 │
    │ Newcastle │     16 │
    └───────────┴────────┘
  

### Calendars

    > today = Date.today
     => #<Date: 2011-10-31 (...)>
    
    > Calendar(today).print
    
         October 2011
     Mo Tu We Th Fr Sa Su
                     1  2
      3  4  5  6  7  8  9
     10 11 12 13 14 15 16
     17 18 19 20 21 22 23
     24 25 26 27 28 29 30
     31
    
    > Calendar(today).print3
    
                                     2011
          September                October                 November
     Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
               1  2  3  4                    1  2        1  2  3  4  5  6
      5  6  7  8  9 10 11     3  4  5  6  7  8  9     7  8  9 10 11 12 13
     12 13 14 15 16 17 18    10 11 12 13 14 15 16    14 15 16 17 18 19 20
     19 20 21 22 23 24 25    17 18 19 20 21 22 23    21 22 23 24 25 26 27
     26 27 28 29 30          24 25 26 27 28 29 30    28 29 30
                             31


### Menus

    > Menu([
      "Do this",
      "No, this",
      "Or, maybe this",
      "Forget it, this is the right choice",
      "Amazing things will happen if you choose this",
      "Ignore #5. Pick me!",
      "I'm the obvious choice",
      "There is no end to the awesomeness that will come from choosing this",
      "Don't choose this",
      "Or this",
      "Things are getting worse",
      "Might as well choose this one",
    ]).print
    
    #  1. Do this
    #  2. No, this
    #  3. Or, maybe this
    #  4. Forget it, this is the right choice
    #  5. Amazing things will happen if you choose this
    #  6. Ignore #5. Pick me!
    #  7. I'm the obvious choice
    #  8. There is no end to the awesomeness that will come from choosing this
    #  9. Don't choose this
    # 10. Or this
    # 11. Things are getting worse
    # 12. Might as well choose this one

Bugs
----

Report bugs to <http://github.com/kjellm/shellout/issues>


Author
------

Kjell-Magne Øierud &lt;kjellm AT acm DOT org&gt;


License
-------

(The MIT License)

Copyright © 2011 Kjell-Magne Øierud

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the ‘Software’), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

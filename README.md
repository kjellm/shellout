Shellout
========

Shellout is a collection of tools for writing user interfaces for the terminal. It contains classes for
printing tables and boxes, using unicode box drawing and block element characters.


Install
-------

    gem install shellout


Usage
-----

### Shadowboxes


    require 'shellout/shadowbox'
    
    Shellout::Shadowbox.new("Hello world").print
    
    # ┌──────────────────────────────────────────┐ 
	# │               Hello world                │▒
	# └──────────────────────────────────────────┘▒
	#   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒


### Tables

    require 'shellout/table'
    
    Shellout::Table.new(headers: %w{Team Points},
	                    rows: [['Man City', 22],
	                           ['Man Utd', 20],
	                           ['Chelsea', 19],
	                           ['Newcastle', 16]]
	).print
	
	# ┌───────────┬────────┐
	# │   Team    │ Points │
	# ├───────────┼────────┤
	# │ Man City  │     22 │
	# │ Man Utd   │     20 │
	# │ Chelsea   │     19 │
	# │ Newcastle │     16 │
	# └───────────┴────────┘


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

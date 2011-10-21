Shellout
========

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


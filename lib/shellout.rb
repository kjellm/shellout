# encoding: utf-8

# Unicode box drawing characters and block elements
#
# http://en.wikipedia.org/wiki/Box-drawing_characters
#
#        0 1 2 3 4 5 6 7 8 9 A B C D E F
# U+250x ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏
# U+251x ┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ┚ ┛ ├ ┝ ┞ ┟
# U+252x ┠ ┡ ┢ ┣ ┤ ┥ ┦ ┧ ┨ ┩ ┪ ┫ ┬ ┭ ┮ ┯
# U+253x ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻ ┼ ┽ ┾ ┿
# U+254x ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╌ ╍ ╎ ╏
# U+255x ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ ╚ ╛ ╜ ╝ ╞ ╟
# U+256x ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬ ╭ ╮ ╯
# U+257x ╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╺ ╻ ╼ ╽ ╾ ╿
#
#        0 1 2 3 4 5 6 7 8 9 A B C D E F
# U+258x ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ ▊ ▋ ▌ ▍ ▎ ▏
# U+259x ▐ ░ ▒ ▓ ▔ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟

require 'shellout/calendar'
require 'shellout/shadowbox'
require 'shellout/table'

# You can mixin this module to get shortcuts to the various functionality
# provided by the classes below this namespace
module Shellout

  # See doc for Shellout::Calendar.new
  def Calendar(*whatever)
    Shellout::Calendar.new(*whatever)
  end
  
  # See doc for Shellout::Shadowbox.new
  def Shadowbox(*whatever)
    Shellout::Shadowbox.new(*whatever)
  end
  
  # See doc for Shellout::Table.new
  def Table(*whatever)
    Shellout::Table.new(*whatever)
  end
  
end

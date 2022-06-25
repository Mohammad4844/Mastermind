# Module used to change the bg color of a number, based on pre-defined mappings for shell output
module Colorize
  @color_map = {
    1 => 101, # red
    2 => 102, # green
    3 => 103, # yellow
    4 => 104, # blue
    5 => 105, # magenta
    6 => 106  # cyan
  }

  # Adds a pre-coded background color to the number n, and adds a space before and after it.
  def self.bg_color(n)
    "\e[#{@color_map[n]}m #{n} \e[0m"
  end
end

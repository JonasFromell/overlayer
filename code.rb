require 'rouge'

source = '
<button data-toggle="overlayer" data-target=".overlayer">Show overlay</button>

<div class="overlayer">
  <button data-dismiss="overlayer">x</button>
</div>
'

formatter = Rouge::Formatters::HTML.new(:css_class => "highlight")
lexer     = Rouge::Lexers::HTML.new

puts formatter.format(lexer.lex(source))

puts Rouge::Themes::Github.render(:scope => '.highlight')
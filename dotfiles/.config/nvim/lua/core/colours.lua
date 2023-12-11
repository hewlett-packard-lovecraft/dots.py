-- set colourscheme
local status_ok, color_scheme = pcall(require, 'monokai')
if not status_ok then
  return
end

require('monokai').setup { palette = require('monokai').pro }

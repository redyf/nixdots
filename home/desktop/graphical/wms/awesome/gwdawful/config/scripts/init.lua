-----------------
-- lua scripts --
-----------------

local beautiful = require('beautiful')

require('config.scripts.screenshot')
if beautiful.kb_layout2 ~= nil then
    require('config.scripts.language')
end

-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Blink.cmp handles autopairs integration automatically, no need for nvim-cmp dependency
  config = function()
    require('nvim-autopairs').setup {}
    -- Blink.cmp automatically integrates with autopairs, so no manual setup needed
  end,
}

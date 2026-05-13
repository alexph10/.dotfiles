---@diagnostic disable: undefined-global
-- Custom snippets available in all filetypes
-- Add your own snippets here using LuaSnip syntax:
--   s("trigger", t("expansion"))
--   s("trigger", { t("line1"), t({"", "line2"}) })

return {
  s("date", t(os.date("%Y/%m/%d"))),
  s("time", t(os.date("%H:%M:%S"))),
  s("datetime", t(os.date("%Y/%m/%d %H:%M:%S"))),
}

---@diagnostic disable: unused-local, unused-function
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function math()
  return vim.api.nvim_eval "vimtex#syntax#in_mathzone()" == 1
end

local function env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

local function make_fraction_from_line(text)
  local depth = 1
  local i_pos = #text

  while i_pos > 0 do
    local ch = text:sub(i_pos, i_pos)
    if ch == ")" then
      depth = depth + 1
    elseif ch == "(" then
      depth = depth - 1
      if depth == 0 then
        break
      end
    end
    i_pos = i_pos - 1
  end

  if depth ~= 0 or i_pos == 0 then
    return text
  end

  local before = text:sub(1, i_pos - 1) -- text before '('
  local inside = text:sub(i_pos + 1) -- text inside parentheses

  return before .. "\\frac{" .. inside .. "}{"
end

local latex_snippets = {
  s({ trig = "//", desc = "Fraction", snippetType = "autosnippet" }, {
    t "\\frac{",
    i(1, "$1"),
    t "}{",
    i(2, "$2"),
    t "}",
    i(0),
  }, { condition = math, show_condition = math }),
  s({
    trig = "((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)/",
    trigEngine = "ecma",
    desc = "Fraction Regex",
    snippetType = "autosnippet",
  }, {
    t "\\frac{",
    f(function(_, snip)
      return snip.captures[1]
    end),
    t "}{",
    i(1),
    t "}",
    i(0),
  }, { condition = math, show_condition = math }),
  s({
    trig = "(^.*)\\)/",
    trigEngine = "ecma",
    desc = "Fraction after ()",
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return make_fraction_from_line(snip.captures[1])
    end),
    i(1),
    t "}",
    i(0),
  }, { condition = math, show_condition = math }),
}

return latex_snippets

return {
  "windwp/nvim-autopairs",
  opts = function(_, opts)
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    npairs.add_rules {
      Rule("*", "*", "markdown"):with_pair(cond.not_before_text "*"),
      Rule("`", "`", "markdown"):with_pair(cond.not_before_text "`"),
      Rule("[", "]", "markdown"):with_pair(cond.not_before_text "]"),
      Rule("{", "}", "markdown"):with_pair(cond.not_before_text "}"),
      Rule("(", ")", "markdown"):with_pair(cond.not_before_text ")"),
      Rule("~~", "~~", "markdown"):with_pair(cond.not_before_text "~~"),
      Rule("==", "==", "markdown"):with_pair(cond.not_before_text "=="),
    }
  end,
}

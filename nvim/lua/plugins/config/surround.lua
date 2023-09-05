M = function()
    require("nvim-surround").setup {
        keymaps = {
            visual = "s",
            delete = "ds",
            change = "cs",
        },
        surrounds = {
            ["("] = {
                add = { "(", ")" },
                find = function()
                    return M.get_selection({ motion = "a(" })
                end,
                delete = "^(.?)().-(?.)()$",
            },
            ["{"] = {
                add = { "{", "}" },
                find = function()
                    return M.get_selection({ motion = "a{" })
                end,
                delete = "^(.?)().-(?.)()$",
            },
            ["["] = {
                add = { "[", "]" },
                find = function()
                    return M.get_selection({ motion = "a[" })
                end,
                delete = "^(.?)().-(?.)()$",
            },
        }
    }
end

return M

local M = {}

---@return boolean
function M.is_tty()
    return os.getenv("TERM") == "linux"
end

---@param a string
---@param b string
---@return string
function M.symbol_guard(a, b)
    return not vim.g.is_tty and a or b
end

---@param dir string
function M.mkdir(dir)
    local res = vim.fn.isdirectory(dir)
    if res == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

---@param name string
---@return boolean
function M.is_executable(name)
    return vim.fn.executable(name) > 0
end

---@param val any
---@return table
function M.tbl_wrap(val)
    return type(val) == "table" and val or { val }
end

---@class PacksLazySpec
---@field name string
---@field packs (string|vim.pack.Spec)[]
---@field event? vim.api.keyset.events|vim.api.keyset.events[]
---@field cmd? string|string[]
---@field ft? string|string[]
---@field keys? string|string[]
---@field config? fun()

---@param spec PacksLazySpec
function M.lazy(spec)
    local loaded_var = "pack_" .. spec.name .. "_loaded"

    local load = function()
        if vim.g[loaded_var] then
            return
        end

        vim.pack.add(spec.packs)
        if spec.config then
            spec.config()
        end
        vim.g[loaded_var] = true
    end

    if spec.event then
        vim.api.nvim_create_autocmd(spec.event, {
            once = true,
            callback = load
        })
    end
    if spec.cmd then
        for _, cmd in ipairs(M.tbl_wrap(spec.cmd)) do
            vim.api.nvim_create_user_command(cmd, function(opts)
                load()

                vim.cmd({
                    cmd = cmd,
                    args = opts.fargs,
                })
            end, {
                nargs = "*",
            })
        end
    end
    if spec.ft then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = spec.ft,
            once = true,
            callback = load
        })
    end
    if spec.keys then
        for _, key in ipairs(M.tbl_wrap(spec.keys)) do
            vim.keymap.set("n", key, function()
                load()

                local keys = vim.api.nvim_replace_termcodes(
                    key,
                    true,
                    false,
                    true
                )

                vim.api.nvim_feedkeys(keys, "m", false)
            end)
        end
    end
end

---@param repo string
---@return string
function M.gh(repo)
    return 'https://github.com/' .. repo
end

return M

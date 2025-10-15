if true then
    return
end

local function get_function_line(function_name)
    local bufrnr = vim.api.nvim_get_current_buf()
    local buffer_content = vim.api.nvim_buf_get_lines(bufrnr, 0, -1, false)
    for line_number, line_content in ipairs(buffer_content) do
        if line_content:find("func " .. function_name, 1, true) then
            return line_number
        end
    end
    return nil
end


vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    callback = function()
        local ns = vim.api.nvim_create_namespace("test_results")
        local bufrnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

        vim.fn.jobstart({ "go", "test", "-v", ".", "--json" }, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                for _, line in ipairs(data) do
                    if not line or line == "" or line == nil then
                        return
                    end

                    local decoded = vim.json.decode(line)
                    if decoded and decoded.Test then
                        local result = decoded.Action
                        if result == "pass" or result == "fail" then
                            local func_line = get_function_line(decoded.Test)
                            if func_line then
                                vim.api.nvim_buf_set_extmark(bufrnr, ns, func_line - 1, 0, {
                                    virt_text = {
                                        { result, result == "pass" and "String" or "ErrorMsg" } },
                                    virt_text_pos = "eol",
                                })
                            end
                        end
                    end
                end
            end,
        })
    end
})

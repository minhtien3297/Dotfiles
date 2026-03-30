return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local function patch_query_predicates()
      local query = require("vim.treesitter.query")
      local opts = vim.fn.has("nvim-0.10") == 1 and { force = true, all = false } or true

      local html_script_type_languages = {
        ["importmap"] = "json",
        ["module"] = "javascript",
        ["application/ecmascript"] = "javascript",
        ["text/ecmascript"] = "javascript",
      }

      local non_filetype_match_injection_language_aliases = {
        ex = "elixir",
        pl = "perl",
        sh = "bash",
        ts = "typescript",
        uxn = "uxntal",
      }

      local function get_capture_node(match, capture_id)
        local node = match[capture_id]
        if type(node) == "table" then
          return node[#node] or node[1]
        end
        return node
      end

      local function get_parser_from_markdown_info_string(injection_alias)
        local match = vim.filetype.match({ filename = "a." .. injection_alias })
        return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
      end

      query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
        local node = get_capture_node(match, pred[2])
        if not node then
          return
        end

        local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
        local configured = html_script_type_languages[type_attr_value]
        if configured then
          metadata["injection.language"] = configured
        else
          local parts = vim.split(type_attr_value, "/", {})
          metadata["injection.language"] = parts[#parts]
        end
      end, opts)

      query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = get_capture_node(match, pred[2])
        if not node then
          return
        end

        local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
      end, opts)

      query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local capture_id = pred[2]
        local node = get_capture_node(match, capture_id)
        if not node then
          return
        end

        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[capture_id] }) or ""
        if not metadata[capture_id] then
          metadata[capture_id] = {}
        end
        metadata[capture_id].text = string.lower(text)
      end, opts)
    end

    local parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "treesitter", "parsers")
    vim.fn.mkdir(parser_install_dir, "p")
    vim.opt.runtimepath:prepend(parser_install_dir)

    require("nvim-treesitter.configs").setup({
      parser_install_dir = parser_install_dir,
      ensure_installed = "all",
      ignore_install = { "ipkg" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })

    patch_query_predicates()
  end,
}

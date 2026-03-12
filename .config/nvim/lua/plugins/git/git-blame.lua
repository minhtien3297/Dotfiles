return {
  "f-person/git-blame.nvim",
  event = "BufReadPost",

  opts = {
    date_format = "%d/%m/%Y - %X",
    use_blame_commit_file_urls = true,
  },
}

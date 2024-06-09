return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {
          [[               ▄▄██████████▄▄             ]],
          [[               ▀▀▀   ██   ▀▀▀             ]],
          [[       ▄██▄   ▄▄████████████▄▄   ▄██▄     ]],
          [[     ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ]],
          [[    ████▄ ▄███▀              ▀███▄ ▄████  ]],
          [[   ███▀█████▀▄████▄      ▄████▄▀█████▀███ ]],
          [[   ██▀  ███▀ ██████      ██████ ▀███  ▀██ ]],
          [[    ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ]],
          [[       ███           ▀▀           ███     ]],
          [[       ██████████████████████████████     ]],
          [[   ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ]],
          [[   ███  ███ ███   ██    ██   ███▄███  ███ ]],
          [[   ▀██▄████████   ██    ██   ████████▄██▀ ]],
          [[    ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ]],
          [[     ▀███▄  ▀███████    ███████▀  ▄███▀   ]],
          [[       ▀███    ▀▀██████████▀▀▀   ███▀     ]],
          [[         ▀    ▄▄▄    ██    ▄▄▄    ▀       ]],
          [[               ▀████████████▀             ]],
          [[                                          ]],
        },
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
        },
        footer = {}
      },
    }
  end,
}

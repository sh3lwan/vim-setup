# Neovim Configuration - Plugins & Shortcuts

## Installed Plugins & Their Usage

### General
- **Lazy.nvim** - Plugin manager
- **Telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting & parsing
- **lsp-zero.nvim** - LSP configuration
- **nvim-cmp** - Autocompletion
- **nvim-lint** - Linting
- **nvim-autopairs** - Auto-close brackets & quotes
- **todo-comments.nvim** - Highlight TODO comments
- **neotest** - Test framework

### UI & Theme
- **catppuccin/nvim** - Colorscheme
- **lualine.nvim** - Statusline
- **nvim-web-devicons** - Icons

### Git
- **vim-fugitive** - Git integration
- **vim-rhubarb** - GitHub integration
- **conflict-marker.vim** - Conflict resolution

### Terminal & File Management
- **Oil.nvim** - File explorer
- **neo-tree.nvim** - File tree
- **toggleterm.nvim** - Terminal integration

### AI & Code Assistance
- **copilot.vim** - GitHub Copilot
- **avante.nvim** - AI-powered coding assistant

## Shortcut Mappings

### Buffers
| Shortcut | Action |
|----------|--------|
| `<TAB>` | Next buffer |
| `<S-TAB>` | Previous buffer |

### Terminal
| Shortcut | Action |
|----------|--------|
| `<leader>th` | Open horizontal terminal |
| `<leader>tv` | Open vertical terminal |

### File Navigation
| Shortcut | Action |
|----------|--------|
| `<leader>pv` | Open Oil file explorer |

### Telescope (Fuzzy Finder)
| Shortcut | Action |
|----------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Resume search |
| `<leader>fm` | Find functions |
| `<leader>fh` | File history (if available) |
| `<leader>fs` | Git status |
| `<leader>fc` | Git commits |
| `<leader>fB` | Git branches |

### Live Grep with Selection
| Shortcut | Action |
|----------|--------|
| `<leader>FG` | Live grep word under cursor |
| `<leader>FF` | Find files matching word under cursor |
| `<leader>FG` (Visual Mode) | Live grep selected text |

### Moving Lines in Visual Mode
| Shortcut | Action |
|----------|--------|
| `J` | Move line down |
| `K` | Move line up |

## Installation
Make sure to have `Lazy.nvim` installed. Place the above Neovim configuration in your `init.lua` or `lazy.lua` file and reload Neovim.


(local autocmd vim.api.nvim_create_autocmd)
(local usercmd vim.api.nvim_create_user_command)

; Autocommands

(autocmd [:InsertEnter] {:callback (fn [] (set vim.o.relativenumber false))})
(autocmd [:InsertLeave] {:callback (fn [] (set vim.o.relativenumber true))})

(autocmd [:UIEnter] {:command ":silent !kitty @ set-spacing padding-bottom=10"})

(autocmd [:VimLeavePre]
         {:command ":silent !kitty @ set-spacing padding-bottom=default"})

(autocmd [:TextYankPost]
         {:callback (fn [] (vim.highlight.on_yank))
          :desc "Highlight when yanking text"})

; (autocmd [:Colorscheme :UIEnter]
;          {:callback (fn []
;                       (local bg (. (vim.api.nvim_get_hl_by_name :Normal true)
;                                    :background))
;                       (local bghex (string.format "#%06x" bg))
;                       (os.execute (.. "kitty @ set-colors -c background=\"" bghex
;                                       "\"")))})
; (autocmd [:VimLeavePre]
;          {:command ":silent !kitty @ set-colors --reset"})
;

; User Commands

(usercmd :AddSpacers
         (fn []
           (let [bufnr (vim.api.nvim_get_current_buf)
                 lines (vim.api.nvim_buf_line_count bufnr)
                 ns (vim.api.nvim_create_namespace :VirtSpacers)]
             (for [i 1 lines]
               (vim.api.nvim_buf_set_extmark bufnr ns (- i 1) 0
                                             {:virt_lines [[["" ""]]]}))))
         {:desc "Add Virtual Spacers"})

(usercmd :WriterOn (fn [] (set vim.o.wrap true)
                     (vim.keymap.set [:n :x] :j :gj)
                     (vim.keymap.set [:n :x] :k :gk))
         {:desc "Enter Writing Mode"})

(usercmd :WriterOff (fn [] (set vim.o.wrap false)
                      (vim.keymap.set [:n :x] :j :j)
                      (vim.keymap.set [:n :x] :k :k))
         {:desc "Leave Writing Mode"})

(usercmd :ListCharsOn (fn [] (set vim.o.list true)) {:desc "Enable list chars"})
(usercmd :ListCharsOff (fn [] (set vim.o.list false))
         {:desc "Disable list chars"})


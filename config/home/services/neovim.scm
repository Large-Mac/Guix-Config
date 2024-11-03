
(define-module (home services neovim)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (gnu packages vim)
  #:export (neovim-services))

(define lazy-config
  `((let ((lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim")))
      (if (not (vim.loop.fs_stat lazypath))
        (vim.system
          [(.. "git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " lazypath)]))
      (vim.opt.rtp:prepend lazypath))

    ;; Example plugin configurations
    (local plugins
      [
       ;; LSP Support
       {:name "mason"
        :url "https://github.com/williamboman/mason.nvim"
        :config (lambda [] ((. (require :mason) :setup)))}
       
       ;; Completion
       {:name "nvim-cmp"
        :url "https://github.com/hrsh7th/nvim-cmp"
        :config (lambda [] 
                  (local cmp (require :cmp))
                  (cmp.setup {}))}

       ;; Treesitter
       {:name "nvim-treesitter"
        :url "https://github.com/nvim-treesitter/nvim-treesitter"
        :config (lambda []
                  ((. (require :nvim-treesitter.configs) :setup)
                   {:ensure_installed [:lua :vim :vimdoc]
                    :auto_install true}))}
      ])

    ((. (require :lazy) :setup) plugins
     {:defaults {:lazy true}
      :install {:colorscheme [:tokyonight]}})

    ;; Basic settings
    (set vim.opt.number true)
    (set vim.opt.relativenumber true)
    (set vim.opt.shiftwidth 2)
    (set vim.opt.tabstop 2)
    (set vim.opt.expandtab true)
    (set vim.opt.mouse "a")))

(define neovim-service
  (service home-neovim-service-type
           (home-neovim-configuration
            (package neovim)
            (extra-lua-config
             (list
              #~(begin
                  #$@lazy-config))))))

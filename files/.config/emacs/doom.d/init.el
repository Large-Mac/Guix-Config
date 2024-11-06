(doom! :input
       :completion
       company
       (ivy +fuzzy +prescient +icons)
       
       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       ophints
       (popup +defaults)
       workspaces
       
       :editor
       (evil +everywhere)
       file-templates
       fold
       format
       multiple-cursors
       
       :emacs
       dired
       electric
       undo
       vc
       
       :term
       eshell
       
       :checkers
       syntax
       
       :tools
       magit
       
       :lang
       emacs-lisp
       markdown
       org
       (scheme +guile)
       
       :config
       (default +bindings +smartparens))

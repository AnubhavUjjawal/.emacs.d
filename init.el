                                        ; Anubhav's Emac Configuration
                                        ; 7th September 2024
					; NOTE: Before running emacs, make sure to build tree-sitter-module by running the `./batch.sh` command

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

(defun indent-whole-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

; (setq x-select-enable-clipboard t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(load-theme 'modus-vivendi)
                                        ; remove toolbar when opening emacs in GUI
(tool-bar-mode -1)

					; Note: the below will only work if we have built the language definitions
					; NOTE: builtin treesitter documentation: https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=feature/tree-sitter
(setq treesit-extra-load-path '("~/.emacs.d/tree-sitter-module/dist"))


(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(package-install 'use-package)

                                        ; Vertico is for better minibuffer completion
(use-package vertico
  :defer t
  :ensure t
  :init
  (vertico-mode))

                                        ; company mode completion at point
(use-package company
  :ensure t
  :bind
  ;; (:map company-active-map
  ;;       ([tab] . 'company-complete)
  ;;       ("TAB" . 'company-complete))
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-require-match 'never)
  ;; Trigger completion immediately.
  (company-idle-delay 0.1)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
  (setq company-text-face-extra-attributes
        '(:weight bold :slant italic))
  (setq company-text-icons-add-background t)
  (global-company-mode 1))

(use-package magit
  :ensure t
  :defer t)

(use-package lua-mode
  :ensure t
  :defer t
  :mode
  ("\\.lua$" . lua-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(package-selected-packages '(tree-sitter-langs tree-sitter lua-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

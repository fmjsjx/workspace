(global-unset-key (kbd "<f10>"))
(global-set-key (kbd "<f7>") 'split-window-vertically)
(global-set-key (kbd "<f8>") 'split-window-horizontally)
(global-set-key (kbd "<f12>") 'other-window)
(global-set-key (kbd "<f11>") 'other-window)
(global-set-key (kbd "<f9> <f9>") 'delete-window)
(global-set-key (kbd "<f9> f") 'delete-other-windows)
(global-set-key (kbd "<f9> o") 'occur)
(global-set-key (kbd "<f10> S") 'find-dired)
(global-set-key (kbd "<f10> l") 'list-buffers)
(global-set-key (kbd "<f10> o") 'find-file)
(global-set-key (kbd "<f10> p") 'package-list-packages)
(global-set-key (kbd "<f10> P") 'package-list-packages-no-fetch)
(global-set-key (kbd "<f10> s") 'find-name-dired)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-a") 'smart-line-beginning)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-x C-j") 'dired-open-current-directory)
(setq kill-whole-line t)
(global-set-key (kbd "C-<f10>") 'join-line)
(global-set-key (kbd "M-j") 'new-line-at-end)
(setq make-backup-files nil)

(require 'linum)
(global-linum-mode 1)

(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already the current position of point, then move it to the beginning of the line."
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

;;; proxy
(setq url-using-proxy t)
(setq url-proxy-services '(("http". "localhost:8087")
			   ("no_proxy". ".*localhost.*")))

;;; dired current buffer file directory
(defun dired-open-current-directory ()
  (interactive)
  (if (buffer-file-name)
      (dired default-directory)))

;;; window theme
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; full screen
(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
               '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
               '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(fullscreen)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes (quote ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#073642")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

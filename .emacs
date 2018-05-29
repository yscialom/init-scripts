;; -*- utf-8 -*-
;;
;; @file .emacs
;; @author Yankel Scialom (YSC) <yankel\@scialom.org>
;; @date 2018-05-29
;; @brief My .emacs init script.
;;


;;
;; START-UP UI -----------------------------------------------------------------------------------------
;;
(setq frame-title-format (concat  "%b - emacs@" (system-name)))      ;; default to better frame titles
(tool-bar-mode -1)                                                   ;; Disable toolbar
(global-linum-mode 1)                                                ;; Enable line numbers
(setq mouse-wheel-progressive-speed nil)                             ;; disable progressive wheel speed

;; default background-color, font and frame size
(add-to-list 'default-frame-alist '(background-color . "#FFFFEA"))
(set-face-attribute 'default nil :height 115)
(add-to-list 'default-frame-alist '(fullscreen . maximized))



;;
;; START-UP NON-UI stuff -------------------------------------------------------------------------------
;;
(server-start)


;;
;; PACKAGES --------------------------------------------------------------------------------------------
;;
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


;;
;; GENERAL TEXT ----------------------------------------------------------------------------------------
;;
(setq require-final-newline 'query)                                  ;; always end a file with a newline



;;
;; C-MODE ----------------------------------------------------------------------------------------------
;;
(set-default 'tab-width 4)                                           ;; <TAB> is 4 character wide
(setq tab-stop-list (number-sequence 4 200 4))                       ;; <TAB> is 4 character wide
(setq-default indent-tabs-mode nil)                                  ;; <TAB> inserts SPACES only
(setq c-default-style "linux")                                       ;; Linux -style indentation
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4 t)
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (markdown-mode csv-mode)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(show-paren-mode 1)                                                  ;; C visual help



;;
;; C++-MODE --------------------------------------------------------------------------------------------
;;
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)



;;
;; FUNCTIONS -------------------------------------------------------------------------------------------
;;
(defun indent-buffer ()
  "Indent buffer according to current mode and style"
  (interactive)
  (indent-region (point-min) (point-max))
  )
(defun clean-buffer ()
  "Untabify and delete trailing whitespaces on buffer"
  (interactive)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace)
  )
(defun clean-file (file)
  "Apply clean-buffer and save on file"
  (interactive "sFile to clean: ")
  (switch-to-buffer (find-file-in-largest-window file))
  (clean-buffer)
  (save-buffer)
  (kill-buffer)
  )
(defun unix-file ()
  "Change the current buffer to Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'unix t))
(defun dos-file ()
  "Change the current buffer to DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'dos t))


;;
;; BINDINGS --------------------------------------------------------------------------------------------
;;
;;; Unbind the stupid minimize that I always hit:
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
;; Remap C-x C-b to ibuffer:
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; C-<TAB> autocompletes:
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
;; C-x C-<TAB> indent whole buffer:
(global-set-key (kbd "C-x C-<tab>") 'indent-buffer)
;; C-pgup C-pgdown for windows circling
(global-set-key [(ctrl previous)] '(lambda () (interactive) (other-window -1)))
(global-set-key [(ctrl next)] '(lambda () (interactive) (other-window 1)))


;;
;; ACTIVATE "EXPORT" COMMANDS --------------------------------------------------------------------------
;;
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;; END ;;

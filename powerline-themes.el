;;; powerline-themes.el --- Themes for Powerline

;; Copyright (C) 2012-2013 Donald Ephraim Curtis
;; Copyright (C) 2013 Jason Milkins
;; Copyright (C) 2012 Nicolas Rougier

;; Author: Donald Ephraim Curtis <dcurtis@milkbox.net>
;; URL: http://github.com/milkypostman/powerline/
;; Version: 2.0
;; Keywords: mode-line

;;; Commentary:
;;
;; Themes for Powerline.
;; Included themes: default, center, center-evil, vim, and nano.
;;

;;; Code:


;;;###autoload
(defun powerline-default-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-size nil 'l)
                                     (powerline-raw mode-line-mule-info nil 'l)
                                     (powerline-buffer-id nil 'l)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-major-mode face1 'l)
                                     (powerline-process face1)
                                     (powerline-minor-modes face1 'l)
                                     (powerline-narrow face1 'l)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-vc face2 'r)))
                          (rhs (list (powerline-raw global-mode-string face2 'r)
                                     (funcall separator-right face2 face1)
                                     (powerline-raw "%4l" face1 'l)
                                     (powerline-raw ":" face1 'l)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-center-theme ()
  "Setup a mode-line with major and minor modes centered."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-size nil 'l)
                                     (powerline-buffer-id nil 'l)
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (powerline-narrow face1 'l)
                                     (powerline-vc face1)))
                          (rhs (list (powerline-raw global-mode-string face1 'r)
                                     (powerline-raw "%4l" face1 'r)
                                     (powerline-raw ":" face1)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1)))
                          (center (list (powerline-raw " " face1)
                                        (funcall separator-left face1 face2)
                                        (when (boundp 'erc-modified-channels-object)
                                          (powerline-raw erc-modified-channels-object face2 'l))
                                        (powerline-major-mode face2 'l)
                                        (powerline-process face2)
                                        (powerline-raw " :" face2)
                                        (powerline-minor-modes face2 'l)
                                        (powerline-raw " " face2)
                                        (funcall separator-right face2 face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill face1 (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-vim-theme ()
  "Setup a Vim-like mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-major-mode mode-line)
                                     (powerline-process mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (buffer-modified-p)
                                       (powerline-raw "[+]" mode-line))
                                     (when buffer-read-only
                                       (powerline-raw "[RO]" mode-line))
                                     (powerline-raw "[%z]" mode-line)
                                     ;; (powerline-raw (concat "[" (mode-line-eol-desc) "]") mode-line)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-minor-modes mode-line)
                                     (powerline-raw "%n" mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (and vc-mode buffer-file-name)
                                       (let ((backend (vc-backend buffer-file-name)))
                                         (when backend
                                           (concat (powerline-raw "[" mode-line 'l)
                                                   (powerline-raw (format "%s / %s" backend (vc-working-revision buffer-file-name backend)))
                                                   (powerline-raw "]" mode-line)))))))
                          (rhs (list (powerline-raw '(10 "%i"))
                                     (powerline-raw global-mode-string mode-line 'r)
                                     (powerline-raw "%l," mode-line 'l)
                                     (powerline-raw (format-mode-line '(10 "%c")))
                                     (powerline-raw (replace-regexp-in-string  "%" "%%" (format-mode-line '(-3 "%p"))) mode-line 'r))))
                     (concat (powerline-render lhs)
                             (powerline-fill mode-line (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-nano-theme ()
  "Setup a nano-like mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (lhs (list (powerline-raw (concat "GNU Emacs "
                                                            (number-to-string
                                                             emacs-major-version)
                                                            "."
                                                            (number-to-string
                                                             emacs-minor-version))
                                                    nil 'l)))
                          (rhs (list (if (buffer-modified-p) (powerline-raw "Modified" nil 'r))))
                          (center (list (powerline-raw "%b" nil))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center nil (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))
;;;###autoload
(defun powerline-center-evil-theme ()
  "Setup a mode-line with major, evil, and minor modes centered."
  (interactive)
  (setq-default
   mode-line-format
   '("%e"
     (:eval
      (let* ((active (powerline-selected-window-active))
             ;; (mode-line (if active 'mode-line 'mode-line-inactive))
             (face1 (if active 'powerline-active1 'powerline-inactive1))
             (face2 (if active 'powerline-active2 'powerline-inactive2))
             (separator-left (intern (format "powerline-%s-%s"
                                             powerline-default-separator
                                             (car powerline-default-separator-dir))))
             (separator-right (intern (format "powerline-%s-%s"
                                              powerline-default-separator
                                              (cdr powerline-default-separator-dir))))
             (lhs (list
                   (powerline-raw mode-line-mule-info face2 'l)
                   (powerline-client face2)
                   (powerline-raw mode-line-modified face2)
                   (powerline-remote face2)
                   (powerline-raw " " face2)
                   (powerline-frame-id face2)
                   (powerline-buffer-id face2 'l)
                   (powerline-raw " " face2)
                   (funcall separator-left face2 face1)
                   (powerline-narrow face1 'l)
                   (powerline-vc face1)
                   (when (eq major-mode 'paradox-menu-mode)
                     (powerline-paradox face1 'l))))
             (rhs
              (append
               (when (and (boundp 'which-function-mode) which-function-mode)
                 (list
                  (powerline-raw "[" face1)
                  (powerline-which-func)
                  (powerline-raw "]" face1)))
               (when (eq major-mode 'life-mode)
                 (list
                  (powerline-raw "[" face1)
                  (powerline-life face1)
                  (powerline-raw "]" face1 'r)))
               ;; (when (and (boundp 'fancy-battery-mode) fancy-battery-mode)
               ;;   (list
               ;;    (powerline-fancy-battery)))
               (list
                (when (and (boundp 'wc-mode) wc-mode)
                  (powerline-wc-mode face1 'r))
                (powerline-raw global-mode-string face1 'r)
                (powerline-raw " " face1)
                (funcall separator-right face1 face2)
                (powerline-position face2 'r)
                (when powerline-use-hud (powerline-hud face2 face1))
                )))
             (center
              (append
               (list (powerline-raw " " face1)
                     (funcall separator-left face1 face2)
                     (when (boundp 'erc-modified-channels-object)
                       (powerline-raw erc-modified-channels-object face2 'l))
                     (powerline-raw
                      (if (and (boundp 'mode-line-debug-mode) mode-line-debug-mode)
                          (mode-line-debug-control)
                        " ")
                      face2)
                     (powerline-recursive-left face2)
                     (powerline-major-mode face2)
                     (powerline-process face2)
                     (powerline-raw " " face2))
               (let ((evil-face (powerline-evil-face active)))
                 (if (split-string (format-mode-line minor-mode-alist))
                     (list (funcall separator-right face2 evil-face)
                           (powerline-raw (powerline-evil-tag) evil-face 'l)
                           (powerline-raw " " evil-face)
                           (funcall separator-left evil-face face2)
                           (powerline-minor-modes face2 'l)
                           (powerline-recursive-right face2)
                           (powerline-raw " " face2)
                           (funcall separator-right face2 face1))
                   (list (powerline-raw (concat " " evil-mode-line-tag " ") evil-face)
                         (powerline-recursive-right evil-face)
                         (funcall separator-right evil-face face1)))))))
        (concat (powerline-render lhs)
                (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                (powerline-render center)
                (powerline-fill face1 (powerline-width rhs))
                (powerline-render rhs)))))))

;;;###autoload
(defun powerline-evil-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default
   mode-line-format
   '("%e"
     (:eval
      (let* ((active (powerline-selected-window-active))
             ;; (mode-line (if active 'mode-line 'mode-line-inactive))
             (face1 (if active 'powerline-active1 'powerline-inactive1))
             (face2 (if active 'powerline-active2 'powerline-inactive2))
             (face3 (if active 'powerline-active3 'powerline-inactive2))
             (separator-left (intern (format "powerline-%s-%s"
                                             powerline-default-separator
                                             (car powerline-default-separator-dir))))
             (separator-right (intern (format "powerline-%s-%s"
                                              powerline-default-separator
                                              (cdr powerline-default-separator-dir))))
             (lhs
              (append
               (let ((evil-face (powerline-evil-face active)))
                 (list
                  (powerline-raw (powerline-evil-tag) evil-face)
                  (funcall separator-left evil-face face3)))
               (list (powerline-raw " " face3)
                     (powerline-raw mode-line-mule-info face3 'l)
                     (powerline-client face3)
                     (powerline-remote face3)
                     (powerline-frame-id face3)
                     (powerline-buffer-id face3 'l)
                     (powerline-raw " " face3)
                     (funcall separator-left face3 face2)
                     (powerline-raw mode-line-modified face2 'l)
                     (when (eq major-mode 'paradox-menu-mode)
                       (powerline-paradox face2 'l))
                     (powerline-raw " " face2)
                     (funcall separator-left face2 face1)
                     (when (boundp 'erc-modified-channels-object)
                       (powerline-raw erc-modified-channels-object face1 'l))
                     (powerline-raw " " face1)
                     (powerline-raw
                      (if (and (boundp 'mode-line-debug-mode) mode-line-debug-mode)
                          (mode-line-debug-control)
                        " ")
                      face1)
                     (powerline-recursive-left face1)
                     (powerline-major-mode face1)
                     (powerline-process face1)
                     (powerline-minor-modes face1 'l)
                     (powerline-narrow face1 'l)
                     (powerline-recursive-right face1)
                     (powerline-raw "  " face1)
                     (funcall separator-left face1 face2)
                     (powerline-vc face2 'r))))
             (rhs
              (append
               (when (and (boundp 'which-function-mode) which-function-mode)
                 (list
                  (powerline-raw "[" face2)
                  (powerline-which-func)
                  (powerline-raw "]" face2)))
               (when (eq major-mode 'life-mode)
                 (list
                  (powerline-raw "[" face2)
                  (powerline-life face2)
                  (powerline-raw "]" face2 'r)))
               (list
                (when (and (boundp 'wc-mode) wc-mode)
                  (powerline-wc-mode face2 'r))
                (funcall separator-right face2 face1)
                (powerline-raw "  " face1)
                (powerline-raw global-mode-string face1 'r)
                (powerline-raw " " face1)
                (funcall separator-right face1 face2)
                (powerline-position face2 'r)
                (when powerline-use-hud (powerline-hud face2 face1))))))
        (concat (powerline-render lhs)
                (powerline-fill face2 (powerline-width rhs))
                (powerline-render rhs)))))))

(provide 'powerline-themes)

;;; powerline-themes.el ends here

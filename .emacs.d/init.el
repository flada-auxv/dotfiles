(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

;; Emacsからの質問をy/nで回答する;
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;キーバインド
;; 前のページへ
(define-key global-map (kbd "C-h") 'scroll-down)
;; ウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-q") 'other-window)
;; シェルコマンドを実行
(define-key global-map (kbd "C-j") 'shell-command)
;; キーバインド一覧
(define-key global-map (kbd "C-c C-d") 'describe-bindings)
;; cua-mode
(define-key global-map (kbd "C-c C-q") 'cua-set-rectangle-mark)
;; 折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; コメント/アンコメント切り替え
;;(define-key global-map (kbd "C-c ;") 'comment-dwim) 
;;(define-key global-map (kbd "C-c ;") 'comment-or-uncomment-region)

;;;;;環境変数の設定
;; パス
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")

;;; 文字コードを指定する
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;; ファイル名の扱い
;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windowsの場合のファイル名の設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;;;;;フレームについて
;; カラム番号も表示
(column-number-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;;;;表示関係
;; 半透明に
(set-frame-parameter nil 'alpha 80)
;; カラーテーマ
(when (require 'color-theme nil t)
  ;; テーマを読み込むための設定
  (color-theme-initialize)
  ;; テーマhoberに変更する
  (color-theme-hober))
;; midnight
;; tty-dark

;; フォントの設定
(when (eq window-system 'ns)
  ;; asciiフォントをMenloに
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120)
  ;; 日本語フォントをヒラギノ明朝 Proに
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; 英語名の場合
   ;; (font-spec :family "Hiragino Mincho Pro"))
   (font-spec :family "ヒラギノ明朝 Pro"))
  ;; ひらがなとカタカナをモトヤシーダに
  ;; U+3000-303F	CJKの記号および句読点
  ;; U+3040-309F	ひらがな
  ;; U+30A0-30FF	カタカナ
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "NfMotoyaCedar"))
  ;; フォントの横幅を調節する
  (setq face-font-rescale-alist
        '((".*Menlo.*" . 1.0)
          (".*Hiragino_Mincho_Pro.*" . 1.2)
          (".*nfmotoyacedar-bold.*" . 1.2)
          (".*nfmotoyacedar-medium.*" . 1.2)
          ("-cdac$" . 1.3))))

(when (eq system-type 'windows-nt)
  ;; asciiフォントをConsolasに
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 120)
  ;; 日本語フォントをメイリオに
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family "メイリオ"))
  ;; フォントの横幅を調節する
  (setq face-font-rescale-alist
        '((".*Consolas.*" . 1.0)
          (".*メイリオ.*" . 1.15)
          ("-cdac$" . 1.3))))

;; 対応する括弧のハイライト
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル: expressionは括弧内も強調表示
(setq show-paren-style 'expression)


;;;;;バックアップとオートセーブ
;; 場所
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; オートセーブファイル作成までの秒間隔
(setq auto-save-timeout 15)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 60)


;;;;;インストール関係
;; auto-install
(when (require 'auto-install nil t)
  ;; インストールディレクトリを設定する 初期値は ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelisp の名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;; install-elisp の関数を利用可能にする
  (auto-install-compatibility-setup))

;; package.el
(when (require 'package nil t)
  ;; パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))

;;;;;ツール/モード
;; redo+
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-r") 'redo))

;; auto-complete
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; ruby-mode
(require 'auto-complete-ruby)
;; よくわからんが動いてない
(when (require 'auto-complete nil t)
   (global-auto-complete-mode t)
   (setq ac-dwim nil)
   (set-face-background 'ac-selection-face "steelblue")
;;   (set-face-background 'ac-menu-face "skyblue")
   (setq ac-auto-start t)
   (global-set-key "\M-/" 'ac-start)
   (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
   (add-hook 'ruby-mode-hook
             (lambda ()
               (require 'rcodetools)
               (require 'auto-complete-ruby)
               (make-local-variable 'ac-omni-completion-sources)
               (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools)))))))

;; cua-mode
(cua-mode t) ; cua-modeをオン
(setq cua-enable-cua-keys nil) ; CUAキーバインドを無効にする

;; rinari  https://github.com/technomancy/rinari.git
;; 以下の手順を踏む必要がある
;; cd rinari
;; git submodule init 
;; git submodule update
(require 'rinari)

;; rhtml-mode  https://github.com/eschulte/rhtml.git
(when (require 'rhtml-mode nil t)
  (add-hook 'rhtml-mode-hook
	    (lambda () (rinari-launch)))
)

;; yaml-mode  https://github.com/yoshiki/yaml-mode
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
)

;; js2-mode  https://github.com/mooz/js2-mode.git
(when (require 'js2-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
)
;; auto-complete-modeに追加
(setq ac-modes (append '(js2-mode)))

;; coffee-mode  https://github.com/defunkt/coffee-mode.git
(when (require 'coffee-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
  (add-hook 'coffee-mode-hook
	    '(lambda () (setq tab-width 2)))
)

;; flymake-coffee  https://github.com/purcell/flymake-coffee.git
(when (require 'flymake-coffee nil t)
  (add-hook 'coffee-mode-hook 'flymake-coffee-load)
)

;; scss-mode  https://github.com/antonj/scss-mode.git
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; multi-term  M-x package-install RET multi-term RET
;; 使うシェルの種類も指定しているので注意
(when (require 'multi-term nil t)
  (setq multi-term-program "/usr/local/bin/zsh"))

;; dired拡張(標準)
(load "dired-x")

;; scheme-complete.el
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(progn (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)))
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
  (lambda ()
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (eldoc-mode t)
    (setq lisp-indent-function 'scheme-smart-indent-function)))

;; quack
(require 'quack)

;; Gauche
(setq process-coding-system-alist
 (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq gosh-program-name "/usr/local/bin/gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window ()
 "Run scheme on other window"
 (interactive)
 (switch-to-buffer-other-window
 (get-buffer-create "*scheme*"))
 (run-scheme gosh-program-name))
(define-key global-map
 "\C-cg" 'scheme-other-window)



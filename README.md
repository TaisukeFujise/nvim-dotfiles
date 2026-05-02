# Neovim 設定

lazy.nvim で管理する個人設定。全プラグイン設定は `lua/config/plugins.lua` に集約。

## 構成

```
init.lua              # エントリポイント（リーダー: Space）
lua/config/
  lazy.lua            # lazy.nvim ブートストラップ
  options.lua         # エディタ設定
  keymaps.lua         # グローバルキーマップ
  plugins.lua         # 全プラグイン設定
```

## キーマップ

→ [KEYMAP.md](KEYMAP.md) 参照

## 主なプラグイン

| 役割 | プラグイン |
|------|-----------|
| ファイラ | oil.nvim |
| ファイル検索・grep | snacks.nvim |
| LSP | nvim-lspconfig（Lua / C / Go） |
| Git | gitsigns.nvim, lazygit（toggleterm経由） |
| UI | moonfly, barbar.nvim, noice.nvim |
| その他 | nvim-treesitter, nvim-autopairs, Comment.nvim, 42-header.nvim |

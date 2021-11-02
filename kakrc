source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload
plug "kakounedotcom/prelude.kak"
plug "alexherbo2/auto-pairs.kak"
plug "andreyorst/fzf.kak"
plug "occivink/kakoune-vertical-selection"

map global insert <tab> '<a-;><a-gt>'
map global insert <s-tab> '<a-;><a-lt>'
map global normal <c-a> ': fzf-mode<ret>'

map global user v     ': vertical-selection-down<ret>'
map global user <a-v> ': vertical-selection-up<ret>'
map global user V     ': vertical-selection-up-and-down<ret>'

add-highlighter global/ number-lines
add-highlighter global/ wrap

colorscheme commentary

hook global WinCreate ^[^*]+$ %{editorconfig-load}

# Display time in statusline
# set global modelinefmt '%sh{date}'
set global modelinefmt '{{mode_info}} %val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} - %val{client}@[%val{session}] - %sh{date "+%T"}'

set-option global auto_pairs ( ) { } [ ] '"' '"' "'" "'" ` ` “ ” ‘ ’ « » ‹ ›
enable-auto-pairs

hook global NormalKey y|d|c %{ nop %sh{
      printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
        lsp-enable-window
}
# set global disabled_hooks '.+-highlight'


" ORGMODE
let g:org_agenda_files=['~/org/index.org']
let g:org_todo_keywords = [['TODO(t)', 'DONE(d)', 'WIP(w)', 'CANCELED(c)', 'BLOCKED(b)', 'UNPLANNED(u)']]
let g:org_heading_highlight_colors = ['Title', 'Constant', 'Identifier', 'Statement', 'PreProc', 'Type', 'Special']
let g:org_todo_keyword_faces =
    \[
    \ ['WIP', [':foreground #00afdf']],
    \ ['CANCELED',  [':foreground #666666']],
    \ ['BLOCKED', [':foreground #af0000']],
    \ ['DONE', [':foreground #00df00']],
    \ ['TODO', [':foreground #dadada']],
    \ ['UNPLANNED', [':foreground #d8a657']],
    \]

" Orgmode open hyperlinks
let g:utl_cfg_hdl_scm_http_system="silent !open '%u'"
let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http_system

" ORG MODE Custom theme colors
hi _Aqua         ctermfg=108 guifg=#8ec07c
hi _AquaBold     cterm=bold ctermfg=108 guifg=#8ec07c
hi _BlueBold     cterm=bold ctermfg=109 guifg=#83a598
hi _Cyan         cterm=bold ctermfg=39 guifg=#00afdf
hi _DarkRedBold  cterm=bold guifg=#870000
hi _GreenBold    cterm=bold guifg=#00df00
hi _GreyBold     cterm=bold guifg=#666666
hi _LightRedBold cterm=bold ctermfg=167 guifg=#ea6962
hi _PurpleBold   cterm=bold ctermfg=175 guifg=#d3869b
hi _WhiteBold    cterm=bold ctermfg=175 guifg=#dadada
hi _YellowBold   cterm=bold guifg=#d8a657
hi org_bold      cterm=bold gui=bold
hi org_italic    cterm=italic gui=italic
hi org_underline cterm=underline gui=underline

hi link org_block_delimiter Comment
hi link org_code String
hi link org_comment Comment
hi link org_deadline_scheduled _Aqua
hi link org_heading1 Title
hi link org_heading2 _PurpleBold
hi link org_heading3 _BlueBold
hi link org_heading4 _LightRedBold
hi link org_heading5 _AquaBold
hi link org_heading6 _YellowBold
hi link org_key_identifier Comment
hi link org_list_bullet _BlueBold
hi link org_list_checkbox _Aqua
hi link org_list_def _Aqua
hi link org_list_ordered _BlueBold
hi link org_list_unordered Identifier
hi link org_properties_delimiter _Aqua
hi link org_property Statement
hi link org_property_value Constant
hi link org_shade_stars EndOfBuffer
hi link org_subtask_number String
hi link org_subtask_number_all _BlueBold
hi link org_subtask_percent String
hi link org_subtask_percent_100 _BlueBold
hi link org_table_separator Type
hi link org_timestamp _Aqua
hi link org_timestamp_inactive Comment
hi link org_title Title
hi link org_verbatim String
hi link org_todo_keyword_TODO _WhiteBold
hi link org_todo_keyword_WIP _Cyan
hi link org_todo_keyword_DONE _GreenBold
hi link org_todo_keyword_CANCELED _GreyBold
hi link org_todo_keyword_BLOCKED _DarkRedBold
hi link org_todo_keyword_UNPLANNED _YellowBold

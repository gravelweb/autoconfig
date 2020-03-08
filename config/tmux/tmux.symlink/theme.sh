# colours
tm_colour_active=colour181
tm_colour_inactive=colour241
tm_colour_feature=colour13
tm_colour_music=colour147
tm_colour_active_border=colour247

# window title colours
set-window-option -g window-status-current-style fg=$tm_colour_active,bg=default
set-window-option -g window-status-current-format "#[bold]#I #W"

# pane border
set-option -g pane-border-style fg=$tm_colour_inactive
set-option -g pane-active-border-style fg=$tm_colour_active_border

# message text
set-option -g message-style bg=default,fg=$tm_colour_active

# pane number display
set-option -g display-panes-active-colour $tm_colour_active
set-option -g display-panes-colour $tm_colour_inactive

# clock
set-window-option -g clock-mode-colour $tm_colour_active

# status bar
set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

set-option -g status-style fg=$tm_colour_active,bg=default,default

tm_spotify="#[fg=$tm_colour_music]#(~/.tmux/spotify.py)"

tm_data="#[fg=$tm_colour_inactive] %R %d %b"
tm_host="#[fg=$tm_colour_feature,bold]#h"
tm_session_name="#[fg=$tm_colour_feature,bold]$tm_icon #S"

set -g status-left $tm_session_name' '
set -g status-right $tm_spotify' '$tm_date' '$tm_host

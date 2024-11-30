if not status is-interactive
    exit
end

set -g __done_version 1.19.3


function __done_get_focused_window_id
    if type -q lsappinfo
        lsappinfo info -only bundleID (lsappinfo front | string replace 'ASN:0x0-' '0x') | cut -d '"' -f4
    else if test -n "$SWAYSOCK"
        and type -q jq
        swaymsg --type get_tree | jq '.. | objects | select(.focused == true) | .id'
    else if test -n "$HYPRLAND_INSTANCE_SIGNATURE"
        hyprctl activewindow | awk 'NR==1 {print $2}'
    else if begin
            test "$XDG_SESSION_DESKTOP" = gnome; and type -q gdbus
        end
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval 'global.display.focus_window.get_id()'
    else if type -q xprop
        and test -n "$DISPLAY"
        # Test that the X server at $DISPLAY is running
        and xprop -grammar >/dev/null 2>&1
        xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2
    end
end

function __done_is_tmux_window_active
    set -q fish_pid; or set -l fish_pid %self

    # find the outermost process within tmux
    # ppid != "tmux" -> pid = ppid
    # ppid == "tmux" -> break
    set tmux_fish_pid $fish_pid
    while set tmux_fish_ppid (ps -o ppid= -p $tmux_fish_pid | string trim)
        # remove leading hyphen so that basename does not treat it as an argument (e.g. -fish), and return only
        # the actual command and not its arguments so that basename finds the correct command name.
        # (e.g. '/usr/bin/tmux' from command '/usr/bin/tmux new-session -c /some/start/dir')
        and ! string match -q "tmux*" (basename (ps -o command= -p $tmux_fish_ppid | string replace -r '^-' '' | string split ' ')[1])
        set tmux_fish_pid $tmux_fish_ppid
    end

    # tmux session attached and window is active -> no notification
    # all other combinations -> send notification
    tmux list-panes -a -F "#{session_attached} #{window_active} #{pane_pid}" | string match -q "1 1 $tmux_fish_pid"
end

function __done_is_screen_window_active
    string match --quiet --regex "$STY\s+\(Attached" (screen -ls)
end

function __done_is_process_window_focused
    # Return false if the window is not focused

    set __done_focused_window_id (__done_get_focused_window_id)
    if test "$__done_sway_ignore_visible" -eq 1
        and test -n "$SWAYSOCK"
        string match --quiet --regex "^true" (swaymsg -t get_tree | jq ".. | objects | select(.id == "$__done_initial_window_id") | .visible")
        return $status
    else if test -n "$HYPRLAND_INSTANCE_SIGNATURE"
        and test $__done_initial_window_id = (hyprctl activewindow | awk 'NR==1 {print $2}')
        return $status
    else if test "$__done_initial_window_id" != "$__done_focused_window_id"
        return 1
    end
    # If inside a tmux session, check if the tmux window is focused
    if type -q tmux
        and test -n "$TMUX"
        __done_is_tmux_window_active
        return $status
    end

    # If inside a screen session, check if the screen window is focused
    if type -q screen
        and test -n "$STY"
        __done_is_screen_window_active
        return $status
    end

    return 0
end

function __done_humanize_duration -a milliseconds
    set -l seconds (math --scale=0 "$milliseconds/1000" % 60)
    set -l minutes (math --scale=0 "$milliseconds/60000" % 60)
    set -l hours (math --scale=0 "$milliseconds/3600000")

    if test $hours -gt 0
        printf '%s' $hours'h '
    end
    if test $minutes -gt 0
        printf '%s' $minutes'm '
    end
    if test $seconds -gt 0
        printf '%s' $seconds's'
    end
end

# verify that the system has graphical capabilities before initializing
if test -z "$SSH_CLIENT" # not over ssh
    and count (__done_get_focused_window_id) >/dev/null # is able to get window id
    set __done_enabled
end

if set -q __done_allow_nongraphical
    and set -q __done_notification_command
    set __done_enabled
end

if set -q __done_enabled
    set -g __done_initial_window_id ''
    set -q __done_min_cmd_duration; or set -g __done_min_cmd_duration 500
    set -q __done_notify_sound; or set -g __done_notify_sound 0
    set -q __done_sway_ignore_visible; or set -g __done_sway_ignore_visible 0
    set -q __done_tmux_pane_format; or set -g __done_tmux_pane_format '[#{window_index}]'

    function __done_started --on-event fish_preexec
        set __done_initial_window_id (__done_get_focused_window_id)
    end

    function __done_ended --on-event fish_postexec
        set -l exit_status $status

        # backwards compatibility for fish < v3.0
        set -q cmd_duration; or set -l cmd_duration $CMD_DURATION

        if test $cmd_duration
            and test $cmd_duration -gt $__done_min_cmd_duration # longer than notify_duration
            and not __done_is_process_window_focused # process pane or window not focused

            eval $__done_sound_command &
            set -l humanized_duration (__done_humanize_duration "$cmd_duration")

            set -l title "Done in $humanized_duration"
            set -l duration 5000
            set -l message $argv[1]
            set -l sender $__done_initial_window_id

            if test $exit_status -ne 0
                set title "Failed after $humanized_duration"
                set duration 7000
            end

            set -l urgency normal

            if test $exit_status -ne 0
                set urgency critical
            end

            notify-send --urgency=$urgency --app-name=$message --expire-time=$duration "$title" "$message"
        end
    end
end

function __done_uninstall -e done_uninstall
    # Erase all __done_* functions
    functions -e __done_ended
    functions -e __done_started
    functions -e __done_get_focused_window_id
    functions -e __done_is_tmux_window_active
    functions -e __done_is_screen_window_active
    functions -e __done_is_process_window_focused
    functions -e __done_humanize_duration
    set -e __done_version
end

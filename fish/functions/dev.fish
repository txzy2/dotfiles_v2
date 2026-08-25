function dev
    set project (basename (pwd))

    if tmux has-session -t $project 2>/dev/null
        tmux attach-session -t $project
        return
    end

    tmux new-session -d -s $project -n main
    tmux send-keys -t $project:main 'nvim .' C-m

    tmux split-window -h -p 30 -t $project:main

    # первая панель динамически, независимо от base-index
    set first_pane (tmux list-panes -t $project:main -F '#{pane_id}' | head -n 1)
    tmux select-pane -t $first_pane

    tmux attach-session -t $project
end

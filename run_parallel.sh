#!/usr/bin/env bash

TMUX_SESSION="capstone"
CUR_PATH=$(pwd)
INPUT_VIDEO_PATH="video"
TASK_SPLIT_DIR="tasks"


declare -a gpu_id=(0 1 2 3)
declare -a video_paths

for video in "$INPUT_VIDEO_PATH"/*; do
    abs_path=$(realpath "$video")
    video_paths+=("$abs_path")
done

echo "splitting jobs for GPUs..."
gpu_id_len=${#gpu_id[@]}
video_paths_len=${#video_paths[@]}

mkdir -p "$TASK_SPLIT_DIR"
for i in "${!video_paths[@]}"; do
    worker=$(( $i % $gpu_id_len ))
    echo "${video_paths[$i]}" >> "${TASK_SPLIT_DIR}/${worker}"
done
echo "done"

echo "preparing tmux session..."
# create tmux session if not exists
if ! tmux has-session -t "$TMUX_SESSION" &>/dev/null; then
    tmux new-session -s "$TMUX_SESSION" -n root -d
fi
echo "done"

echo "preparing one tmux window for each gpu id, launching worker..."
# create all tmux windows named by gpu id, relaunch if exists
for gpu in "${gpu_id[@]}"; do
    window_name="gpu-$gpu"
    if tmux list-windows -t "$TMUX_SESSION" | grep -q "$window_name"; then
        tmux kill-window -t "$TMUX_SESSION:gpu-$gpu"
    fi
    command="./launch_global.sh '${TASK_SPLIT_DIR}/${gpu}' '$gpu'"
    tmux new-window -t "${TMUX_SESSION}:" -n "$window_name"
    tmux send-keys -t "${TMUX_SESSION}:${window_name}" "$command" Enter
    echo "$window_name created, worker launched"
done
echo "done"
echo "all workers launched"

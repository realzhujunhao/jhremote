#!/usr/bin/env bash

TASK_FILE=$1
GPU_ID=$2

readarray -t video_paths < $TASK_FILE

for video in ${video_paths[@]}; do
    python inference.py \
        --cfg-path eval_configs/MovieChat.yaml \
        --gpu-id "$GPU_ID" \
        --num-beams 1 \
        --temperature 1.0 \
        --text-query "$(cat prompt.txt)" \
        --video-path "$video" \
        --fragment-video-path "src/video_fragment/output.mp4" \
        --cur-min 1 \
        --cur-sec 1 \
        --middle-video 0
done

echo "all completed!"

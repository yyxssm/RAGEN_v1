#!/bin/bash

source /usr/local/Ascend/ascend-toolkit/set_env.sh
source /usr/local/Ascend/nnal/atb/8.3.RC1/atb/set_env.sh --cxx_abi=1

visible_devices="${ASCEND_RT_VISIBLE_DEVICES:-${CUDA_VISIBLE_DEVICES:-}}"

for arg in "$@"; do
    case "$arg" in
        system.CUDA_VISIBLE_DEVICES=*)
            visible_devices="${arg#system.CUDA_VISIBLE_DEVICES=}"
            ;;
    esac
done

visible_devices="${visible_devices#\'}"
visible_devices="${visible_devices%\'}"
visible_devices="${visible_devices#\"}"
visible_devices="${visible_devices%\"}"
visible_devices="${visible_devices#[}"
visible_devices="${visible_devices%]}"
visible_devices="${visible_devices// /}"

if [ -z "$visible_devices" ] || [ "$visible_devices" = "auto" ]; then
    visible_devices="0"
fi

export ASCEND_RT_VISIBLE_DEVICES="$visible_devices"
export CUDA_VISIBLE_DEVICES="$visible_devices"
export VLLM_ASCEND_ENABLE_NZ="${VLLM_ASCEND_ENABLE_NZ:-0}"

exec /home/ma-user/anaconda3/envs/ragen-ascend/bin/python "$@"

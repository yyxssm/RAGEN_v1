#!/bin/bash

cd /home/ma-user/yanyx/RAGEN

/home/ma-user/yanyx/RAGEN/python_npu.sh \
    /home/ma-user/yanyx/RAGEN/train.py \
    --config-name _2_sokoban \
    trainer.device=npu \
    "system.CUDA_VISIBLE_DEVICES='0,1,2,3'" \
    model_path=models/Qwen2.5-3B-Instruct \
    trainer.project_name=ragen \
    trainer.experiment_name=sokoban-qwen3b-npu \
    trainer.default_local_dir=checkpoints/ragen/sokoban-qwen3b-npu \
    'trainer.logger=["console","wandb"]' \
    trainer.total_training_steps=200 \
    trainer.save_freq=50 \
    trainer.test_freq=10 \
    trainer.val_before_train=true \
    es_manager.val.env_groups=512 \
    es_manager.val.group_size=1 \
    'es_manager.val.env_configs.n_groups=[512]'
# ml-pytorch-run-pod

This image depends on the public docker image
[ankurio/ml-pytorch](https://hub.docker.com/repository/docker/ankurio/ml-pytorch/general)
which is based on the code ytorch](https://github.com/ankur-gupta/ml-pytorch).

To use this image, you need to create a new template on [RunPod](https://www.runpod.io):
  1. Allow port 22 in TCP ports
  2. Add environment variable `ML_USER-neo`. This needs to match [ml-ytorch](https://github.com/ankur-gupta/ml-pytorch).

## Successful Container Logs
```
2023-08-08T01:41:58.029423024Z
2023-08-08T01:41:58.029429334Z CUDA Version 11.8.0
2023-08-08T01:41:58.030572119Z
2023-08-08T01:41:58.030574119Z Container image Copyright (c) 2016-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
2023-08-08T01:41:58.031705393Z
2023-08-08T01:41:58.031709003Z This container image and its contents are governed by the NVIDIA Deep Learning Container License.
2023-08-08T01:41:58.031711483Z By pulling and using the container, you accept the terms and conditions of this license:
2023-08-08T01:41:58.031713313Z https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license
2023-08-08T01:41:58.031715133Z
2023-08-08T01:41:58.031716193Z A copy of this license is made available in this container at /NGC-DL-CONTAINER-LICENSE for your convenience.
2023-08-08T01:41:58.043720022Z
2023-08-08T01:41:58.046616223Z Exporting environment variables ...
2023-08-08T01:41:58.046693124Z Found ML_USER. Adding environment variables for ML_USER=neo.
2023-08-08T01:41:58.051772235Z export RUNPOD_CPU_COUNT="6"
2023-08-08T01:41:58.051780505Z export RUNPOD_POD_ID="<runpod-id>"
2023-08-08T01:41:58.051782145Z export RUNPOD_MEM_GB="23"
2023-08-08T01:41:58.051783285Z export RUNPOD_PUBLIC_IP="149.36.0.167"
2023-08-08T01:41:58.051785045Z export RUNPOD_GPU_COUNT="1"
2023-08-08T01:41:58.051786205Z export RUNPOD_POD_HOSTNAME="<runpod-id>-64410ad7"
2023-08-08T01:41:58.051787675Z export RUNPOD_TCP_PORT_22="11556"
2023-08-08T01:41:58.051788715Z export RUNPOD_API_KEY="<some-alphanumeric-string>"
2023-08-08T01:41:58.051790135Z export PATH="/home/neo/toolbox/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/neo/.local/bin"
2023-08-08T01:41:58.051792045Z export _="/usr/bin/printenv"
2023-08-08T01:41:58.055571811Z set -x -g RUNPOD_CPU_COUNT "6"
2023-08-08T01:41:58.055594141Z set -x -g RUNPOD_POD_ID "<runpod-id>"
2023-08-08T01:41:58.055598391Z set -x -g RUNPOD_MEM_GB "23"
2023-08-08T01:41:58.055600871Z set -x -g RUNPOD_PUBLIC_IP "149.36.0.167"
2023-08-08T01:41:58.055603111Z set -x -g RUNPOD_GPU_COUNT "1"
2023-08-08T01:41:58.055605451Z set -x -g RUNPOD_POD_HOSTNAME "<runpod-id>-64410ad7"
2023-08-08T01:41:58.055608071Z set -x -g RUNPOD_TCP_PORT_22 "11556"
2023-08-08T01:41:58.055610211Z set -x -g RUNPOD_API_KEY "<some-alphanumeric-string>"
2023-08-08T01:41:58.055613011Z set -x -g PATH "/home/neo/toolbox/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/neo/.local/bin"
2023-08-08T01:41:58.055615871Z set -x -g _ "/usr/bin/printenv"
2023-08-08T01:41:58.055618161Z Adding public key ...
2023-08-08T01:41:58.055644581Z Found PUBLIC_KEY; adding to /home/neo/.ssh/authorized_keys.
2023-08-08T01:41:58.067894530Z  * Starting nginx nginx
2023-08-08T01:41:58.081163884Z    ...done.
2023-08-08T01:41:58.092827530Z  * Starting OpenBSD Secure Shell server sshd
2023-08-08T01:41:58.101526185Z    ...done.
```

## Add the following to your local machine `.ssh/config`
Edit to add real values.
```
Host runpod
  HostName 149.36.0.167
  Port 11556
  User neo
  IdentityFile ~/.ssh/id_runpod_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 119
  ServerAliveCountMax 10
  ForwardAgent yes

 Host runpod-root
  HostName ssh.runpod.io
  User <runpod-id>-64410ad7
  IdentityFile ~/.ssh/id_runpod_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 119
  ServerAliveCountMax 10
  ForwardAgent yes
```

## SSH into the machine
```shell
ssh runpod  # rsync and scp should also work nicely
# neo@a5522923ab0d ~> ls -l
# total 8
# -rw-r--r-- 1 neo neo 277 Aug  8 01:04 pytorch.requirements.txt
# drwxr-xr-x 1 neo neo  17 Aug  8 01:07 toolbox
# -rwxr-xr-x 1 neo neo 181 Aug  8 01:04 vf-install-env.fish
```

## Try out the ML
```shell
vf activate pytorch
ipython
```
```python
import torch
if torch.cuda.is_available():
    DEVICE = 'cuda'
elif torch.backends.mps.is_available():
    DEVICE = 'mps'
else:
    DEVICE = 'cpu'

DEVICE  # 'cuda'

torch.zeros(3)  # tensor([0., 0., 0.])
torch.zeros(3).device  # device(type='cpu')
torch.zeros(3, device=DEVICE)  # tensor([0., 0., 0.], device='cuda:0')
```

#!/bin/bash

DEVELOP=0
for i in "$@"
do
case $i in
    -d=*|--develop=*)
    DEVELOP="${i#*=}"
    shift # past argument=value
    ;;
esac
done

if [ $DEVELOP == 1 ]; then
    echo "Develop Mode"
    echo "Run openpilot-sim with manager and bridge (mounted as volume)"
    docker run  --shm-size 1G --rm --net=host -e PASSIVE=0 -e NOBOARD=1 -e CUDA_VISIBLE_DEVICES=  --volume="$HOME/openpilot:/tmp/openpilot-sim" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --gpus all -e DISPLAY=$DISPLAY -it commaai/openpilot-sim:latest /bin/bash -c "screen -d -m python tmp/openpilot-sim/selfdrive/manage.py && screen -d -m python tmp/openpilot-sim/tools/sim/bridge.py"
    
else 
    echo "Run openpilot-sim with manager and bridge"
    docker run  --shm-size 1G --rm --net=host -e PASSIVE=0 -e NOBOARD=1 -e CUDA_VISIBLE_DEVICES=  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --gpus all -e DISPLAY=$DISPLAY -it commaai/openpilot-sim:latest /bin/bash -c "screen -d -m python tmp/openpilot/selfdrive/manage.py && screen -d -m python tmp/openpilot/tools/sim/bridge.py"
fi
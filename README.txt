#Grapic Card Driver install
#Firefox install
#V3 install
#Polaris Office
#Anaconda:  C/ProgramData/Anaconda3
'''
conda install -c anaconda msgpack-python
pip install tensorflow #pip install tensorflow-gup
pip install msgpack --user
pip install --upgrade tensorflow tensorboard
conda update -n base conda
conda update --all

conda create -n tensorflow pip python=3.5 #가상환경 만들기

#conda info --envs #가상환경 확인하기

pip install --upgrade https://storage.googleapis.com/tensorflow/windows/cpu/tensorflow-1.0.0-cp35-cp35m-win_amd64.whl #오류오류ImportError: No module named '_pywrap_tensorflow_internal'
                                                                                                                                                           #ImportError: DLL load failed: 지정된 모듈을 찾을 수 없습니다.
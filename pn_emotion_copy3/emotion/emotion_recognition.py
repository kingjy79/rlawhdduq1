from __future__ import division, absolute_import
import re
import numpy as np
import tensorflow as tf 
from dataset_loader import DatasetLoader
import tflearn
from tflearn.layers.core import input_data, dropout, fully_connected, flatten
from tflearn.layers.conv import conv_2d, max_pool_2d, avg_pool_2d
from tflearn.layers.merge_ops import merge
from tflearn.layers.normalization import local_response_normalization
from tflearn.layers.estimator import regression
from constants import *
from os.path import isfile, join
import random
import sys


class EmotionRecognition:

    def __init__(self):
        self.dataset = DatasetLoader()

    def build_network(self):
        # Smaller 'AlexNet'
        # https://github.com/tflearn/tflearn/blob/master/examples/images/alexnet.py
        print('[+] Building CNN')
        self.network = input_data(shape=[None, SIZE_FACE, SIZE_FACE, 1])
        #print(input_data)
        self.network = conv_2d(self.network, 64, 5, activation='relu', padding='valid')
        #print(self.network)
        #self.network = local_response_normalization(self.network)
        self.network = max_pool_2d(self.network, 3, strides=2)
        self.network = conv_2d(self.network, 64, 5, activation='relu', padding='valid')
        #print(self.network)
        #self.network = max_pool_2d(self.network, 3, strides=2)
        self.network = conv_2d(self.network, 128, 3, activation='relu', padding='valid')
        #print(self.network)
        self.network = dropout(self.network, 0.3)
        self.network = fully_connected(self.network, 3072, activation='relu')
        self.network = fully_connected(
            self.network, len(EMOTIONS), activation='softmax')
        self.network = regression(
            self.network,
            optimizer='momentum',
            loss='categorical_crossentropy'
        )
        self.model = tflearn.DNN(
            self.network,
            checkpoint_path=SAVE_DIRECTORY + '/emotion_recognition',
            max_checkpoints=1,
            tensorboard_verbose=2
        )
        self.load_model()
        convolution_layer1 = tflearn.variables.get_layer_variables_by_name('Conv2D')[0]
        print(convolution_layer1)
        convolution_layer1_weight = self.model.get_weights(convolution_layer1)
        print(convolution_layer1_weight)
        #convloution_layer1를 numpy로 변환
        #convolution_layer1 = np.asarray(convolution_layer1)
        #convolution_layer2 = tf.convert_to_tensor(convolution_layer1)
        #여기서부터
        #여기까지는 배열을 만들기위한 장치입니다.
        self.model.set_weights(convolution_layer1, convolution_layer1*10) # 이 위치의 두번째 인자에 원하고자하는 weight(tensor형식) 값을 넣으면 된다.
        #self.model.set_weights(convolution_layer1, convolution_layer1 + tf.ones([5, 5, 1, 64]))
        convolution_layer1_weight = self.model.get_weights(convolution_layer1)
        print(convolution_layer1_weight)

    def load_saved_dataset(self):
        self.dataset.load_from_save()
        print('[+] Dataset found and loaded')

    def start_training(self):
        self.load_saved_dataset()
        self.build_network()
        if self.dataset is None:
            self.load_saved_dataset()
        # Training
        print('[+] Training network')
        self.model.fit(
            self.dataset.images, self.dataset.labels,
            validation_set=(self.dataset.images_test,
                            self.dataset.labels_test),
            n_epoch=100,
            batch_size=50,
            shuffle=True,
            show_metric=True,
            snapshot_step=200,
            snapshot_epoch=True,
            run_id='emotion_recognition'
        )

    def predict(self, image):
        if image is None:
            return None
        image = image.reshape([-1, SIZE_FACE, SIZE_FACE, 1])
        return self.model.predict(image)

    def save_model(self):
        self.model.save(join(SAVE_DIRECTORY, SAVE_MODEL_FILENAME))
        print('[+] Model trained and saved at ' + SAVE_MODEL_FILENAME)

    def load_model(self):
        if isfile(join(SAVE_DIRECTORY, SAVE_MODEL_FILENAME)):
            self.model.load(join(SAVE_DIRECTORY, SAVE_MODEL_FILENAME))
            print('[+] Model loaded from ' + SAVE_MODEL_FILENAME)


def show_usage():
    # I din't want to have more dependecies
    print('[!] Usage: python emotion_recognition.py')
    print('\t emotion_recognition.py train \t Trains and saves model with saved dataset')
    print('\t emotion_recognition.py poc \t Launch the proof of concept')


if __name__ == "__main__":
    if len(sys.argv) <= 1:
        show_usage()
        exit()
    network = EmotionRecognition()
    if sys.argv[1] == 'train':
        network.start_training()
        network.save_model()
    elif sys.argv[1] == 'poc':
        import poc
    elif sys.argv[1] == 'yeob':
        network.load_model()
    else:
        show_usage()

from __future__ import division, absolute_import
import re
import numpy as np
from dataset_loader import DatasetLoader
import tflearn
from tflearn.layers.core import input_data, dropout, fully_connected, flatten
from tflearn.layers.conv import conv_2d, max_pool_2d, avg_pool_2d
from tflearn.layers.merge_ops import merge
from tflearn.layers.normalization import local_response_normalization, batch_normalization
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
        print('input data')
        print(input_data)
        #convolution layer 1 
        self.network = conv_2d(self.network, 64, 5,  activation='relu', weights_init='xavier')
        print('conv1')
        print(self.network)
        #self.network = local_response_normalization(self.network)
        self.network = batch_normalization(self.network)
        self.network = max_pool_2d(self.network, 3, strides=2)
        print('maxp1')
        print(self.network)
        #convolution layer 2
        self.network = conv_2d(self.network, 64, 5, activation='relu', weights_init='xavier')
        print('conv2')
        print(self.network)
        self.network = max_pool_2d(self.network, 3, strides=2)
        print('maxp2')
        #convolution layer 3        
        print(self.network)
        self.network = conv_2d(self.network, 32, 1, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 128, 5, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 128, 5, activation='relu', weights_init='xavier')
        print('conv2')
        print(self.network)
        self.network = max_pool_2d(self.network, 3, strides=2)
        print('maxp2')
        print(self.network)
        #convolution layer 4 
        print(self.network)
        self.network = conv_2d(self.network, 32, 1, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 128, 5, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 128, 5, activation='relu', weights_init='xavier')
        print('conv4')
        print(self.network)
        #self.network = max_pool_2d(self.network, 3, strides=2)
        #print('maxp4')
        #print(self.network)
        #convolution layer 5
        print(self.network)
        self.network = conv_2d(self.network, 32, 1, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 256, 3, activation='relu', weights_init='xavier')
        self.network = conv_2d(self.network, 256, 3, activation='relu', weights_init='xavier')
        print('conv5')
        print(self.network)
        self.network = dropout(self.network, 0.3)
        #fully connected layer 1
        self.network = fully_connected(self.network, 4096, activation='relu',weights_init='xavier' )
        print('fc1')
        print(self.network)
        #fully connected layer 2
        self.network = fully_connected(self.network, 1024, activation='relu',weights_init='xavier')
        print('fc2')
        print(self.network)
        self.network = fully_connected(
            self.network, len(EMOTIONS), activation='softmax')
        print('fc2')
        print(self.network)
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

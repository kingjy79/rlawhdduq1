# Proof-of-concept
import cv2
import sys
from constants import *
from emotion_recognition import EmotionRecognition
import numpy as np

cascade_classifier = cv2.CascadeClassifier(CASC_PATH)

network = EmotionRecognition()
network.load_model()

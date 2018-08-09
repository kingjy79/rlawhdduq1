# Proof-of-concept


import tensorflow as tf 
import tflearn
from tensorflow.python.tools import inspect_checkpoint as chkp

saver = tf.train.import_meta_graph("c:\\Users\\kingjy79\\Documents\\emotion_recognition-8325.meta")
grape = tf.get_default_graph()
#input_graph_def = graph.as_graph_def()

with tf.Session() as sess:
    print(grape)
    #saver.restore(sess, "c:\\Users\\kingjy79\\Documents\\emotion_recognition-8325")
    ##Conv2D = input_graph_def.get_tensor_by_name("Conv2D:0")
    #print("## Conv2D matrix: ")
    #weights = Conv2D.eval()
    #print(weights.tolist())


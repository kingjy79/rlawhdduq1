import tensorflow as tf 
import numpy as np 
import matplotlib.pyplot as plt

#mu, sigma= 0, 0.2
#s= np.random.normal(mu,sigma, 102400)

data_b1 = np.zeros(102400)
data_b2 = np.zeros(102400)

y1= np.zeros(102400)
y2= np.zeros(102400)
data1 = open('C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\pn_emotion_copy3\\emotion\\data\\convolution_layer2_weight.txt','r')
data2 = open('C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\pn_emotion_copy3\\emotion\\data\\convolution_layer2_weight_modify.txt','r')

for i in np.arange(0,102399):
    data_b1[i] = data1.readline()
    y1[i]=data_b1[i]

data1.close()

for i in np.arange(0,102399):
    data_b2[i] = data2.readline()
    y2[i]=data_b2[i]

data1.close()
data2.close()
#print(data_f)
x = range(0, 102400)
#count, bins, ignored = plt.hist(data_f,100, normed=True)

#plt.plot(bins, 1/(sigma*np.sqrt(2*np.pi))*np.exp(-(bins-mu)**2/(2*sigma**2)),linewidth=2, color='r')
plt.plot(x,y2, "r.")
plt.plot(x,y1, "b.")
#plt.plot(x,y2, "r.")
plt.show()


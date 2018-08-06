import tensorflow as tf 
import numpy as np 
import matplotlib.pyplot as plt

#mu, sigma= 0, 0.2
#s= np.random.normal(mu,sigma, 102400)

data_f = np.zeros(102400)
y= np.zeros(102400)
data = open("C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VScode\\fprint_test\\w_trained1.dat",'r')

for i in np.arange(0,102399):
    data_f[i] = data.readline()
    y[i]=data_f[i]

data.close()
#print(data_f)
x = range(0, 102400)
#count, bins, ignored = plt.hist(data_f,100, normed=True)

#plt.plot(bins, 1/(sigma*np.sqrt(2*np.pi))*np.exp(-(bins-mu)**2/(2*sigma**2)),linewidth=2, color='r')
plt.plot(x,y, "b.")
plt.show()
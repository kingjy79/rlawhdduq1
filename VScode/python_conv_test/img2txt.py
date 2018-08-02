import numpy as np
import cv2 as cv

image = cv.imread('c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\jenny.jpg', 0)

f = open('jenny.dat','w')
for i in range(48):
    for j in range(48):
        f.write(str(image[i][j])+'\n') #10진수 표현(hex->str)
f.close()
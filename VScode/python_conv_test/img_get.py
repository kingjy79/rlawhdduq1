import numpy as np
import cv2 as cv


image = cv.imread('c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\jenny.jpg', 0)

kernel_get =[]
f = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\w_in_1s.dat", 'r')
line = f.read().split()
#kernel_get.append(line)

f.close()
#값이 제대로 들어갔는지 확인//확인 완료
#for i in range(150):
print(line)

import numpy as np
import cv2 as cv

kernel_get =[]
f = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\w_in_1s.dat", 'r')
for i in range(150):
    line = f.readline()
    kernel_get.append(line)

f.close()
#값이 제대로 들어갔는지 확인//확인 완료
for i in range(150):
    print(kernel_get[i])


input_get =[]
f = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\x_in_1s.dat", 'r')
for i in range(1024):
    line = f.readline()
    input_get.append(line)

f.close()
#값이 제대로 들어갔는지 확인//확인 완료
for i in range(1024):
    print(input_get[i])

'''
kernel = np.array([[1, 0, -1],
                   [1, 0, -1],
                   [1, 0, -1]])

filtered = cv2.filter2D(src=image, kernel=kernel, ddepth=-1)
cv2.imshow('horizontal edges', filtered)
'''

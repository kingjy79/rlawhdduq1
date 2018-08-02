import numpy as np
import cv2 as cv

image = cv.imread('c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\jenny.jpg', 0)

#kernel=[]
#kernel[0] = np.array([[13, -3, 6, -15, 13], [0, 11, 2, -4, 0],[-10, -3, -13, -9, 9],[-10, -3, -13, -9, 9],[-10, -3, -13, -9, 9]])
print(image)


'''

f = open('jenny2.dat','w')
for k in range(1):
    filtered = cv.filter2D(src=image, kernel=kernel[k], ddepth=-1)
    for i in range(48):
        for j in range(48):
            f.write(hex(filtered[i][j])+'\n') #10진수 표현(hex->str)
f.close()
'''
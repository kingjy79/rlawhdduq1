import numpy as np 
import cv2 as cv 

kernel_get =[]
FILE = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV.txt", 'r')
for i in range(1650):
    line = (FILE.readline())
    kernel_get.append(line)

FILE.close()

FILE = open("C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV_line.dat", 'w')
for i in range(1650):
    FILE.write(kernel_get[i])
FILE.close()
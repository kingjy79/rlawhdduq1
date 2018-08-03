import numpy as np
import cv2 as cv


image = cv.imread('c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\jenny.jpg', 0)

kernel_get =[]
f = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_random1.dat", 'r')
for i in range(150):
    line = float(f.readline())
    kernel_get.append(line)

f.close()

'''
#값이 제대로 들어갔는지 확인//확인 완료
for i in range(150):
    print(kernel_get[i])
'''


'''
input_get =[]
f = open("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\x_in_1s.dat", 'r')
for i in range(1024):
    line = f.readline()
    input_get.append(line)

f.close()
'''
'''#값이 제대로 들어갔는지 확인//확인 완료
for i in range(1024):
    print(input_get[i])
'''
'''

kernel = np.array([[1, 0, -1],
                   [1, 0, -1],
                   [1, 0, -1]])

filtered = cv2.filter2D(src=image, kernel=kernel, ddepth=-1)
cv2.imshow('horizontal edges', filtered)
'''



kernel_matrix=[]
for k in range(6): # k= depth
    kernel_line = []    # 빈 리스트 생성
    for i in range(5): #height
        line = []              # 안쪽 리스트로 사용할 빈 리스트 생성
        for j in range(5): #width
            line.append(kernel_get[k*25+5*i+j])    
        kernel_line.append(line)         # 전체 리스트에 안쪽 리스트를 추가
    kernel_matrix.append(kernel_line)

kernel_matrix_np=np.array(kernel_matrix)
for k in range(6):
    print(kernel_matrix_np[k])

#image2=cv.copyMakeBorder(image, top=2, bottom=2, left=2, right=2, borderType= cv.BORDER_CONSTANT )

f = open('jenny_p_f.dat','w')
for k in range(6):
    filtered = cv.filter2D(src=image, kernel=kernel_matrix_np[k], ddepth=-1,borderType= cv.BORDER_CONSTANT )
    for i in range(48):
        for j in range(48):
            f.write(str(filtered[i][j])+'\n') #10진수 표현(hex->str)
f.close()

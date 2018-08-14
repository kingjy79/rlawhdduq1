#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    #define ROUND_OFF 1e5
    FILE *fp_kernel = fopen("C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\pn_emotion_copy3\\emotion\\data\\convolution_layer2_weight.txt","r");
    //파일 오픈
    //double weight_get[102400] = {0,}; //정수형 배열 선언 텍스트 파일 안에 성분이 정수형일 때 사용
    float weight_get[102400] = {0,};
    char weight_buffer[20];
    //char *input_buffer; //버퍼동적배열
    //input_buffer=(char*) malloc(sizeof(char)*buffer_size);
    if(fp_kernel==NULL){
        printf("Error opening file_kerenl");
    }
    else{
        for(int i=0; i<102400; i++){
            fgets(weight_buffer, 20, fp_kernel);
            weight_get[i]=atof(weight_buffer)*ROUND_OFF +0.5*ROUND_OFF //resolution 10^7(significant)
        }
    }
    fclose(fp_kernel);
    printf("\npass get");


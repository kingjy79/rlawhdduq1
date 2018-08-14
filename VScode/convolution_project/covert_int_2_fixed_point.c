#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    #define RESOLUTION 2e16-1
    FILE *fp_kernel = fopen("C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\pn_emotion_copy3\\emotion\\data\\convolution_layer2_weight.txt","r");
    //파일 오픈
    //double kernel_get[102400] = {0,}; //정수형 배열 선언 텍스트 파일 안에 성분이 정수형일 때 사용
    float kernel_get[102400] = {0,};
    char kernel_buffer[15];
    //char *input_buffer; //버퍼동적배열
    //input_buffer=(char*) malloc(sizeof(char)*buffer_size);
    if(fp_kernel==NULL){
        printf("Error opening file_kerenl");
    }
    else{
        for(int i=0; i<102400; i++){
            fgets(kernel_buffer, 15, fp_kernel);
            kernel_get[i]=atof(kernel_buffer);//RESOLUTION; //resolution 10^7(significant)
        }
    }
    fclose(fp_kernel);
    printf("pass");

//여기서부터는 최댓값과 최솟값 찾는 것
    float max_kernel =0;
    float min_kernel =0;
    for(int i=0; i<102400; i++){
        if(max_kernel<kernel_get[i]){
            max_kernel=kernel_get[i];
        }
        if(min_kernel>kernel_get[i]){
            min_kernel=kernel_get[i];
        }        
        printf("\ni: %d",i);
        printf("\nmax_kernel : %f", max_kernel);
        printf("\nmin_kerenl : %f", min_kernel);
    }
    
//같은 값을 찾아내는 기능
    int count=0;
    for(int i=0; i<102399; i++){
        for(int j=i+1; j<102400; j++){
            if(kernel_get[i]==kernel_get[j]){
                count++;
                printf("\ni: %d j: %d",i+1,j+1); //배열은 0부터 시작하므로
            }
        }
    }
    printf("\ncount: %d\n", count);

/*

    FILE *fp_output = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_c2_trained2.dat","w");
    for(int i=0; i<102400; i++){
        fprintf(fp_output, "%f\n",kernel_get[i]);
    }
    fclose(fp_output);
*/
    return 0;
}

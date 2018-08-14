#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    #define RESOLUTION 65535
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
            weight_get[i]=atof(weight_buffer);//RESOLUTION; //resolution 10^7(significant)
        }
    }
    fclose(fp_kernel);
    printf("\npass get");

//여기서부터는 최댓값과 최솟값 찾는 것
/*
    float weight_max = 0;
    float weight_min = 0;
    for(int i=0; i<102400; i++){
        if(weight_max < weight_get[i]){
            weight_max = weight_get[i];
        }
        if(weight_min > weight_get[i]){
            weight_min = weight_get[i];
        }        
        //printf("\ni: %d",i);
        //printf("\nweight_max : %f", weight_max);
        //printf("\nmin_kerenl : %f", weight_min);
    }
*/


    float weight_max = 0.12;
    float weight_min = -0.12;
    for(int i=0; i<102400; i++){
        if(weight_max < weight_get[i]){
            weight_get[i] = weight_max;//saturation
        }
        if(weight_min > weight_get[i]){
            weight_get[i] = weight_min;
        }
    }        
    printf("\nweight_max : %f", weight_max);
    printf("\nweight_min : %f", weight_min);
    printf("\npass compare");
    float resolution_width =0;
    resolution_width = (weight_max - weight_min)/RESOLUTION;
    for(int i=0; i<102400; i++){
        for(int j=0; j<RESOLUTION-1; j++){
            if(weight_get[i] >= weight_min + resolution_width*(j) && \
            weight_get[i] < weight_min+ resolution_width*(j+1)){
                weight_get[i] = (2*weight_min + resolution_width*(2*j+1))/2;
            }
            //printf("\ni2 : %d", i);
            //printf("\nj2 : %d", j);
        
        }
    }
    printf("\npass resolution operation");
/*
    int state = 0;
    int count = 0;
    int current = 0;
    int sum = 0;
    while(1){
        const int IDLE = 0, COMPARE_CURRENT_WITH_NEXT = 1, COMPARE_CURRENT_WITH_BEFORE = 2, DEFINE_VALID = 3;
        switch(state){
            case IDLE:
                state = COMPARE_CURRENT_WITH_NEXT;
                break;
            
            case COMPARE_CURRENT_WITH_NEXT:
                count = 0;
                for(int i = current+1; i < 102400; i ++){
                    if(weight_get[current] == weight_get[i]){
                        count ++;
                    }
                }
                state = COMPARE_CURRENT_WITH_BEFORE;
                break;

            case COMPARE_CURRENT_WITH_BEFORE:
                for(int i = 0; i < current; i ++){
                    if(weight_get[i] == weight_get[current]){
                        state = COMPARE_CURRENT_WITH_NEXT;
                    }
                    else{
                        sum = sum + count;
                        state = DEFINE_VALID;
                    }
                    break;
                }

            case DEFINE_VALID:

        }
    }
*/    
    
    FILE *fp_output = fopen("C:\\Users\\kingjy79\\Documents\\rlawhdduq1\\pn_emotion_copy3\\emotion\\data\\convolution_layer2_weight_modify.txt","w");
    for(int i=0; i<102400; i++){
        fprintf(fp_output, "%f\n",weight_get[i]);
    }
    fclose(fp_output);
    return 0;
}

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    #define PADDING 2
    #define INPUT_HEIGHT 48
    #define INPUT_WIDTH 48
    #define KERNEL_WIDTH 5
    #define KERNEL_HEIGHT 5
    #define KERNEL_NUMBER 6
    #define STRIDE 1
    //FILE *fpp;//파일포인터 -> fprintf에 사용되는 output용
    //FILE *fps;//파일포인터 -> fscanf에 사용되는 input용
    float temp=0;
 
    
    //나중에 #define Size 100과 같이 parameter로 선언??
    
/*   
    FILE *fp_kernel =fopen("w_in_1s.dat","r");
    fseek(fp_kernel,0,SEEK_END); //파일 END값 주소.

    int *kernel_get;
    int kernel_size=KERNEL_HEIGHT*KERNEL_WIDTH; //
    kernel_get=(int*)malloc(sizeof(int)*kernel_size);
    for(int i=0; i<kernel_size; i++){//initialization
        kernel_get[i]=0;
    }
    
    fpp = fopen("exex.txt", "wt"); //파일 오픈
    if(fpp ==NULL) {//예외처리.
        printf("실패 - 종료\n");
        return 1;
        }
    fprintf(fpp, "%d", 8800); //기본으로 exex.txt에 저장.
    fclose(fpp); //파일종료.

    fps = fopen("exex.txt","rt");//파일오픈.
    if(fps==NULL) {//예외처리.
        printf("실패 - 종료\n");
        return 1;
        }
    
    fscanf(fps, "%d", &tempNum);//fp의 정수를 tempNum으로 받아옴.
    fclose(fps);
    printf("받아온 값은 %d입니다. \n", tempNum);

    printf("완료\n");
*/

    FILE *fp_kernel = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_random1.dat","r");
    //파일 오픈
    float kernel_get[150]={0,};
    char kernel_buffer[10];//한줄당 크기
    for(int i=0; i<150; i++){//150줄 이니깐 150번 반복
        if(fp_kernel==NULL){
            printf("Error opening file_kernel_get");
        }
        else{
            fgets(kernel_buffer, 10, fp_kernel);
            kernel_get[i]=(float)atof(kernel_buffer);
        }
    }
    fclose(fp_kernel);
    //printf("\nkernel_get[0]= %d\n", kernel_get[0]);
    //printf("kernel_get[1]= %d\n", kernel_get[1]);
    
   
/*
    //kernel_get이 잘실행되나 test
    FILE *fp_kernel_print = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\C\\covolution_project\\w_out_1s.dat","w");
    for(int i=0; i<150; i++){
        fprintf(fp_kernel_print, "%d \n", (int)(kernel_get[i]));
    }
    fclose(fp_kernel_print);
*/



    FILE *fp_input = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\jenny.dat","r");
    float input_get[2304]; //input_size:48*48
    char input_buffer[10];//한줄당 크기
    for(int i=0; i<2304; i++){//2304줄 이니깐 2304번 반복
        if(fp_kernel==NULL){
            printf("Error opening file_kernel_get");
        }
        else{
            fgets(input_buffer, 10, fp_kernel);
            input_get[i]=(float)atof(input_buffer);
        }
    }
    fclose(fp_input);
/*
    //kernel_get이 잘실행되나 test
    FILE *fp_input_print = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\C\\covolution_test\\x_out_1s.dat","w");
    for(int i=0; i<1024; i++){
        fprintf(fp_kernel_print, "%d \n", (int)(input_get[i]));
    }
    fclose(fp_kernel_print);
*/
    
    

    int output_width = (INPUT_WIDTH + (2*PADDING) -KERNEL_WIDTH)/STRIDE +1;
    int output_height = (INPUT_HEIGHT + (2*PADDING) - KERNEL_HEIGHT)/STRIDE +1;
    int output_number = KERNEL_NUMBER;





    //input 2차원 배열 동적배열로 선언
    float **input_matrix;
    input_matrix= (float**) malloc (sizeof(float*)*INPUT_HEIGHT);
    for(int i=0; i<INPUT_HEIGHT;i++){
        input_matrix[i]=(float*) malloc(sizeof(float)*INPUT_WIDTH);
    }
    //배열 초기화
    for(int i=0; i<INPUT_HEIGHT; i++){
        for(int j=0; j<INPUT_WIDTH; j++){
            input_matrix[i][j]=0;
        }
    }
    for(int i=0; i<INPUT_HEIGHT; i++){  //get input
            for(int j=0; j<INPUT_WIDTH; j++){
                input_matrix[i][j]=input_get[(INPUT_WIDTH*i)+j];
            }
        }
 /*   
    for(int i=0; i<INPUT_HEIGHT; i++){ //input_matrix 출력
        for(int j=0; j<INPUT_WIDTH; j++){
            printf("\nintput_matrix[%d][%d]:%d",i,j,input_matrix[i][j]);
        }
    }
*/


    //output 3차원 동적 배열 할당
    float ***output_tensor;
    output_tensor= (float***) malloc (sizeof(float**)*output_height);
    for(int i=0; i<output_height;i++){
        output_tensor[i]=(float**) malloc(sizeof(float*)*output_width);
        for(int j=0; j<output_width;j++){
            output_tensor[i][j]=(float*) malloc(sizeof(float)*output_number);
        }
    }
    //배열 초기화
    for(int k=0; k<output_number; k++){
        for(int i=0; i<output_height; i++){
            for(int j=0; j<output_width; j++){
                output_tensor[i][j][k]=0;
            }
            
        }
    }



    //kernel 3차원 동적 배열 할당
    float ***kernel_tensor;
    kernel_tensor= (float***) malloc (sizeof(float**)*KERNEL_HEIGHT);
    for(int i=0; i<KERNEL_HEIGHT;i++){
        kernel_tensor[i]=(float**) malloc(sizeof(float*)*KERNEL_WIDTH);
        for(int j=0; j<KERNEL_WIDTH;j++){
            kernel_tensor[i][j]=(float*) malloc(sizeof(float)*KERNEL_NUMBER);
        }
    }
    //배열 초기화
    for(int k=0; k<KERNEL_NUMBER; k++){
        for(int i=0; i<KERNEL_HEIGHT; i++){
            for(int j=0; j<KERNEL_WIDTH; j++){
                kernel_tensor[i][j][k]=0;
            }
            
        }
    }


    for(int k=0; k<KERNEL_NUMBER; k++){ //get weight
        for(int i=0; i<KERNEL_HEIGHT; i++){ 
            for(int j=0; j<KERNEL_WIDTH; j++){
                kernel_tensor[i][j][k]=kernel_get[(KERNEL_WIDTH*i)+j+(k*25)];
            }
        }
    }

/*
    for(int k=0; k<KERNEL_NUMBER; k++){ //kernel이 잘들어가는지 확인
        for(int i=0; i<KERNEL_HEIGHT;i++){
            for(int j=0; j<KERNEL_WIDTH; j++)
            {
                printf("\nkernel_tensor[%d][%d][%d]:%d",i,j,k,kernel_tensor[i][j][k]);
            }
        }
    }
*/
    //padding의 값에 따라서 input size 재조정을 해줘야한다.
    //padding이 들어간 input 2차원 배열 동적배열로 선언
    float **input_padding_matrix;
    input_padding_matrix= (float**) malloc (sizeof(float*)*(INPUT_HEIGHT+(2*PADDING)));
    for(int i=0; i<INPUT_HEIGHT+2*PADDING;i++){
        input_padding_matrix[i]=(float*) malloc(sizeof(float)*(INPUT_WIDTH+(2*PADDING)));
    }

    
    //배열 초기화
    for(int i=0; i<(INPUT_HEIGHT+(2*PADDING)); i++){
        for(int j=0; j<(INPUT_WIDTH+(2*PADDING)); j++){
            input_padding_matrix[i][j]=0;
        }
    }


    for(int i=0; i<INPUT_HEIGHT; i++){ //padding 처리되기전 값은 그 안에 값으로 할당을 받는다.
        for(int j=0; j<INPUT_WIDTH; j++){
            input_padding_matrix[i+PADDING][j+PADDING]=input_matrix[i][j];
        }
    }


    for(int i=0; i<(INPUT_HEIGHT+2*PADDING);i++){ //padding을 통해 생성된 배열은 0값을 넣어준다.
        for(int j=0; j<(INPUT_WIDTH+2*PADDING);j++){
            if(i<PADDING){
                input_padding_matrix[i][j]=0;
            }
            else if((INPUT_HEIGHT+PADDING)<=i){
                input_padding_matrix[i][j]=0;
            }
            else if( (PADDING<=i && i<(INPUT_HEIGHT+PADDING) && j<PADDING ) 
                    || (PADDING<=i && i<(INPUT_HEIGHT+PADDING) && (INPUT_WIDTH+PADDING)<=j ) ){
                        input_padding_matrix[i][j]=0;
                    }
        }
    }
/*확인완료
    printf("INPUT_HEIGHT+2*padding:%d",INPUT_HEIGHT+2*PADDING);
    for(int i=0; i<(INPUT_HEIGHT+2*PADDING);i++){
        for(int j=0; j<(INPUT_WIDTH+2*PADDING);j++){
            printf("\nintput_padding_matrix[%d][%d]:%d",i,j,input_padding_matrix[i][j]);
        }
    }
*/

    for(int k=0; k<KERNEL_NUMBER; k++){//output_tensor에 convolution값이 들어간다.
        for(int h=0; h<output_height; h++){ 
            for(int w=0; w<output_width; w++){ 
                for(int i=0; i<KERNEL_HEIGHT; i++){ 
                    for(int j=0; j<KERNEL_WIDTH; j++){
                        temp=temp+(input_padding_matrix[h+i][w+j]*kernel_tensor[i][j][k]); 
                    }
                }
                if(temp<0){
                    output_tensor[h][w][k]=0;
                }
                else if(temp>=255){
                    output_tensor[h][w][k]=255;
                }
                else{
                    output_tensor[h][w][k]=temp;
                }
                temp=0;//initialization 
            }            
        } 
    }
    

    FILE *fp_output = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\convolution_project\\jenny_c_f.dat","w");
    for(int k=0; k<output_number; k++){
        for(int i=0; i<output_height; i++){
            for(int j=0; j<output_width; j++){
                fprintf(fp_output, "0x%X\n", (int)((output_tensor[i][j][k]*1.0e1+0.5e1)/(1.0e1)));
            }      
        }
    }
    fclose(fp_output);


    return 0;
}
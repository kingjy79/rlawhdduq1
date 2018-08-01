#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    FILE *fpp;//파일포인터 -> fprintf에 사용되는 output용
    FILE *fps;//파일포인터 -> fscanf에 사용되는 input용
    int temp=0;
    //int output_width=0;
    //int output_height=0;
    int input_width=48;
    int input_height=48;    
    int kernel_width=5;
    int kernel_height=5;
    int kernel_number=64;
    int padding=0;
    int stride=1;
    
    //나중에 #define Size 100과 같이 parameter로 선언??
    
/*   
    FILE *fp_kernel =fopen("w_in_1s.dat","r");
    fseek(fp_kernel,0,SEEK_END); //파일 END값 주소.

    int *kernel_get;
    int kernel_size=kernel_height*kernel_width; //
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

    FILE *fp_kernel = fopen("w_in_1s.dat","r");
    int kernel_get[150];
    if(fp_kernel==NULL){
        printf("Error opening file");
    }
    else{
        fgets(kernel_get, 150, fp_kernel);
        fclose(fp_kernel);
    }

    FILE *fp_input = fopen("x_in_1s.dat","r");
    int input_get[2304]; //input_size:48*48
    if(fp_input==NULL){
        printf("Error opening file");
    }
    else{
        fgets(input_get, 2304, fp_input);
        fclose(fp_input);
    }

    
    





    int output_width = (input_width + 2*padding -kernel_width)/stride +1;
    int output_height = (input_height + 2*padding - kernel_height)/stride +1;
    int output_number = kernel_number;





    //input 2차원 배열 동적배열로 선언
    int **input_matrix;
    input_matrix= (int**) malloc (sizeof(int*)*input_height);
    for(int i=0; i<input_height;i++){
        input_matrix[i]=(int*) mallock(sizeof(int)*input_width);
    }
    //배열 초기화
    for(int i=0; i<input_height; i++){
        for(int j=0; j<input_width; j++){
            input_matrix[i][j]=0;
        }
    }
    for(int i=0; i<input_height; i++){  //get input
            for(int j=0; j<input_width; j++){
                input_matrix[i][j]=input_get[(input_width*i)+j];
            }
        }


/*

    //int output_matrix[output_width][output_height] = {0,};
    //동적 할당을 필요로 하므로 위와 같이 선언은 불가능
    int **output_matrix;
    output_matrix= (int**) malloc (sizeof(int*)*output_height);
    for(int i=0; i<output_height;i++){
        output_matrix[i]=(int*) mallock(sizeof(int)*output_width);
    }
    //배열 초기화
    for(int i=0; i<output_height; i++){
        for(int j=0; j<output_width; j++){
            output_matrix[i][j]=0;
        }
    }
*/



    //output 3차원 동적 배열 할당
    int ***output_tensor;
    output_tensor= (int***) malloc (sizeof(int**)*output_height);
    for(int i=0; i<output_height;i++){
        output_tensor[i]=(int**) mallock(sizeof(int*)*output_width);
        for(int j=0; j<output_width;j++){
            output_tensor[i][j]=(int*) malloc(sizeof(int)*output_number);
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
    int ***kernel_tensor;
    kernel_tensor= (int***) malloc (sizeof(int**)*kernel_height);
    for(int i=0; i<kernel_height;i++){
        kernel_tensor[i]=(int**) mallock(sizeof(int*)*kernel_width);
        for(int j=0; j<kernel_width;j++){
            kernel_tensor[i][j]=(int*) malloc(sizeof(int)*kernel_number);
        }
    }
    //배열 초기화
    for(int k=0; k<kernel_number; k++){
        for(int i=0; i<kernel_height; i++){
            for(int j=0; j<kernel_width; j++){
                kernel_tensor[i][j][k]=0;
            }
            
        }
    }



    for(int k=0; k<kernel_number; k++){ //get weight
        for(int i=0; i<kernel_height; i++){ 
            for(int j=0; j<kernel_width; j++){
                kernel_tensor[i][j][k]=kernel_get[(kernel_width*i)+j+(k*25)];
            }
        }
    }

    //padding의 값에 따라서 input size 재조정을 해줘야한다.
    //padding이 들어간 input 2차원 배열 동적배열로 선언
    int **input_padding_matrix;
    input_matrix= (int**) malloc (sizeof(int*)*input_height+2*padding);
    for(int i=0; i<input_height;i++){
        input_padding_matrix[i]=(int*) mallock(sizeof(int)*input_width+2*padding);
    }
    //배열 초기화
    for(int i=0; i<input_height+2*padding; i++){
        for(int j=0; j<input_width+2*padding; j++){
            input_padding_matrix[i][j]=0;
        }
    }
    for(int i=0; i<input_height; i++){ //padding 처리되기전 값은 그 안에 값으로 할당을 받는다.
        for(int j=0; j<input_width; j++){
            input_padding_matrix[i+padding][j+padding]=input_matrix[i][j];
        }
    }
    for(int i=0; i<input_height+2*padding;i++){ //padding을 통해 생성된 배열은 0값을 넣어준다.
        for(int j=0; j<input_width+2*padding;j++){
            if(i<padding){
                input_padding_matrix[i+padding][j+padding]=0;
            }
            else if(input_height+padding<=i){
                input_padding_matrix[i+padding][j+padding]=0;
            }
            else if( (padding<=i && i<input_height+padding && j<padding ) 
                    || (padding<=i && i<input_height+padding && input_width+padding<=j ) ){
                        input_padding_matrix[i+padding][j+padding]=0;
                    }
        }
    }


    for(int h=0; h<output_height; h++){ //output_tensor에 convolution값이 들어간다.
        for(int w=0; w<output_width; w++){
            for(int k=0; k<kernel_number; k++){
                for(int i=0; i<kernel_height; i++){
                    for(int j=0; j<kernel_width; j++){
                        temp=temp+input_matrix[i+h][j+w]*kernel_tensor[i][j][k];
                    }
                }
                output_tensor[h][w][k]=temp;
            }            
        }
    }

    FILE *fp_output = fopen("y_out_1s.dat","w");
    for(int k=0; k<output_number; k++){
        for(int i=0; i<output_height; i++){
            for(int j=0; j<output_width; j++){
                fprintf(fp_output, "%d \n", output_tensor[i][j][k]);
            }
            
        }
    }


    return 0;
}
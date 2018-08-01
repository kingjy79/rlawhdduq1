#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    //FILE *fpp;//파일포인터 -> fprintf에 사용되는 output용
    //FILE *fps;//파일포인터 -> fscanf에 사용되는 input용
    int temp=0;
    //int output_width=0;
    //int output_height=0;
    int input_width=32;
    int input_height=32;    
    int kernel_width=5;
    int kernel_height=5;
    int kernel_number=1;
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

    FILE *fp_kernel = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\C\\covolution_test\\w_in_1s.dat","r");
    //파일 오픈
    int kernel_get[150]={0,};
    char kernel_buffer[10];//한줄당 크기
    for(int i=0; i<150; i++){//150줄 이니깐 150번 반복
        if(fp_kernel==NULL){
            printf("Error opening file_kernel_get");
        }
        else{
            fgets(kernel_buffer, 10, fp_kernel);
            kernel_get[i]=atoi(kernel_buffer);
            puts(kernel_buffer);

        }
    }
    fclose(fp_kernel);
    printf("\nkernel_get[0]= %d\n", kernel_get[0]);
    printf("kernel_get[1]= %d\n", kernel_get[1]);
    return 0;
}
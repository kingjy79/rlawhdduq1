#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    int kernel_get=0;
    char buffer[42800]={0,} ;
    FILE *fp_kernel = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV.txt","r");
    //파일 오픈
    //double kernel_get[1600] = {0,};
    //char kernel_buffer[1600][25]={0,};
    //char *input_buffer; //버퍼동적배열
    //input_buffer=(char*) malloc(sizeof(char)*buffer_size);
    if(fp_kernel==NULL){
        printf("Error opening fp_kerenl");
    }
    else{
        for(int i=0; i<42800; i++){
            buffer[i] = fgetc(fp_kernel);
        }
    }
    fclose(fp_kernel);
    
/*   
    int count=0;
    for(int i=0; i<1599; i++){
        for(int j=i+1; j<1600; j++){
            if(kernel_get[i]==kernel_get[j]){
                count++;
                printf("\ni: %d j: %d",i+1,j+1); //배열은 0부터 시작하므로
            }
        }
    }
    printf("\ncount: %d\n", count);
*/

    
    FILE *fp_output = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV_gen_line.dat","w");
    for(int i=0; i<42800; i++){
        if(buffer[i]=='e' || buffer[i]=='0' || buffer[i]=='1' || buffer[i]=='2' ||\
                buffer[i]=='3' || buffer[i]=='4' || buffer[i]=='5' || buffer[i]=='6' ||\
                buffer[i]=='7' || buffer[i]=='8' || buffer[i]=='9' || buffer[i]=='-' || buffer[i]=='.'){
                    kernel_get=buffer[i];
                    fputc(kernel_get, fp_output);
                }
        if((buffer[i-3]=='e' && buffer[i-2]=='-' && buffer[i-1]=='0') &&\
                (buffer[i]=='1' || buffer[i]=='2' || buffer[i] =='3' || buffer[i] == '4')){
                    fputc('\n', fp_output);
                }   

    }
    fclose(fp_output);
printf("\npass");
    return 0;
}

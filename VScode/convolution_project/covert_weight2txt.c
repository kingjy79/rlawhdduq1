#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    FILE *fp_kernel = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV_modify.txt","r");
    //파일 오픈
    float kernel_get[1600] = {0,};
    char kernel_buffer[25];
    //char *input_buffer; //버퍼동적배열
    //input_buffer=(char*) malloc(sizeof(char)*buffer_size);
    if(fp_kernel==NULL){
        printf("Error opening file_kerenl");
    }
    else{
        for(int i=0; i<1600; i++){
            fgets(kernel_buffer, 25, fp_kernel);
            kernel_get[i]=(float)atof(kernel_buffer);
        }
    }
    fclose(fp_kernel);



    FILE *fp_output = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\python_conv_test\\2DCONV_line.dat","w");
    for(int i=0; i<1600; i++){
        fprintf(fp_output, "%f\n",kernel_get[i]*1e6);
    }
    fclose(fp_output);

    return 0;
}

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    FILE *fp_kernel = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_trained1.dat","r");
    //파일 오픈
    long long kernel_get[102400] = {0,};
    char kernel_buffer[30];
    //char *input_buffer; //버퍼동적배열
    //input_buffer=(char*) malloc(sizeof(char)*buffer_size);
    if(fp_kernel==NULL){
        printf("Error opening file_kerenl");
    }
    else{
        for(int i=0; i<102400; i++){
            fgets(kernel_buffer, 30, fp_kernel);
            kernel_get[i]=(long long)(atof(kernel_buffer)*1e7); //resolution 10^6(significant)
        }
    }
    fclose(fp_kernel);
    
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



    FILE *fp_output = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_c2_trained.dat","w");
    for(int i=0; i<102400; i++){
        fprintf(fp_output, "%lld\n",kernel_get[i]);
    }
    fclose(fp_output);

    return 0;
}

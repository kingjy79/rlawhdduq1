#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int main(int argc, char const *argv[])
{   
    srand(time(NULL));
    FILE *fp_kernel_print = fopen("c:\\Users\\kingjy79\\Documents\\rlawhdduq1\\VSCODE\\fprint_test\\w_random1.dat","w");
    for(int i=0; i<150; i++){
        fprintf(fp_kernel_print, "%f\n", (float)rand()/RAND_MAX*0.1);
    }
    fclose(fp_kernel_print);
    return 0;
}

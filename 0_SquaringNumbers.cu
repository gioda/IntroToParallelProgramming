/**
 * @Author: Giovanni Dalmasso <dalmasso>
 * @Date:   14-Sep-2018
 * @Email:  giovanni.dalmasso@embl.es
 * @Project: IntroToParallelProgramming
 * @Last modified by:   gioda
 * @Last modified time: 14-Sep-2018
 * @License: MIT
**/

#include <stdio.h>


__global__ void square(float *d_out, float *d_in)
{
    int idx = threadIdx.x;
    float f = d_in[idx];
    d_out[idx] = f*f;
}


int main(int argc, char ** argv)
{
    const int ARRAY_SIZE = 64;
    const int ARRAY_BITES = ARRAY_SIZE * sizeof(float);

    // generate the input array on the host
    float h_in[ARRAY_SIZE];
    for(int j=0; j<ARRAY_SIZE; j++)
    {
        h_in[j] = float(j);
    }
    float h_out[ARRAY_SIZE];

    // declare GPU memory pointers
    float * d_in;
    float * d_out;

    // allocate GPU memory
    cudaMalloc((void **) &d_in, ARRAY_BITES);
    cudaMalloc((void **) &d_out, ARRAY_BITES);

    // transfer the array to the GPU
    cudaMemcpy(d_in, h_in, ARRAY_BITES, cudaMemcpyHostToDevice);

    // lauch the kernel
    square<<<1, ARRAY_SIZE>>>(d_out, d_in);

    // copy back the result array to the CPU
    cudaMemcpy(h_out, d_out, ARRAY_BITES, cudaMemcpyDeviceToHost);

    // print out the resulting array
    for(int j=0; j<ARRAY_SIZE; j++)
    {
        printf("%f", h_out[j]);
        printf(((j % 4) !=3) ? "\t" : "\n");
    }

    // free GPU memory allocation
    cudaFree(d_in);
    cudaFree(d_out);

    return 0;
}

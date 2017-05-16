#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "snx_md5/snx_encrypt_decrypt.c"

int main(int argc,char *argv[])
{
	unsigned long long app_data[]={0x7890123456789012,0x1234567890123456};
	char *mch = NULL;
	FILE *fp;
	int i;

	char cmd_str[512];

	if (argc != 3)
		return -1;
//	data_size = 2* sizeof (unsigned long long);
	mch = argv[1];

	for (i=0;i<32;i++){
		printf("%c,", mch[i]);
	}

	printf("\n");

	memset(cmd_str, '\0', 512);
	sprintf(cmd_str, "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", mch[0],mch[1],mch[2],mch[3],mch[4],mch[5],mch[6],mch[7],mch[8],mch[9],mch[10],mch[11],mch[12],mch[13],mch[14],mch[15]);
	sscanf(cmd_str, "%016llX", &app_data[1] );

  	memset(cmd_str, '\0', 512);
	sprintf(cmd_str, "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", mch[16],mch[17],mch[18],mch[19],mch[20],mch[21],mch[22],mch[23],mch[24],mch[25],mch[26],mch[27],mch[28],mch[29],mch[30],mch[31]);
	sscanf(cmd_str, "%016llX", &app_data[0] );

	printf("app_data[0] = 0x%016llx\n", app_data[0]);  
	printf("app_data[1] = 0x%016llx\n", app_data[1]);

    //snx_decrypt
	snx_setkey();
//	printf("key=%08X\n\n",key);
	
	printf("Before encrypt\n");
	printf("app_data=0x%016llx%016llx\n\n",app_data[1],app_data[0]);

	snx_encrypt(app_data);
	printf("After encrypt\n");
	printf("app_data=0x%016llx%016llx\n\n",app_data[1],app_data[0]);


	fp = fopen(argv[2], "wb");
	fwrite(app_data, sizeof(unsigned long long), 2, fp);
	fclose (fp);

	return 0;
}


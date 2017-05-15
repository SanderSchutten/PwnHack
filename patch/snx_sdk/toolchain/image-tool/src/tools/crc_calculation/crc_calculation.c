#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <string.h>
#include <fcntl.h>

#include <sys/types.h>
#include <sys/stat.h>
#include "crc/crc.c"

static FILE * fopen_file(char *filename, char *mode)
{
	FILE *fp;
	
	fp = fopen(filename, mode);

	if(!fp) {
		fprintf(stderr, "open file: %s failed\n", filename);
		exit(-1);
	}

	return fp;
}

int main(int argc,char *argv[])
{
	if (argc != 3)
		return -1;

	char *in_file = argv[1];
	char *out_file = argv[2];
	char *in_buf;
	char crc_string[10] = {0};
	struct stat stats;
	crc crc_v;

	FILE *in_fp, *out_fp;

	in_fp = fopen_file(in_file, "r");
	out_fp = fopen_file(out_file, "w");
	
	fstat(fileno(in_fp), &stats);
	fprintf(stderr,"read size %d\n", stats.st_size);
	in_buf = malloc(stats.st_size);
	if(!in_buf){
		fprintf(stderr,"malloc failed\n");
		exit(-1);
	}
	fread(in_buf, sizeof(char), stats.st_size, in_fp);
	crc_v = crcSlow(in_buf,stats.st_size);
	sprintf(crc_string,"%d",crc_v);
	fwrite(crc_string, sizeof(char), strlen(crc_string), out_fp);
	
	fclose(in_fp);
	fclose(out_fp);

	return 0;
}


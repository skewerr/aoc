#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int  *valline;
char *tableline;
int sum;

int
linesum(int *line, int length)
{
	int nu, di;
	int i, j;

	for (i = 0; i < length; ++i) {
		for (j = 0; j < length; ++j) {
			if (i != j && line[i] % line[j] == 0)
				return line[i]/line[j];
		}
	}

	return 0;
}

char
*readline(char **dst, FILE *stream)
{
	static char buf[512];
	static int i;
	char *chr = NULL;

	for (i = 1; fgets(buf, sizeof buf, stream) != NULL; ++i) {
		*dst = realloc(*dst, i * sizeof buf);

		strcat(*dst, buf);

		if ((chr = strrchr(*dst, '\n')) != NULL) {
			*chr = '\0';
			return *dst;
		}
	}

	return NULL;
}

int
wordstoints(int **dst, char *str)
{
	char *token = NULL;
	int i;

	token = strtok(str, " \t");

	for (i = 1; token != NULL; ++i) {
		*dst = realloc(*dst, i * sizeof (int));
		sscanf(token, "%d", *dst + i - 1);
		token = strtok(NULL, " \t");
	}

	return i - 1;
}

int
main(void)
{
	int n;
	int i;

	while (readline(&tableline, stdin) != NULL) {
		n = wordstoints(&valline, tableline);
		sum += linesum(valline, n);
		free(tableline); tableline = NULL;
		free(valline); valline = NULL;
	}

	printf("%d\n", sum);

	return 0;
}

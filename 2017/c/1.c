#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *array = NULL;
int sum = 0;

int
main(void)
{
	char buf[512], *nl;
	int len;
	int i;

	for (i = 1; fgets(buf, sizeof buf, stdin) != NULL; ++i) {
		if (array == NULL)
			array = calloc(sizeof buf, 1);
		else
			array = realloc(array, i * sizeof buf);

		if ((nl = strchr(buf, '\n')) != NULL)
			*nl = '\0';

		sprintf(array, "%s%s", array, buf);
	}

	len = strlen(array);

	for (i = 0; array[i] != '\0'; ++i) {
		if (array[i] == array[(i + 1) % len])
			sum += array[i] - '0';
	}

	printf("%d\n", sum);

	return 0;
}

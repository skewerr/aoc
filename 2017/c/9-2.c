#include <stdio.h>
#include <inttypes.h>

uint64_t count = 0;
int garbage = 0;

int
main(void)
{
	int c;

	while ((c = fgetc(stdin)) != EOF) {
		if (garbage && c != '>' && c != '!') {
			++count;
			continue;
		}

		switch (c) {
			case '!': fgetc(stdin); break;
			case '<': garbage = 1; break;
			case '>': garbage = 0; break;
		}
	}

	printf("%" PRIu64 "\n", count);

	return 0;
}

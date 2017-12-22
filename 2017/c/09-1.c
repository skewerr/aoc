#include <stdio.h>
#include <inttypes.h>

int increment = 0;
uint64_t score = 0;
int garbage = 0;

int
main(void)
{
	int c;

	while ((c = fgetc(stdin)) != EOF) {
		if (garbage && c != '>' && c != '!')
			continue;

		switch (c) {
			case '!': fgetc(stdin); break;
			case '<': garbage = 1; break;
			case '>': garbage = 0; break;
			case '{': increment += 1; break;
			case '}': score += increment--; break;
		}
	}

	printf("%" PRIu64 "\n", score);

	return 0;
}

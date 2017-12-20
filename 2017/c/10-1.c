#include <stdio.h>
#include <inttypes.h>

uint8_t list[256];
uint8_t *position = list;
uint8_t skip = 0;

void
reversen(uint8_t length)
{
	uint8_t start = position - list;
	uint8_t end = (start + length) % sizeof list - 1;
	uint8_t flip1, flip2;
	uint8_t i;

	for (i = 0; i < length >> 1; ++i) {
		flip1 = (start + i) % sizeof list;
		flip2 = (end - i < 0) ? sizeof list + (end - i) : end - i;

		list[flip1] ^= list[flip2];
		list[flip2] ^= list[flip1];
		list[flip1] ^= list[flip2];
	}
}

void
hashstep(uint8_t length)
{
	reversen(length);
	position = list + ((position - list) + length + skip++) % sizeof list;
}

void
filllist(void)
{
	size_t i;

	for (i = 0; i < sizeof list; ++i)
		list[i] = i;
}

int
main(void)
{
	uint8_t length;

	filllist();

	while (scanf("%" SCNu8 ",", &length) != EOF)
		hashstep(length);

	printf("%u\n", list[0] * list[1]);

	return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

uint8_t list[256];
uint8_t *position = list;
uint8_t skip = 0;

uint64_t nlengths = 0;
uint8_t *lengths = NULL;
uint8_t suffix[] = {17, 31, 73, 47, 23};

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

void
readlengths(void)
{
	char buf[512];
	uint8_t i;

	for (i = 1; fgets(buf, sizeof buf, stdin) != NULL; ++i) {
		lengths = realloc(lengths, i * sizeof buf);
		strcat((char *) lengths, buf);
	}

	*(strchr((char *) lengths, '\n')) = '\0';
	nlengths = strlen((char *) lengths);
}

void
xor16s(void)
{
	uint8_t xord;
	uint8_t i, j;

	for (i = 0; i < 16; ++i) {
		xord = 0;
		for (j = 0; j < 16; ++j) {
			xord ^= list[16 * i + j];
		}
		list[i] = xord;
	}
}

int
main(void)
{
	uint8_t i, j;

	filllist();
	readlengths();

	for (i = 0; i < 64; ++i) {
		for (j = 0; j < nlengths; ++j)
			hashstep(lengths[j]);
		for (j = 0; j < sizeof suffix; ++j)
			hashstep(suffix[j]);
	}

	xor16s();

	for (i = 0; i < 16; ++i)
		printf("%.2x", list[i]);

	putchar('\n');

	return 0;
}

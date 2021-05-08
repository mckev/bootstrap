#include <stddef.h>
#include <stdint.h>

#include "util.h"


void memset(void* dst, uint8_t val, size_t count) {
	uint8_t* d = dst;
	while (count-- > 0) {
		*d++ = val;
	}
}

size_t strlen(const char* str) {
	size_t len = 0;
	while (str[len]) {
		len++;
	}
	return len;
}

char* itoa(int num, char* buffer) {
	int i = 0;
	do {
		int digit = num % 10;
		buffer[i++] = '0' + digit;
	} while (num /= 10);
	buffer[i--] = 0;	// null-terminated
	for (int j = 0; j < i; j++, i--) {
		char ch = buffer[j];
		buffer[j] = buffer[i];
		buffer[i] = ch;
	}
	return buffer;
}

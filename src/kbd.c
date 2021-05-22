// Ref: https://github.com/phf/xv6/blob/master/kbd.c


#include <stdint.h>

#include "kbd.h"
#include "system.h"
#include "trap.h"


// I/O Port
#define KBSTATP			0x64		// kbd controller status port(I)
#define KBS_DIB			0x01		// kbd data in buffer
#define KBDATAP			0x60		// kbd data port(I)

// Mode
#define SHIFT			(1<<0)
#define CTL				(1<<1)
#define ALT				(1<<2)
#define CAPSLOCK		(1<<3)
#define NUMLOCK			(1<<4)
#define SCROLLLOCK		(1<<5)
#define E0ESC			(1<<6)

// Keys
#define NO              0
#define KEY_HOME        0xE0
#define KEY_END         0xE1
#define KEY_UP          0xE2
#define KEY_DN          0xE3
#define KEY_LF          0xE4
#define KEY_RT          0xE5
#define KEY_PGUP        0xE6
#define KEY_PGDN        0xE7
#define KEY_INS         0xE8
#define KEY_DEL         0xE9


static char normalmap[256] = {
	NO,      0x1B,    '1',     '2',     '3',     '4',     '5',     '6',		// 0x00
	'7',     '8',     '9',     '0',     '-',     '=',     '\b',    '\t',
	'q',     'w',     'e',     'r',     't',     'y',     'u',     'i',		// 0x10
	'o',     'p',     '[',     ']',     '\n',    NO,      'a',     's',
	'd',     'f',     'g',     'h',     'j',     'k',     'l',     ';',		// 0x20
	'\'',    '`',     NO,      '\\',    'z',     'x',     'c',     'v',
	'b',     'n',     'm',     ',',     '.',     '/',     NO,      '*',		// 0x30
	NO,      ' ',     NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      '7',		// 0x40
	'8',     '9',     '-',     '4',     '5',     '6',     '+',     '1',
	'2',     '3',     '0',     '.',     NO,      NO,      NO,      NO,		// 0x50
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x60
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x70
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x80
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      KEY_HOME,// 0x90
	NO,      NO,      NO,      NO,      '\n',    NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xA0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      '/',     NO,      NO,		// 0xB0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xC0
	KEY_UP,  KEY_PGUP,NO,      KEY_LF,  NO,      KEY_RT,  NO,      KEY_END,
	KEY_DN,  KEY_PGDN,KEY_INS, KEY_DEL, NO,      NO,      NO,      NO,		// 0xD0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xE0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xF0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO
};

static char shiftmap[256] = {
	NO,      033,     '!',     '@',     '#',     '$',     '%',     '^',		// 0x00
	'&',     '*',     '(',     ')',     '_',     '+',     '\b',    '\t',
	'Q',     'W',     'E',     'R',     'T',     'Y',     'U',     'I',		// 0x10
	'O',     'P',     '{',     '}',     '\n',    NO,      'A',     'S',
	'D',     'F',     'G',     'H',     'J',     'K',     'L',     ':',		// 0x20
	'"',     '~',     NO,      '|',     'Z',     'X',     'C',     'V',
	'B',     'N',     'M',     '<',     '>',     '?',     NO,      '*',		// 0x30
	NO,      ' ',     NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      '7',		// 0x40
	'8',     '9',     '-',     '4',     '5',     '6',     '+',     '1',
	'2',     '3',     '0',     '.',     NO,      NO,      NO,      NO,		// 0x50
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x60
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x70
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x80
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      KEY_HOME,// 0x90
	NO,      NO,      NO,      NO,      '\n',    NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xA0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      '/',     NO,      NO,		// 0xB0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xC0
	KEY_UP,  KEY_PGUP,NO,      KEY_LF,  NO,      KEY_RT,  NO,      KEY_END,
	KEY_DN,  KEY_PGDN,KEY_INS, KEY_DEL, NO,      NO,      NO,      NO,		// 0xD0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xE0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xF0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO
};

#define C(x) (x - '@')				// C('A') == Control-A

static char ctlmap[256] = {
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x00
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	C('Q'),  C('W'),  C('E'),  C('R'),  C('T'),  C('Y'),  C('U'),  C('I'),	// 0x10
	C('O'),  C('P'),  NO,      NO,      '\r',    NO,      C('A'),  C('S'),
	C('D'),  C('F'),  C('G'),  C('H'),  C('J'),  C('K'),  C('L'),  NO,		// 0x20
	NO,      NO,      NO,      C('\\'), C('Z'),  C('X'),  C('C'),  C('V'),
	C('B'),  C('N'),  C('M'),  NO,      NO,      C('/'),  NO,      NO,		// 0x30
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x40
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x50
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x60
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x70
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x80
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      KEY_HOME,// 0x90
	NO,      NO,      NO,      NO,      '\r',    NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xA0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      C('/'),  NO,      NO,		// 0xB0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xC0
	KEY_UP,  KEY_PGUP,NO,      KEY_LF,  NO,      KEY_RT,  NO,      KEY_END,
	KEY_DN,  KEY_PGDN,KEY_INS, KEY_DEL, NO,      NO,      NO,      NO,		// 0xD0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xE0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xF0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO
};

static char shiftcode[256] = {
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x00
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x10
	NO,      NO,      NO,      NO,      NO,      CTL,     NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x20
	NO,      NO,      SHIFT,   NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      SHIFT,   NO,		// 0x30
	ALT,     NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x40
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x50
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x60
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x70
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x80
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x90
	NO,      NO,      NO,      NO,      NO,      CTL,     NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xA0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xB0
	ALT,     NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xC0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xD0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xE0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xF0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO
};

static char togglecode[256] = {
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x00
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x10
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x20
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x30
	NO,      NO,      CAPSLOCK,NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NUMLOCK, SCROLLLOCK, NO,	// 0x40
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x50
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x60
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x70
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x80
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0x90
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xA0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xB0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xC0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xD0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xE0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,		// 0xF0
	NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO
};


static int kbd_getc() {
	static char* charcode[4] = {
		normalmap, shiftmap, ctlmap, ctlmap
	};

	uint8_t st, data, c;
	st = inportb(KBSTATP);
	if ((st & KBS_DIB) == 0) {
		return -1;
	}
	data = inportb(KBDATAP);

	static uint8_t shift;
	if (data == 0xE0) {
		shift |= E0ESC;
		return 0;
	}
	else if (data & 0x80) {
		// Key released
		data = (shift & E0ESC ? data : data & 0x7F);
		shift &= ~(shiftcode[data] | E0ESC);
		return 0;
	}
	else if (shift & E0ESC) {
		// Last character was an E0 escape: or with 0x80
		data |= 0x80;
		shift &= ~E0ESC;
	}

	shift |= shiftcode[data];
	shift ^= togglecode[data];
	c = charcode[shift & (CTL | SHIFT)][data];
	if (shift & CAPSLOCK) {
		if (c >= 'a' && c <= 'z') {
			c += 'A' - 'a';
		}
		else if (c >= 'A' && c <= 'Z') {
			c += 'a' - 'A';
		}
	}
	return c;
}


void kbd_init() {
	pic_enable(IRQ_KBD);
}

#define INPUT_BUF 128
static volatile struct {			// "volatile" is required here to prevent C compiler from optimizing "while(!kbhit())" into "while(true)". This variable is changed through interrupt mechanism.
	char buf[INPUT_BUF];			// Circular buffer
	uint8_t r;	// Read index
	uint8_t e;	// Edit index
} input;

void kbd_intr() {
	// Ref: https://github.com/phf/xv6/blob/master/console.c at consoleintr()
	int c;

	while ((c = kbd_getc()) >= 0) {
		switch (c) {
		default:
			if (c != 0) {
				input.buf[input.e++ % INPUT_BUF] = c;
			}
		}
	}
}

bool kbhit() {
	return (input.r != input.e);
}

char getch() {
	while (!kbhit()) {
		// Blocking
	}
	return input.buf[input.r++ % INPUT_BUF];
}

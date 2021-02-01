#include "../lib/inttypes.h"

static void csu_init() {
	extern void (*__init_array_start []) ();
	extern void (*__init_array_end[]) ();

	const size_t size = __init_array_end - __init_array_start;
	for (size_t i = 0; i < size; i++) {
		(*__init_array_start[i])();
	}
}

extern "C" void _init();
extern "C" void _fini();
extern "C" int main();

extern "C" void startKernel() {
    _init();
    csu_init();

    main();

    _fini();
}
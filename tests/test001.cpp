#ifdef NDEBUG
#undef NDEBUG
#endif

#include <iostream>
#include <cassert>
#include <streflop.h>

using namespace std;
using namespace streflop;

int main() {
    // Initialize streflop (only needed for x86, optional otherwise)
    streflop_init<Simple>();

    // Perform some floating-point calculations
    Simple a = 1.1f;
    Simple b = 2.2f;
    Simple c = a * b + 3.3f;

    // Print results
    cout << "a: " << a << "\n";
    cout << "b: " << b << "\n";
    cout << "c: " << c << "\n";

    // Assert expected values (approximate checks due to floating-point precision)
    assert(abs(a - 1.1f) < 1e-6);
    assert(abs(b - 2.2f) < 1e-6);
    assert(abs(c - (1.1f * 2.2f + 3.3f)) < 1e-6);

    // Check determinism with a loop
    for (int i = 0; i < 5; i++) {
        Simple d = (a + b) * c;
        cout << "Iteration " << i << ": " << d << "\n";
        assert(abs(d - ((1.1f + 2.2f) * c)) < 1e-6);
    }

    return 0;
}

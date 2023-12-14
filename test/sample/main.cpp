#include <ok.hpp>

int main() {
#ifdef WITH_UNUSED
  int unused;
#endif
  return ok<int>();
}

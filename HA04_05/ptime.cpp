#include <iostream>
#include <string>
#include <chrono>

using namespace std;
using namespace std::chrono;

int main(int argc, char** argv) {

   if (argc != 3) {
      cout << "usage: ptime <iterations> <command>" << endl;
      return 1;
   }

   uint64_t iterations = stoull(argv[1]);
   string command = argv[2];

   auto start = high_resolution_clock::now();
   for (uint64_t i = 0; i < iterations; i++) {
      system((command + " > /dev/null").c_str());
   }
   auto stop = high_resolution_clock::now();

   // print in nanoseconds
   auto duration = duration_cast<microseconds>(stop - start);
   cout << "\ntime: " << duration.count() / iterations << " µs" << endl;
}
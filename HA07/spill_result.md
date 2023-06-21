## Spill results

| Method                   | Coloring Time | # Vars to Reg | Benchmarks | Gain     |
|--------------------------|---------------|---------------|------------|----------|
| No spill                 |   185 ms      | 17            | 7.355 ms   | baseline |
| Spill least neighbours   |  7428 ms      | 27            | 7.216 ms   |  1.88%   |
| Spill random             |  4136 ms      | 44            | 6.342 ms   | 13.76%   |
| Spill sequential order   |  3064 ms      | 58            | 6.262 ms   | 14.86%   |
| Spill most neighbours    |  2652 ms      | 59            | 6.133 ms   | 16.66%   |
| Spill least usages       | 14385 ms      | 58            | 6.004 ms   | 18.37%   |
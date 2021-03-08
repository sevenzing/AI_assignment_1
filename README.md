Prolog assignment
===

All test functions are in `main.pl`. In order to run it, follow these steps:


### 1. Create a map
    
+ Draw a map by yourself in `map.pl` using keywords `actor`, `covid`, `doctor`, `home` and `mask`
    
+ Or choose existing map in `maps/` directory and copy content in `map.pl` (I would suggest to start with `easy_map.pl`)

+ Change the `mazeSize(M).` to desired one, to change size of a map.
+ You can set any positive number of covids, masks and doctors

### 2. Run A* search

```console
swipl -g a_star main.pl
```

### 3. Run backtracking search

> be careful! calculating large maps can take time

```console
swipl -g bt_search main.pl
```


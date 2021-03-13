Prolog assignment
===

All test functions are in `main.pl`. In order to run it, follow these steps:


## 1. Create a map

+ Choose existing map in `maps/` directory and copy content in `map.pl` (I would suggest to start with `easy_map.pl`)

+ Or draw a map by yourself in `map.pl`: 
    + Use keywords `actor`, `covid`, `doctor`, `home` and `mask`

    + Change the `mazeSize(M).` to desired one, to change size of a map.

    + You can set any positive number of covids, masks and doctors
## 2. Install swipl

+ Ubuntu and Windows: [Installation guide](https://wwu-pi.github.io/tutorials/lectures/lsp/010_install_swi_prolog.html)

+ Arch: `pacman -S swi-prolog`

## 3. Run

You should run this code using linux console or Windows PowerShell.

The commands to run below are written for **linux**.

### 3.1 Run A* search

+ Run function `a_star.` in `main.pl`:

```console
$ swipl -g a_star main.pl
```

or

```console
$ swipl main.pl
?- a_star.
```


### 3.2 Run backtracking search

> be careful! calculating large maps can take time

+ Run function `bt_search.` in `main.pl`:

```console
$ swipl -g bt_search main.pl
```

or

```console
$ swipl main.pl
?- bt_search.
```
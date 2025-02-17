The flox package in this directory makes available `wolfram-engine` and two front ends, a jupyter-based one and another called wolfram-js-frontend (WLJS). The flake [timsears/wolfram-engine-frontends](https://github.com/timsears/wolfram-engine-frontends.git), also provides some libraries the front ends need at runtime. This last bit is the maine reason for writing a flox package, since it is tricky to track down and enable the dependencies.

To make a flox environment that offers the jupyter or WLJS front ends do the following:

```
$ mkdir <project> 
$ cd <project>
$ flox install github:timsears/wolfram-engine-with-frontends
$ flox activate
```

`wolfram-engine` is the backend and must be enabled one time by running:

```
$ wolframscript
```

This will prompt you to provide your wolfram id and password to enable the free-of-charge license. Activation also requires a free Wolfram account. 

Enter `2+2` to make sure it is working and then exit (Ctrl-D).

Now use one of the front ends to create a notebook and perform calculations that get routed to the wolfram kernel.

# WLJS 

To configure WLJS, you need to clone the WLJS repo:

```
$ git clone git@github.com:JerryI/wolfram-js-frontend.git
```

Then, and thereafter, to start WLJS frontend:

```
wolframscript -f Scripts/start.wls host 0.0.0.0 http 8080 ws 8081 ws2 8082 docs 8085
```

Note: WLJS uses `.wls` files. Conversion between this `.nb` used by Mathematica doesn't work right yet.

# jupyter

To configure jupyter, clone the git repo that provides a jupyter kernel that communicates with the wolfram engine:

```
git clone git@github.com:WolframResearch/WolframLanguageForJupyter.git  
./WolframLanguageForJupyter/configure-jupyter.wls add
```

The README in the repo contains additional methods to install and check for success. 

Thereafter, to start the juptyer frontend just enter:

```
jupyter notebook
```

Note: jupyter saves `.ipynb` files. Conversion between this and the `.nb` format is not provided, though it seems possible with some command line tools not provided by this repo.



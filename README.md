The flake in this repo helps you set up a flox environment with two front ends for `wolfram-engine`, a [jupyter-based one](https://github.com/WolframResearch/WolframLanguageForJupyter) and another called [wolfram-js-frontend (WLJS)](https://github.com/JerryI/wolfram-js-frontend). It does this by providing  the libraries the front ends need at runtime. This last bit is the maine reason for writing a flox envrionment, since it was a little tricky to track down and enable the dependencies. For convenience, `wolfram-engine` is included to provide the backend. To start, install and activate the flox environment as follows:
```
$ mkdir <project> 
$ cd <project>
$ flox install github:timsears/wolfram-engine-with-frontends
$ flox activate
```
A few extra manual steps are needed to complete the installation of the jupyter or WLJS frontends. Next, the backend `wolfram-engine` must be enabled one time by running:
```
$ wolframscript -activate
```
This will prompt you to enable the free-of-charge license by entering your wolfram id and password. (There are other actviation methods to be found out there if you are not using the free license.)

Enter `2+2` to make sure it is working and then exit (ctrl-d).

Now use one of the front ends to create a notebook and perform calculations that get routed to the wolfram kernel.
# WLJS 
To configure WLJS, you need to clone the WLJS repo:
```
$ git clone git@github.com:JerryI/wolfram-js-frontend.git
```
Then, and thereafter, to start WLJS frontend:
```
wolframscript -f wolfram-js-frontend/Scripts/start.wls host 0.0.0.0 http 8080 ws 8081 ws2 8082 docs 8085
```
Note: WLJS uses `.wls` files. Conversion between this `.nb` used by Mathematica doesn't work right yet.

# jupyter

To configure jupyter, clone the git repo WolframLanguageForJupyter that enables jupyter to communicate with the wolfram kernel:

```
git clone git@github.com:WolframResearch/WolframLanguageForJupyter.git  
./WolframLanguageForJupyter/configure-jupyter.wls add
```
The README in the repo contains additional methods to install and check for success. 

Thereafter, to start the juptyer frontend just enter:

```
jupyter notebook
```

## Notes: 
  - jupyter saves `.ipynb` files. Conversion between this and the `.nb` format is not provided, though it seems possible with some command line tools not provided by this repo.
  - If you try to run too many kernels, license limitations will kick in and things will stop working in mysterious ways. In general, keep an eye on zombie WolframKernel processes with `ps ux` or similar means.
  - There's another alternative front end using vscode not covered here. It uses `.vsnb` for the notebook file suffix.



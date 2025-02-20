# Flox Wolfram Engine with Frontends

The Flox package `wolfram-engine` supplies the same backend that powers Mathematica. There are several efforts to enable open-source frontends so that you can have a genuinely Mathematica-like experience with a free-of-charge license. As might be expected, it's not a smooth path to get there. So, I made a Flox environment that smooths the rough edges—mostly.

The result is a Flox environment, `wolfram-with-frontend`, hosted at [timsears/wolfram-with-frontend](https://hub.flox.dev/timsears/wolfram-with-frontend). It provides the necessary runtime libraries for these frontends. This was the main reason for creating a Flox environment since tracking down and enabling the required runtime library dependencies was a bit tricky. The environment also references the flake-based package `wolfram-engine-frontends` supplied by this repo.

This package extends the Flox package set by adding a script to download and configure two frontends for `wolfram-engine`: a [Jupyter-based one](https://github.com/WolframResearch/WolframLanguageForJupyter) and another called [wolfram-js-frontend (WLJS)](https://github.com/JerryI/wolfram-js-frontend).

You could use this flake independently of Flox, but it's not designed for that. Here's how to get the full setup. Install and activate the Flox environment as follows:

```sh
mkdir <project> 
cd <project>
flox pull timsears/wolfram-with-frontend
flox activate
install-frontends
```

That last line invokes a script that installs two Git repositories in the project directory and runs a configuration script for one of them.

## First-Time Setup

You will also need to obtain a free-of-charge Wolfram account on their site and use it here to enable the free-of-charge license by entering your Wolfram ID and password.

To start, just run:

```sh
wolframscript
```

Follow the activation prompt, enter `2+2` to make sure it is working, and then exit (Ctrl+D).

Now, use one of the frontends to create a notebook that routes calculations to the Wolfram backend.

## WLJS 

To start a WLJS frontend:

```sh
wolframscript -f wolfram-js-frontend/Scripts/start.wls host 0.0.0.0 http 8080 ws 8081 ws2 8082 docs 8085
```

**Note:** WLJS uses `.wls` files. Conversion between this and `.nb` files used by Mathematica doesn’t work correctly yet.

## Jupyter

To start the Jupyter frontend, just enter:

```sh
jupyter notebook
```

## Notes

- Jupyter saves `.ipynb` files. Conversion between this and the `.nb` format is not provided, though it seems possible with some command-line tools not included in this repo.
- If you try to run too many kernels, license limitations will kick in, and things will stop working in mysterious ways. Exit the frontend properly to avoid this. In general, keep an eye on zombie `WolframKernel` processes with `ps ux` or similar commands.
- There’s another alternative frontend using VS Code that is not covered here. It uses `.vsnb` as the notebook file extension. It doesn’t require any special packaging help to use, as far as I know. You can install plugins directly in VS Code to enable this approach and simply ensure `wolfram-engine` is in your environment.
- The README in the cloned Jupyter repo contains additional methods for installation and verification.
- To extend Flox, this article was helpful: [Extending Flox with Nix Flakes](https://flox.dev/blog/extending-flox-with-nix-flakes).
- With a little more work, we could probably avoid polluting the project directory with the downloaded Git repositories. Maybe later!

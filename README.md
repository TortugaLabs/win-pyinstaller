# win-pyinstaller

Run Windows pyinstaller via Docker container

Create Windows executables on Linux using PyInstaller under
Wine/Docker.

Based on:

- [iiPythonx/pyinstaller-windows](https://github.com/iiPythonx/pyinstaller-windows)
- [cdrx/docker-pyinstaller](https://github.com/cdrx/docker-pyinstaller)

# Installation

- Install [Docker](https://docs.docker.com/get-docker/), including
  the docker-buildx add-on.
- Clone the repo.
- Build:
  ```
  make build
  ```
  This will create the docker image.
- To use either run use:
  - `make run ARGS=...`
  - `pybuild [opts]`

# Usage

For normal usage enter:

```
./pybuild --onefile --name appname src/main.py
```
It will first read the `requirements.txt` in the current directory
to load any required python packages, and then run `pyinstaller`
with the provided arguments.


`pybuild` will run `pyinstaller` with the provided arguments.  The
following sub-commands are available:

- cmd : Run a Windows command shell in the container
- sh : Run a UNIX shell in the container
- help : Show help from pyinstaller

## Common options

- -D, --onedir : Create a one-folder bundle containing an executable (default)
- -F, --onefile : Create a one-file bundled executable.
- -n NAME,--name NAME : Name to assign to the bundled app and spec file
  (default: first script's basename)
- --add-data SOURCE:DEST : Additional data files or directories containing data
  files to be added to the application. The argument value should be in form of
  "source:dest_dir".
- --noupx : Do not use UPX even if it is available
- -c, --console, --nowindowed :
  Open a console window for standard i/o (default). On Windows this option has no effect if the first
  script is a '.pyw' file.
- -w, --windowed, --noconsole :
  do not provide a console window for standard i/o.
- --hide-console {hide-late,minimize-early,hide-early,minimize-late} :
  in console-enabled executable, have bootloader automatically hide or minimize the
  console window if the program owns the console window (i.e., was not launched from
  an existing console window)

# TODO

- [ ] create github action



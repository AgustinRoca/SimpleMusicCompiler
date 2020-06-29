# SimpleMusicCompiler
### Compilation
#### Linux
Without debug options:
```sh
$ make
```
With debug options:
```sh
$ make debug
```
#### MacOS
Without debug options:
```sh
$ make macos
```
With debug options:
```sh
$ make macos_debug
```

#### Windows
Unfortunetly there is yet no support for windows

### Prerequesites
The following python libraries are necessary: [simple audio](https://github.com/hamiltron/py-simple-audio) [numpy](https://github.com/numpy/numpy)

To install them run:
```sh
$ pip install simpleaudio
$ pip install numpy
```
Or with virtualenv:
```sh
$ virtualenv env
$ source ./env/bin/activate
$ pip install simpleaudio
$ pip install numpy
```
### Run
To run it:
```sh
$ compiler < example/example.music
$ python out.py
```
Or with virtualenv:
```sh
$ compiler < example/example.music
$ source ./env/bin/activate
$ python out.py
```
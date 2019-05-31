# LogicCalculator

LogicCalculator is a calculator for 1st order logic. Constants are "true" and "false", or resp. "0" and "1". Fonctions are: "OR", "NOR", "AND", "NAND", "-" (for NOT). 

### Prerequisites

You must have cmake installed:
```
sudo apt-get install cmake
```

### Installing


A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
git clone git://github.com/EzrielS/LogicCalculator
cd LogicCalculator
mkdir build
cd build
cmake ..
make
sudo make install
```

And then you can clean up the folder with :
```
rm -rf ../build
```



## Packaging

You can simply package the program modifying packaging/CMakePackages.txt to uncomment the type you want, uncomment the last line of CMakeLists.txt and executing:
```
mkdir build
cd build
cmake ..
make
make package
```

## Authors

* **Ezriel STEINBERG** - (https://github.com/EzrielS)


## License

This project is licensed under the BeerWare Licence License - see the [COPYRIGHT.txt](COPYRIGHT.txt) file for details.

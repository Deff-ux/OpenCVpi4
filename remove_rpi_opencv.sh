# It is always possible to alter some -D switch in CMake and rebuild the package. 
# The already build modules are kept, only the new ones are generated. 
# Of course, in the end, you may be facing still the long wait when everything must be linked into one large Python file. 
# If you want a clean build, remove the complete build directory with all its subdirectories by the single command below. 
# Next, make a new directory with the same name and start all over again.

cd ~/opencv
sudo rm -r build

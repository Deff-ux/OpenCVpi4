# to get the current status
sudo rpi-eeprom-update
# if needed, to update the firmware
sudo rpi-eeprom-update -a

# installation script
# you need at least a total of 6.5 GB!
# if not, enlarge your swap space as explained in the guide
wget https://github.com/Qengineering/Install-OpenCV-Raspberry-Pi-32-bits/raw/main/OpenCV-4-5-5.sh
sudo chmod 755 ./OpenCV-4-5-5.sh
./OpenCV-4-5-5.sh

# dependencies
sudo apt -y install build-essential cmake git unzip pkg-config
sudo apt -y install libjpeg-dev libpng-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev
sudo apt -y install libgtk2.0-dev libcanberra-gtk* libgtk-3-dev
sudo apt -y install libgstreamer1.0-dev gstreamer1.0-gtk3
sudo apt -y install libgstreamer-plugins-base1.0-dev gstreamer1.0-gl
sudo apt -y install libxvidcore-dev libx264-dev
sudo apt -y install python3-dev python3-numpy python3-pip
sudo apt -y install libtbb2 libtbb-dev libdc1394-22-dev
sudo apt -y install libv4l-dev v4l-utils
sudo apt -y install libopenblas-dev libatlas-base-dev libblas-dev
sudo apt -y install liblapack-dev gfortran libhdf5-dev
sudo apt -y install libprotobuf-dev libgoogle-glog-dev libgflags-dev
sudo apt -y install protobuf-compiler

# qt5 
# only install if want Qt5
# to beautify your OpenCV GUI
sudo apt-get install qt5-default

# download the latest version
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.5.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.5.zip
# unpack
unzip opencv.zip
unzip opencv_contrib.zip
# some administration to make live easier later on
mv opencv-4.5.5 opencv
mv opencv_contrib-4.5.5 opencv_contrib
# clean up the zip files
rm opencv.zip
rm opencv_contrib.zip

# build make (actual build of the library)
cd ~/opencv/
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D ENABLE_NEON=ON \
-D ENABLE_VFPV3=ON \
-D WITH_OPENMP=ON \
-D WITH_OPENCL=OFF \
-D BUILD_ZLIB=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=OFF \
-D WITH_GSTREAMER=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_VTK=OFF \
-D WITH_QT=OFF \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF ..

make -j4

# to complete, install all the generated packages and update the database of your system
sudo make install
sudo ldconfig
# cleaning (frees 300 KB)
make clean
sudo apt-get update


# Build Xyce

Copy the Xyce source tarball to this directory.

````
docker build -t stevenmburns/xyce .
````
The result of this build has been uploaded to docker hub. You can bypass this step and just download and use it.

# Run Xyce Regression

Copy the Xyce_Regression tarball to this directory
Build a new image layer because we need python and numpy.

````
docker build -t xyce_regression -f Dockerfile.regression .
````
Copy the Xyce_Regression tarball `Xyce_Regression-6.10.tar.gz` to this directory.

````
cat Xyce_Regression-6.10.tar.gz | docker run -i --mount source=regVol,target=/opt/Xyce/Test ubuntu bash -c "cd /opt/Xyce/Test && tar xvfz -"

docker run -it --mount source=regResultVol,target=/tmp/regResult --mount source=regVol,target=/opt/Xyce/Test xyce_regression bash -c 'cd /tmp && /opt/Xyce/Test/Xyce_Regression-6.10/TestScripts/run_xyce_regression --output=/tmp/regResult/Xyce_Test --xyce_test=/opt/Xyce/Test/Xyce_Regression-6.10 --resultfile=/tmp/regResult/serial_results --taglist="+serial+nightly?noverbose-verbose?klu?fft" /usr/local/bin/Xyce'
````

# Run a simple test and extract from volume.

````
docker run -it --mount source=regVol,target=/opt/Xyce/Test stevenmburns/xyce bash -c 'cd /opt/Xyce/Test/Xyce_Regression-6.10/Netlists/RLC && /usr/local/bin/Xyce rlc.cir'

docker run --mount source=regVol,target=/opt/Xyce/Test ubuntu bash -c 'cd /opt/Xyce/Test/Xyce_Regression-6.10/Netlists/RLC && tar cvf - .' > Results.tar
````

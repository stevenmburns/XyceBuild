
# Build Xyce

Copy the Xyce source tarball `Xyce-6.10.tar.gz` to this directory. (You can get this from https://xyce.sandia.gov/ after filling out a short form.)

```bash
docker build -t stevenmburns/xyce .
```
The result of this build has been uploaded to docker hub. You can bypass this step and just download and use it.

# Run Xyce Regression

Build a new image layer because we need python, numpy and scipy.

```bash
docker build -t xyce_regression -f Dockerfile.regression .
```

Copy the Xyce_Regression tarball `Xyce_Regression-6.10.tar.gz` to this directory. (Get this from https://xyce.sandia.gov/)

```bash
cat Xyce_Regression-6.10.tar.gz | docker run -i --mount source=regVol,target=/opt/Xyce/Test ubuntu bash -c "cd /opt/Xyce/Test && tar xvfz -"

docker run -it --mount source=regResultVol,target=/tmp/regResult --mount source=regVol,target=/opt/Xyce/Test xyce_regression bash -c 'cd /tmp && /opt/Xyce/Test/Xyce_Regression-6.10/TestScripts/run_xyce_regression --output=/tmp/regResult/Xyce_Test --xyce_test=/opt/Xyce/Test/Xyce_Regression-6.10 --resultfile=/tmp/regResult/serial_results --taglist="+serial+nightly?noverbose-verbose?klu?fft-library" /usr/local/bin/Xyce'
```

# Run a simple test and extract from volume.

```bash
docker run -it --mount source=regVol,target=/opt/Xyce/Test stevenmburns/xyce bash -c 'cd /opt/Xyce/Test/Xyce_Regression-6.10/Netlists/RLC && /usr/local/bin/Xyce rlc.cir'

docker run --mount source=regVol,target=/opt/Xyce/Test ubuntu bash -c 'cd /opt/Xyce/Test/Xyce_Regression-6.10/Netlists/RLC && tar cvf - .' > Results.tar
```

# Build a small image by extracting executable and shared libraries from original build

The `stevenmburns/xyce` is 2.65GB. We can reduce its size by 137MB by copying the minimum that is needed out of the larger image.
Here is one way to do this:
```bash
docker build -f Dockerfile.small.ubuntu -t stevenmburns/xyce_small_ubuntu .
```

Here is the docker file.
```
FROM stevenmburns/xyce as xyce

FROM ubuntu as xyce_small_ubuntu_alt

COPY --from=xyce /usr/local/bin/Xyce /usr/local/bin/
COPY --from=xyce /usr/lib/x86_64-linux-gnu/libfftw3.so.3 /usr/lib/x86_64-linux-gnu/libamd.so.2 /usr/lib/x86_64-linux-gnu/liblapack.so.3 /usr/lib/x86_64-linux-gnu/libblas.so.3 /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libsuitesparseconfig.so.5 /usr/lib/x86_64-linux-gnu/libgfortran.so.4 /usr/lib/x86_64-linux-gnu/libquadmath.so.0 /usr/lib/x86_64-linux-gnu/
```

This will generate the help message:
```bash
docker run -it stevenmburns/xyce_small_ubuntu bash -c "/usr/local/bin/Xyce --help"
```
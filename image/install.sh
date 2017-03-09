# upgrade to latest debian packages 
apt-get -q update && apt-get upgrade -q -y -o DPkg::Options::=--force-confnew

#list of all dependencies that can be satisfied via the package management system of Ubuntu
apt-get install -y --no-install-recommends wget g++ build-essential software-properties-common python-software-properties git julia hdf5-tools gzip hmmer patch make xz-utils ca-certificates libz-dev unzip

#install dependencies
add-apt-repository -y ppa:staticfloat/juliareleases add-apt-repository -y ppa:staticfloat/julia-deps
#~ RUN git config --global url."https://".insteadOf git://
julia -e 'Pkg.add("HDF5"); Pkg.add("ArgParse");'

# install CAMIARKQuickr
wget https://github.com/dkoslicki/CAMIARKQuikr/archive/master.zip
unzip master.zip && rm master.zip
wget https://github.com/EESI/dna-utils/archive/master.zip && unzip master.zip
make -C /dna-utils-master/
mv /dna-utils-master/* /usr/local/bin/
wget --quiet --output-document - https://github.com/lh3/seqtk/archive/v1.2.tar.gz | tar xzf - --directory /usr/local/bin --strip-components=1
make -C /usr/local/bin

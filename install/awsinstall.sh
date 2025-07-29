curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -p "${HOME}/conda"
rm Miniforge3-$(uname)-$(uname -m).sh
source "${HOME}/conda/etc/profile.d/conda.sh"
source "${HOME}/conda/etc/profile.d/mamba.sh"
conda init
mamba shell init
conda env create -f ngpipe.yaml
git clone https://github.com/qhgenomics/pyngoST.git
git clone https://github.com/kjolley/BIGSdb_downloader.git
mkdir -p ${HOME}/.local/bin
ln -s ~/pyngoST/pyngoST/pyngoST.py ~/.local/bin
ln -s ~/BIGSdb_downloader/bigsdb_downloader.py ~/.local/bin

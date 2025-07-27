curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -p "${HOME}/conda"
rm Miniforge3-$(uname)-$(uname -m).sh
source "${HOME}/conda/etc/profile.d/conda.sh"
source "${HOME}/conda/etc/profile.d/mamba.sh
conda init
mamba shell init
conda env create -f ngpipe.yaml


# CUDA
path=($path "/usr/local/cuda/bin")
if [ -z "${ld_library_path}" ]; then
	typeset -xT LD_LIBRARY_PATH ld_library_path
fi
ld_library_path=("/usr/local/cuda-8.0/lib64" $ld_library_path)
export CUDA_HOME="/usr/local/cuda"

# CAFFE
path=($path "$HOME/projects/caffe/build/tools")

# Other private commands
path=($path "$HOME/bin")

# private treefrog
path=($path "$HOME/treefrog/bin")


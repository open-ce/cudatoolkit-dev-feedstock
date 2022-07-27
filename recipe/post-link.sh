#!/usr/bin/env bash

# Originally forked from https://github.com/conda-forge/cudatoolkit-dev-feedstock
# Distributed under the BSD-3-Clause license
# Copyright (c) 2017, Continuum Analytics, Inc. All rights reserved.

set -o pipefail


create_symlink_linux() {

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/bin/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/bin/${link};
        done

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/lib64/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/lib/${link};

        done

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/nvvm/bin/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/bin/${link};

        done

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/nvvm/lib64/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/lib/${link};

        done

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/nvvm/libdevice/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/lib/${link};

        done

        for f in $CONDA_PREFIX/pkgs/cuda-toolkit/include/*;
        do 
            link=$(basename "$f");
            ln -sf $f $CONDA_PREFIX/include/${link};

        done


        ln -sf $CONDA_PREFIX/pkgs/cuda-toolkit/nvvm $CONDA_PREFIX/
        ln -sf $CONDA_PREFIX/lib $CONDA_PREFIX/lib64

}


python $PREFIX/bin/cudatoolkit-dev-post-install.py

test -d $CONDA_PREFIX/pkgs/cuda-toolkit || exit 1

mkdir -p $CONDA_PREFIX/bin
mkdir -p $CONDA_PREFIX/lib
mkdir -p $CONDA_PREFIX/include

shopt -s nullglob

create_symlink_linux

shopt -u nullglob

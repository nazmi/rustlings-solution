#!/bin/bash

FILE=./rustlings-test.sh
if [[ -f "$FILE" ]]; then
    echo "Please run the script from outside of the directory."
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "No version provided. Refer repo branches for available versions."
    exit 1
fi

test_solutions() {
    rm -rf rustlings
    git clone -b $1 --depth 1 https://github.com/rust-lang/rustlings
    cd rustlings && cargo install --force --path .
    cd ../rustlings-solution && git checkout $1
    cp -R ./exercises/* ../rustlings/exercises
    cd ../rustlings && rustlings watch
    cd ../rustlings-solution && git checkout main
    rm -rf ../rustlings
}

case $1 in
    5.2.1 | \
    5.1.1 | \
    5.0.0)
        test_solutions $1
        ;;
    *)
        echo "Version not supported. Refer repo branches for available versions."
        exit 1
        ;;
esac



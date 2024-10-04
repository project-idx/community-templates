#!/bin/bash
fail() {
    echo "Unable to log in. Please re-run ./installDeps.sh to configure Flutter for your workstation."
    exit 1
}
pnpm install 2>&1 | tee install.txt
pnpm run start:proxy 2>&1 | tee start_proxy.txt

mkdir /repo
cp ./packages/* /repo
repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build .
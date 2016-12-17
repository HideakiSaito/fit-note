#postgers start
pg_ctl -D /usr/local/var/postgres start

#Mac軽くする
sudo purge
du -sx /
sudo update_dyld_shared_cache -force 
sudo kextcache -system-caches
sudo kextcache -system-prelinked-kernel
sudo periodic daily weekly monthly
ls -l /var/log/*.out
sudo rm -rf ~/Library/Developer/Xcode/DerivedData
sudo rm -rf ~/Library/Developer/Xcode/Archives
sudo rm -rf ~/Library/Caches


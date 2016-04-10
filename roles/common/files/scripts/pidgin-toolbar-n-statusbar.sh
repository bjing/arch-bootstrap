#!/bin/bash
wget http://vayurik.ru/wordpress/wp-content/uploads/toobars/1.14/pidgin-toobars-1.14.tar.gz -O /tmp/toolbar-n-statusbar.tar.gz
cd /opt
mkdir pidgin-toolbar-n-statusbar
cd pidgin-toolbar-n-statusbar
tar --strip-components=1 -xvf /tmp/toolbar-n-statusbar.tar.gz
./configure && make && make install

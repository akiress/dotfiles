#! /bin/bash
#
# dirtree.sh
# Copyright (C) 2013 Benjamin Guitreau <Benjamin Guitreau@DESKTOPAKI>
#
# Distributed under terms of the MIT license.
#

ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'

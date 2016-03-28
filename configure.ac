AC_INIT([xdpyprobe], [0.1])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([foreign subdir-objects])

AC_CONFIG_HEADERS([src/config.h])
AC_CONFIG_SRCDIR([src/xdpyprobe.c])

AC_PROG_CC
AC_PATH_X
AM_MISSING_PROG([HELP2MAN], [help2man])

AC_DEFINE([COPYRIGHT_YEAR], [m4_esyscmd([date +%Y])],
          [Year in the copyright message])
AM_CONDITIONAL([BUILD_FROM_GIT], [test -d "$srcdir/.git"])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT

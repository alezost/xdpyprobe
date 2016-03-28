bin_PROGRAMS = xdpyprobe
xdpyprobe_SOURCES = src/xdpyprobe.c
xdpyprobe_LDADD = -lX11

dist_man_MANS = xdpyprobe.1

if BUILD_FROM_GIT
xdpyprobe.1: xdpyprobe
	$(HELP2MAN) --no-info --output="$@" $(top_builddir)/xdpyprobe
CLEANFILES = xdpyprobe.1
endif

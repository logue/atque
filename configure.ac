AC_INIT(atque, 1.1.2, [http://sourceforge.net/tracker/?func=add&group_id=235817&atid=1097912] )

AC_PREREQ([2.59])
AC_CONFIG_AUX_DIR(config)
AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_MACRO_DIRS([m4])
AC_CONFIG_HEADER(config.h)

AC_ARG_ENABLE(gui, [ --enable-gui	build atque GUI [default=yes]], , enable_gui=yes)

AC_LANG(C++)

AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_CXXCPP
AC_PROG_INSTALL
AC_PROG_LIBTOOL

dnl Some platform specific stuff.
AS_CASE([$target],
        [*-*-mingw32*],
        [ make_windows=true
          AC_CHECK_TOOL(WINDRES, windres, :)
          make_windows="yes"
          LDFLAGS="$LDFLAGS -Wl, -S" ]
)

PKG_CHECK_MODULES(SNDFILE, sndfile, LIBS="-lsndfile $LIBS", AC_ERROR([Atque requires libsndfile]))
AC_SUBST(SNDFILE_CFLAGS)
AC_SUBST(SNDFILE_LIBS)

dnl On some systems iconv is in a separate library, and may actually be named
dnl libiconv.
AC_CHECK_LIB(iconv, libiconv)
if test $ac_cv_lib_iconv_libiconv = no; then
	AC_CHECK_LIB(iconv, iconv , AC_MSG_ERROR([You need iconv to run Atque JP.]))
fi

AX_BOOST_BASE([1.33.1])

if [[ "x$enable_gui" = "xyes" ]]; then
AM_OPTIONS_WXCONFIG
reqwx=3.0.0
AM_PATH_WXCONFIG($reqwx, wxWin=1)
fi

if test "$wxWin" != 1; then
   AC_MSG_WARN([wxWidgets not enabled, building command line tools only])
else
   CPPFLAGS="$CPPFLAGS $WX_CPPFLAGS"
   CXXFLAGS="$CXXFLAGS $WX_CXXFLAGS_ONLY -std=gnu++11"
   CFLAGS="$CFLAGS $WX_CFLAGS_ONLY"
   LIBS="$LIBS $WX_LIBS"
fi

AM_CONDITIONAL(BUILD_ATQUEGUI, [test "$wxWin" = 1 ])
AM_CONDITIONAL([MAKE_WINDOWS], [test "x$make_windows" = "xtrue"])

AC_CONFIG_FILES([Makefile ferro/Makefile])
AC_OUTPUT

echo "Configuration done. Now type \"make\"."


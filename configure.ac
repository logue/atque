AC_INIT(atque, 1.1.2, [http://sourceforge.net/tracker/?func=add&group_id=235817&atid=1097912] )

AC_CONFIG_MACRO_DIR([m4])
AC_PREREQ([2.65])

dnl Detect the canonical host and target build environment.
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

dnl Init automake.
AM_INIT_AUTOMAKE([foreign])
AM_CONFIG_HEADER([config.h])

dnl Configure options.
AC_ARG_ENABLE(gui, [ --enable-gui	build atque GUI [default=yes]], , enable_gui=yes)

AC_LANG(C++)
dnl Check for programs.
AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_CXXCPP
AC_PROG_OBJCXX
AC_PROG_INSTALL
AC_PROG_LIBTOOL

dnl Require C++11 or newer and enable C++11 if needed.
AX_CXX_COMPILE_STDCXX([11], [], [mandatory])

dnl Some platform specific stuff.
AS_CASE([$target],
        [*-*-mingw32*],
        [ make_windows=true
          ax_boost_user_locale_lib="boost_locale-mt"
          LDFLAGS="$LDFLAGS -Wl,-subsystem,windows"
          LIBS="$LIBS -lstdc++" ],
)

PKG_CHECK_MODULES(SNDFILE, sndfile, LIBS="-lsndfile $LIBS", AC_ERROR([Atque requires libsndfile]))
AC_SUBST(SNDFILE_CFLAGS)
AC_SUBST(SNDFILE_LIBS)

dnl Check for boost functions and libraries.
AX_BOOST_BASE([1.53.0],
              ,
              [AC_MSG_ERROR([You need Boost 1.53.0 or higher to build Atque.])])
AX_BOOST_LOCALE
AS_IF([ test "x$BOOST_LOCALE_LIB" != "x" ],
      [ LIBS="$BOOST_LOCALE_LIB $LIBS" ],
      [AC_MSG_ERROR([You need the Boost::Locale library to run Atque.])])

AC_DEFUN([AX_CHECK_BOOST_HEADER],
         [ AC_LANG_PUSH(C++)
           AC_CHECK_HEADER([$1], , [AC_MSG_ERROR([You need $1 from the Boost library to build Atque.])])
           AC_LANG_POP(C++) ])

AX_CHECK_BOOST_HEADER([boost/algorithm/string/predicate.hpp])
AX_CHECK_BOOST_HEADER([boost/assign.hpp])
AX_CHECK_BOOST_HEADER([boost/assign/list_of.hpp])
AX_CHECK_BOOST_HEADER([boost/crc.hpp])
AX_CHECK_BOOST_HEADER([boost/locale/encoding.hpp])

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


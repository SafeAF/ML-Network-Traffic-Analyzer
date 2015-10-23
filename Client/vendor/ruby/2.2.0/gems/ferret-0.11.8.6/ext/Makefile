
SHELL = /bin/sh

# V=0 quiet, V=1 verbose.  other values don't work.
V = 0
Q1 = $(V:1=)
Q = $(Q1:0=@)
ECHO1 = $(V:1=@:)
ECHO = $(ECHO1:0=@echo)
NULLCMD = :

#### Start of system configuration section. ####

srcdir = .
topdir = /home/vishnu/.rvm/rubies/ruby-2.2.1/include/ruby-2.2.0
hdrdir = $(topdir)
arch_hdrdir = /home/vishnu/.rvm/rubies/ruby-2.2.1/include/ruby-2.2.0/x86_64-linux
PATH_SEPARATOR = :
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = $(DESTDIR)/home/vishnu/.rvm/rubies/ruby-2.2.1
rubysitearchprefix = $(rubylibprefix)/$(sitearch)
rubyarchprefix = $(rubylibprefix)/$(arch)
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorarchhdrdir = $(vendorhdrdir)/$(sitearch)
sitearchhdrdir = $(sitehdrdir)/$(sitearch)
rubyarchhdrdir = $(rubyhdrdir)/$(arch)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_VERSION_NAME)
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitearchdir = $(DESTDIR)./.gem.20151019-24530-wdplrg
sitelibdir = $(DESTDIR)./.gem.20151019-24530-wdplrg
sitedir = $(rubylibprefix)/site_ruby
rubyarchdir = $(rubylibdir)/$(arch)
rubylibdir = $(rubylibprefix)/$(ruby_version)
sitearchincludedir = $(includedir)/$(sitearch)
archincludedir = $(includedir)/$(arch)
sitearchlibdir = $(libdir)/$(sitearch)
archlibdir = $(libdir)/$(arch)
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(prefix)/include
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(DESTDIR)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
archdir = $(rubyarchdir)


CC = gcc
CXX = g++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -Wl,-rpath,'$${ORIGIN}/../lib' -Wl,-R'$${ORIGIN}/../lib' -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -Wl,-rpath,'$${ORIGIN}/../lib' -Wl,-R'$${ORIGIN}/../lib' -l$(RUBY_SO_NAME)-static
empty =
OUTFLAG = -o $(empty)
COUTFLAG = -o $(empty)

RUBY_EXTCONF_H = 
cflags   =  $(optflags) $(debugflags) $(warnflags)
optflags = -O3 -fno-fast-math
debugflags = -ggdb3
warnflags = -Wall -Wextra -Wno-unused-parameter -Wno-parentheses -Wno-long-long -Wno-missing-field-initializers -Wunused-variable -Wpointer-arith -Wwrite-strings -Wdeclaration-after-statement -Wimplicit-function-declaration -Wdeprecated-declarations -Wno-packed-bitfield-compat
CCDLFLAGS = -fPIC
CFLAGS   = $(CCDLFLAGS) $(cflags)  -fPIC -Wall -D_FILE_OFFSET_BITS=64 -D_XOPEN_SOURCE=500 $(ARCH_FLAG)
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir)
DEFS     = 
CPPFLAGS =   $(DEFS) $(cppflags)
CXXFLAGS = $(CCDLFLAGS) $(cxxflags) $(ARCH_FLAG)
ldflags  = -L. -fstack-protector -rdynamic -Wl,-export-dynamic
dldflags =  
ARCH_FLAG = 
DLDFLAGS = $(ldflags) $(dldflags) $(ARCH_FLAG)
LDSHARED = $(CC) -shared
LDSHAREDXX = $(CXX) -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = $(RUBY_BASE_NAME)
RUBY_SO_NAME = ruby
RUBYW_INSTALL_NAME = 
RUBY_VERSION_NAME = $(RUBY_BASE_NAME)-$(ruby_version)
RUBYW_BASE_NAME = rubyw
RUBY_BASE_NAME = ruby

arch = x86_64-linux
sitearch = $(arch)
ruby_version = 2.2.0
ruby = $(bindir)/$(RUBY_BASE_NAME)
RUBY = $(ruby)
ruby_headers = $(hdrdir)/ruby.h $(hdrdir)/ruby/ruby.h $(hdrdir)/ruby/defines.h $(hdrdir)/ruby/missing.h $(hdrdir)/ruby/intern.h $(hdrdir)/ruby/st.h $(hdrdir)/ruby/subst.h $(arch_hdrdir)/ruby/config.h

RM = rm -f
RM_RF = $(RUBY) -run -e rm -- -rf
RMDIRS = rmdir --ignore-fail-on-non-empty -p
MAKEDIRS = /bin/mkdir -p
INSTALL = /usr/bin/install
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp
TOUCH = exit >

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir) -Wl,-R$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED)  -lpthread -ldl -lcrypt -lm   -lc
ORIG_SRCS = symbol.c STEMMER_stem_UTF_8_turkish.c STEMMER_stem_UTF_8_dutch.c similarity.c q_filtered_query.c array.c q_span.c hashset.c STEMMER_api.c STEMMER_stem_UTF_8_finnish.c STEMMER_stem_ISO_8859_2_romanian.c STEMMER_stem_UTF_8_danish.c STEMMER_stem_ISO_8859_1_english.c STEMMER_stem_ISO_8859_1_finnish.c ferret.c STEMMER_stem_UTF_8_spanish.c document.c term_vectors.c filter.c field_index.c index.c q_boolean.c q_const_score.c STEMMER_stem_UTF_8_german.c analysis.c r_index.c STEMMER_stem_UTF_8_russian.c STEMMER_stem_UTF_8_hungarian.c STEMMER_stem_UTF_8_swedish.c q_prefix.c STEMMER_stem_ISO_8859_1_dutch.c stopwords.c helper.c posh.c STEMMER_stem_ISO_8859_1_portuguese.c store.c hash.c STEMMER_libstemmer.c q_range.c q_match_all.c r_store.c STEMMER_stem_UTF_8_romanian.c STEMMER_stem_ISO_8859_1_porter.c r_analysis.c q_multi_term.c STEMMER_utilities.c lang.c STEMMER_stem_ISO_8859_1_norwegian.c BZLIB_huffman.c q_term.c r_utils.c BZLIB_blocksort.c scanner_mb.c STEMMER_stem_ISO_8859_1_spanish.c STEMMER_stem_UTF_8_norwegian.c STEMMER_stem_ISO_8859_1_french.c sort.c BZLIB_decompress.c BZLIB_randtable.c BZLIB_crctable.c scanner_utf8.c q_phrase.c scanner.c q_wildcard.c STEMMER_stem_KOI8_R_russian.c BZLIB_compress.c STEMMER_stem_ISO_8859_1_danish.c multimapper.c STEMMER_stem_ISO_8859_1_italian.c STEMMER_stem_ISO_8859_1_hungarian.c q_fuzzy.c mempool.c STEMMER_stem_UTF_8_french.c fs_store.c STEMMER_stem_ISO_8859_1_swedish.c r_search.c r_qparser.c STEMMER_stem_UTF_8_portuguese.c priorityqueue.c bitvector.c STEMMER_stem_UTF_8_porter.c except.c STEMMER_stem_ISO_8859_1_german.c q_parser.c STEMMER_stem_UTF_8_italian.c global.c search.c BZLIB_bzlib.c STEMMER_stem_UTF_8_english.c ram_store.c compound_io.c
SRCS = $(ORIG_SRCS) 
OBJS = symbol.o STEMMER_stem_UTF_8_turkish.o STEMMER_stem_UTF_8_dutch.o similarity.o q_filtered_query.o array.o q_span.o hashset.o STEMMER_api.o STEMMER_stem_UTF_8_finnish.o STEMMER_stem_ISO_8859_2_romanian.o STEMMER_stem_UTF_8_danish.o STEMMER_stem_ISO_8859_1_english.o STEMMER_stem_ISO_8859_1_finnish.o ferret.o STEMMER_stem_UTF_8_spanish.o document.o term_vectors.o filter.o field_index.o index.o q_boolean.o q_const_score.o STEMMER_stem_UTF_8_german.o analysis.o r_index.o STEMMER_stem_UTF_8_russian.o STEMMER_stem_UTF_8_hungarian.o STEMMER_stem_UTF_8_swedish.o q_prefix.o STEMMER_stem_ISO_8859_1_dutch.o stopwords.o helper.o posh.o STEMMER_stem_ISO_8859_1_portuguese.o store.o hash.o STEMMER_libstemmer.o q_range.o q_match_all.o r_store.o STEMMER_stem_UTF_8_romanian.o STEMMER_stem_ISO_8859_1_porter.o r_analysis.o q_multi_term.o STEMMER_utilities.o lang.o STEMMER_stem_ISO_8859_1_norwegian.o BZLIB_huffman.o q_term.o r_utils.o BZLIB_blocksort.o scanner_mb.o STEMMER_stem_ISO_8859_1_spanish.o STEMMER_stem_UTF_8_norwegian.o STEMMER_stem_ISO_8859_1_french.o sort.o BZLIB_decompress.o BZLIB_randtable.o BZLIB_crctable.o scanner_utf8.o q_phrase.o scanner.o q_wildcard.o STEMMER_stem_KOI8_R_russian.o BZLIB_compress.o STEMMER_stem_ISO_8859_1_danish.o multimapper.o STEMMER_stem_ISO_8859_1_italian.o STEMMER_stem_ISO_8859_1_hungarian.o q_fuzzy.o mempool.o STEMMER_stem_UTF_8_french.o fs_store.o STEMMER_stem_ISO_8859_1_swedish.o r_search.o r_qparser.o STEMMER_stem_UTF_8_portuguese.o priorityqueue.o bitvector.o STEMMER_stem_UTF_8_porter.o except.o STEMMER_stem_ISO_8859_1_german.o q_parser.o STEMMER_stem_UTF_8_italian.o global.o search.o BZLIB_bzlib.o STEMMER_stem_UTF_8_english.o ram_store.o compound_io.o
HDRS = $(srcdir)/stem_KOI8_R_russian.h $(srcdir)/similarity.h $(srcdir)/document.h $(srcdir)/posh.h $(srcdir)/lang.h $(srcdir)/stem_UTF_8_dutch.h $(srcdir)/stem_UTF_8_romanian.h $(srcdir)/hash.h $(srcdir)/header.h $(srcdir)/array.h $(srcdir)/stem_ISO_8859_1_german.h $(srcdir)/bitvector.h $(srcdir)/ferret.h $(srcdir)/symbol.h $(srcdir)/stem_ISO_8859_1_french.h $(srcdir)/stem_UTF_8_russian.h $(srcdir)/stem_UTF_8_norwegian.h $(srcdir)/api.h $(srcdir)/stem_UTF_8_italian.h $(srcdir)/stem_ISO_8859_1_english.h $(srcdir)/stem_UTF_8_swedish.h $(srcdir)/index.h $(srcdir)/stem_ISO_8859_1_hungarian.h $(srcdir)/stem_ISO_8859_1_porter.h $(srcdir)/threading.h $(srcdir)/stem_ISO_8859_1_swedish.h $(srcdir)/stem_ISO_8859_1_italian.h $(srcdir)/bzlib_private.h $(srcdir)/stem_UTF_8_danish.h $(srcdir)/stem_UTF_8_finnish.h $(srcdir)/analysis.h $(srcdir)/stem_ISO_8859_1_spanish.h $(srcdir)/helper.h $(srcdir)/field_index.h $(srcdir)/stem_UTF_8_turkish.h $(srcdir)/stem_ISO_8859_1_danish.h $(srcdir)/stem_UTF_8_french.h $(srcdir)/stem_ISO_8859_1_finnish.h $(srcdir)/internal.h $(srcdir)/except.h $(srcdir)/stem_UTF_8_hungarian.h $(srcdir)/stem_UTF_8_german.h $(srcdir)/stem_ISO_8859_2_romanian.h $(srcdir)/libstemmer.h $(srcdir)/global.h $(srcdir)/multimapper.h $(srcdir)/modules.h $(srcdir)/stem_ISO_8859_1_dutch.h $(srcdir)/mempool.h $(srcdir)/scanner.h $(srcdir)/priorityqueue.h $(srcdir)/stem_UTF_8_spanish.h $(srcdir)/stem_ISO_8859_1_norwegian.h $(srcdir)/stem_UTF_8_porter.h $(srcdir)/config.h $(srcdir)/win32.h $(srcdir)/stem_UTF_8_portuguese.h $(srcdir)/search.h $(srcdir)/store.h $(srcdir)/hashset.h $(srcdir)/stem_UTF_8_english.h $(srcdir)/stem_ISO_8859_1_portuguese.h $(srcdir)/bzlib.h
TARGET = ferret_ext
TARGET_NAME = ferret_ext
TARGET_ENTRY = Init_$(TARGET_NAME)
DLLIB = $(TARGET).so
EXTSTATIC = 
STATIC_LIB = 

TIMESTAMP_DIR = .
BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)
HDRDIR        = $(rubyhdrdir)/ruby$(target_prefix)
ARCHHDRDIR    = $(rubyhdrdir)/$(arch)/ruby$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).so 
CLEANOBJS     = *.o  *.bak

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-static clean-rb

clean-static::
clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-static clean-rb-default clean-rb
		-$(Q)$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES) .*.time

distclean-rb-default::
distclean-rb::
distclean-so::
distclean-static::
distclean: clean distclean-so distclean-static distclean-rb-default distclean-rb
		-$(Q)$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		-$(Q)$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		-$(Q)$(RMDIRS) $(DISTCLEANDIRS) 2> /dev/null || true

realclean: distclean
install: install-so install-rb

install-so: $(DLLIB) $(TIMESTAMP_DIR)/.RUBYARCHDIR.time
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
clean-static::
	-$(Q)$(RM) $(STATIC_LIB)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
pre-install-rb-default:
	@$(NULLCMD)
$(TIMESTAMP_DIR)/.RUBYARCHDIR.time:
	$(Q) $(MAKEDIRS) $(@D) $(RUBYARCHDIR)
	$(Q) $(TOUCH) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .mm .cxx .cpp .o .S

.cc.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cc.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $<

.mm.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.mm.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $<

.cxx.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cxx.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $<

.cpp.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cpp.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $<

.c.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

.c.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $<

.m.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

.m.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $<

$(DLLIB): $(OBJS) Makefile
	$(ECHO) linking shared-object $(DLLIB)
	-$(Q)$(RM) $(@)
	$(Q) $(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



$(OBJS): $(HDRS) $(ruby_headers)

# FreeBSD Port Tools
#
# Makefile
# 
# $Id: Makefile,v 1.24 2009/09/09 19:58:30 skolobov Exp $
# 

# Package name and version
PORTNAME?=	porttools
PORTVERSION?=	1.01
DISTNAME?=	${PORTNAME}-${PORTVERSION}
VERSIONSTRING=	${PORTVERSION}

PROGRAM=	scripts/port
SCRIPTS=	scripts/cmd_commit scripts/cmd_create scripts/cmd_diff \
		scripts/cmd_fetch scripts/cmd_followup scripts/cmd_getpr \
		scripts/cmd_help scripts/cmd_install scripts/cmd_submit \
		scripts/cmd_test scripts/cmd_upgrade scripts/util_diff
IN_FILES=	${SCRIPTS} ${PROGRAM}
INC_HEADER=	scripts/inc_header
DOCS=		LICENSE NEWS README THANKS
MAN1=		man/port.1
MAN5=		man/porttools.5

# Normally provided via bsd.port.mk infrastructure
PREFIX?=	~/pkg
DATADIR?=	${PREFIX}/share/${PORTNAME}
DOCSDIR?=	${PREFIX}/share/doc/${PORTNAME}
MANPREFIX?= ${PREFIX}

BSD_INSTALL_SCRIPT?=	install -m 555
BSD_INSTALL_DATA?=	install -m 444
BSD_INSTALL_MAN?=	install -m 444

# Targets
all: ${IN_FILES}

#This is run explicitly from port makefile due to i386 "issues"
${INC_HEADER}: ${INC_HEADER}.in
	@echo "Creating header include file..."
	@cp scripts/inc_header.in scripts/inc_header
	@sed -e 's/^/# /' LICENSE >> scripts/inc_header

.SUFFIXES: .in

.in: ${INC_HEADER}
	@echo "Creating ${.TARGET}..."
	@sed -e 's%__VERSION__%${VERSIONSTRING}%;s,__PREFIX__,${PREFIX},' \
		${INC_HEADER} ${.IMPSRC} > ${.TARGET}
	@chmod a+x ${.TARGET}

install: ${IN_FILES}
	${BSD_INSTALL_SCRIPT} ${PROGRAM} ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${DATADIR}
	${BSD_INSTALL_SCRIPT} ${SCRIPTS} ${DESTDIR}${DATADIR}
	mkdir -p ${DESTDIR}${MANPREFIX}/man/man1
	${BSD_INSTALL_MAN} ${MAN1} ${DESTDIR}${MANPREFIX}/man/man1
	mkdir -p ${DESTDIR}${MANPREFIX}/man/man5
	${BSD_INSTALL_MAN} ${MAN5} ${DESTDIR}${MANPREFIX}/man/man5

install-docs:
	mkdir -p ${DESTDIR}${DOCSDIR}
	${BSD_INSTALL_DATA} ${DOCS} ${DESTDIR}${DOCSDIR}

clean:
	rm -rf ${PROGRAM} ${SCRIPTS} scripts/inc_header

TODO: .todo Makefile
	devtodo --filter -done,+children --TODO

.PHONY: all install install-docs clean TODO

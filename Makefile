ifeq ($(origin JAVA_HOME), undefined)
  JAVA_HOME=/usr
endif

ifeq ($(origin NETLOGO), undefined)
  NETLOGO=../..
endif

ifneq (,$(findstring CYGWIN,$(shell uname -s)))
  COLON=\;
  JAVA_HOME := `cygpath -up "$(JAVA_HOME)"`
else
  COLON=:
endif

JAVAC:=$(JAVA_HOME)/bin/javac
SRCS=$(wildcard src/*.java)

array.jar: $(SRCS) manifest.txt Makefile
	mkdir -p classes
	$(JAVAC) -g -deprecation -Xlint:all -Xlint:-serial -Xlint:-path -encoding us-ascii -source 1.5 -target 1.5 -classpath $(NETLOGO)/NetLogoLite.jar -d classes $(SRCS)
	jar cmf manifest.txt array.jar -C classes .

array.zip: array.jar
	rm -rf array
	mkdir array
	cp -rp array.jar README.md Makefile src manifest.txt array
	zip -rv array.zip array
	rm -rf array

pdf:
	R CMD Rd2pdf .

check:
	R CMD check .

build:
	R CMD INSTALL --no-multiarch --with-keep.source .

default: build

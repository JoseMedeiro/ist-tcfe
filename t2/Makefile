# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	make -C Enunciado
	make -C mat
	make -C sim
	make -C doc
	cp doc/report.pdf .
math:
	make -C mat
	make -C sim
	make -C doc
	cp doc/report.pdf .
	
clean:
	make -C Enunciado clean
	make -C mat clean
	make -C sim clean
	make -C doc clean
	
clean_math:
	make -C mat clean_math
	make -C sim clean_math
	make -C doc clean
	
.PHONY: all math clean clean_math



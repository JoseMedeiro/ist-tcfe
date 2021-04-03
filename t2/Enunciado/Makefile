# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all: data.log
	$(eval PYDATA=$(shell grep _DATA $< | sed 's/_DATA//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(PYDATA), sed -n '/^$i_DATA/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_DATA | grep -v $i_END | grep -v '#'  > $i.txt;)	
	cp *.txt ../mat/
	cp *.txt ../sim/
	mv data.log ./postdata.log

data.log:
	@echo "Please enter the lowest student number in your group:"
	@python t2_datagen.py > $@
	
clean:
	@rm -f *.txt *.log

.PHONY: data clean



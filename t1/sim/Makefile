all: ngspice.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)


ngspice.log: ../sim/t1.net
	ngspice -b $< -o $@

clean:
	@rm -f ngspice.log *.tex *.pdf *.ps *~

.PHONY: all clean

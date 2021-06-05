all: NorNgspice_normal.log NorNgspice_output.log
	mv PreNgspice_normal.log PosNgspice_normal.log
	mv PreNgspice_output.log PosNgspice_output.log
	rm -f NorNgspice_normal.log
	rm -f NorNgspice_output.log
	
PreNgspice_normal.log: t5.net
	ngspice -b $< -o $@

NorNgspice_normal.log: PreNgspice_normal.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/\,/\ + j*/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)


PreNgspice_output.log: t5_Output.net
	ngspice -b $< -o $@

NorNgspice_output.log: PreNgspice_output.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/\,/\ + j*/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	
		
clean:
	@rm -f *.log *.tex *.pdf *.ps *~

.PHONY: clean

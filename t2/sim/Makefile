all: ngspicePasso1.log  ngspicePasso2.log ngspicePasso3.log ngspicePasso4.log ngspicePasso5.log
	mv ngspicePrePasso1.log ngspicePosPasso1.log
	mv ngspicePrePasso2.log ngspicePosPasso2.log
	mv ngspicePrePasso3.log ngspicePosPasso3.log
	mv ngspicePrePasso4.log ngspicePosPasso4.log
	mv ngspicePrePasso5.log ngspicePosPasso5.log


#	Vai fazer o import do ficheiro data.txt
top1_t2_cir.log: DataImporter.m data.txt
	octave $< > $@

#
#	PASSO1
#

ngspicePrePasso1.log: top1_t2.net top1_t2_cir.log
	ngspice -b $< -o $@
	
ngspicePasso1.log: ngspicePrePasso1.log	
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' > $i_data.txt;)

#
#	PASSO2
#

top2_t2_cir.log: DataFrom1to2.m ngspicePasso1.log
	octave $< > $@

ngspicePrePasso2.log: top2_t2.net top2_t2_cir.log
	ngspice -b $< -o $@
	
ngspicePasso2.log: ngspicePrePasso2.log	
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' > $i_data.txt;)

#
#	PASSO3
#

top3_t2_cir.log: DataFrom2to3.m ngspicePasso2.log
	octave $< > $@

ngspicePrePasso3.log: top3_t2.net top3_t2_cir.log
	ngspice -b $< -o $@
	
ngspicePasso3.log: ngspicePrePasso3.log	
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

#
#	PASSO4
#

top4_t2_cir.log: DataFrom2to4.m ngspicePasso2.log
	octave $< > $@

ngspicePrePasso4.log: top4_t2.net top4_t2_cir.log
	ngspice -b $< -o $@
	
ngspicePasso4.log: ngspicePrePasso4.log	
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

#
#	PASSO5
#

top5_t2_cir.log: DataFrom2to5.m ngspicePasso2.log
	octave $< > $@

ngspicePrePasso5.log: top5_t2.net top5_t2_cir.log
	ngspice -b $< -o $@
	
ngspicePasso5.log: ngspicePrePasso5.log	
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	

#
#	Higienização
#

clean:
	make clean_math
	@rm -f *.txt
	
	
clean_math:
	@rm -f *.log *.tex *.pdf *.ps *~ *.cir P*.txt ngspice.log

.PHONY: clean clean_math

all:  octave.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	

octave.log: Audio_Amplifier.m
	octave $< > $@
	
#	Higienização
clean:
	@rm -f octave-workspace *.log *.tex *.eps

.PHONY: clean

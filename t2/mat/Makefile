all:  octaveNos.log


#	Corre o ficheiro Nos.m e analisa o log do ficheiro
preOctaveNos.log: Nos.m DataImport.log
	octave $< > $@

octaveNos.log: preOctaveNos.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)	
	mv preOctaveNos.log octaveNos.log
	
#	Vai fazer o import do ficheiro data.txt
DataImport.log: DataImporter.m data.txt
	octave $< > $@
	
#	Higienização
clean:
	make clean_math
	make clean_data

clean_math:
	@rm -f octave-workspace o*.log p*.log  *.tex *.eps *.mat
	
clean_data:
	@rm -f DataImport.log *.mat *.txt

.PHONY: clean_math clean_data clean

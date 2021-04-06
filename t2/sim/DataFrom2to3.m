#Abre o ficheiro dos resultados anteriores
fid = fopen("PASSO2_data.txt", "r");
DATA2 = textscan(fid, "%s = %f");
fclose(fid);
fid = fopen("data.txt", "r");
# Abre o ficheiro das condições iniciais
DATA = textscan(fid, "%*s = %f");
DATA = cell2mat(DATA)
fclose(fid);
DATAN2 = cell2mat(DATA2(1, 2))
DATAS2 = cell2mat(DATA2(1, 1))

c = 1;
while !strcmp(DATAS2(c, 1),"v(6)")
  c = c+1;
endwhile 
v6 = DATAN2(c)

c = 1;
while !strcmp(DATAS2(c, 1),"v(8)")
  c = c+1;
endwhile 
v8 = DATAN2(c)

circuito = fopen("top3_t2.cir", "w");

# Resistors 
fprintf(circuito, "R1 1 2 %.11fk \n", DATA(1))
fprintf(circuito, "R2 2 3 %.11fk \n", DATA(2))
fprintf(circuito, "R3 2 5 %.11fk \n", DATA(3))
fprintf(circuito, "R4 4 5 %.11fk \n", DATA(4))
fprintf(circuito, "R5 5 6 %.11fk \n", DATA(5))
fprintf(circuito, "R6 0 7 %.11fk \n", DATA(6))
fprintf(circuito, "R7 7 8 %.11fk \n\n", DATA(7))
# Indepent Power Source
fprintf(circuito, "VS 1 4 0       \n"          )
fprintf(circuito, "C1 6 8 %.11fu  \n\n", DATA(9))
# Linear dep. source
fprintf(circuito, "Gb 6 3 (2,5) %.11fm \n", DATA(10))
fprintf(circuito, "Hd 5 8 V3 %.11fk \n\n",  DATA(11))
# Test current
fprintf(circuito, "V3 4 0 0\n\n");
# Initial Conditions
fprintf(circuito, ".IC v(6)=%.11f v(8)=%.11f\n", v6, v8);



fclose(circuito);
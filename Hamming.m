                                            %% Código Hamming            %%
                                            %%Realizado por: ing. Andres Felipe Pelaez%%
                                            %%Faculta de ing. electr�nica%%
                                            %%Universidad del Quind�o    %%
%% 
clear;
m=input('ingrese un caracter: ','s');
i=length(m);%lo largo de la cadena
x=double(m);%transforma la cadena en numeros del codigo ascII
x=dec2bin(x,8);%transforma los numeros en un vector de caracteres en binario
for c=1:8
    y(c)=str2num(x(c));%llena una matriz con cada bit de la cadena, lo vuelve de 8 bits cada caracter
end %llena el vector sin codificar
%% paridades
%suma para la paridad 1
j=1;
sp=y(1)+y(2)+y(4)+y(5)+y(7);
if rem(sp,2)==0
    p(1)=0;
else
    p(1)=1;
end
%suma para la paridad 2
sp=y(1)+y(3)+y(4)+y(6)+y(7);
if rem(sp,2)==0
    p(2)=0;
else
    p(2)=1;
end
%suma para la paridad 3
sp=y(2)+y(3)+y(4)+y(8);
if rem(sp,2)==0
    p(3)=0;
else
    p(3)=1;
end
%suma para la paridad 4
sp=0;
for c=1:4
    sp=y(c+4)+sp;
end
if rem(sp,2)==0
    p(4)=0;
else
    p(4)=1;
end
%% codificaci�n
j=1;
k=1;
pot2=[1,2,4,8];
for c=1:12
    if   j<5 && c==pot2(j)
      cod(c)=p(j);
      j=j+1;
    else
        cod(c)=y(k);
        k=k+1;
    end
end
%% simulacion del canal
canal=cod;
%r=randi(12);
 r=7;
if canal(r)==1
    canal(r)=0;
else
    canal(r)=1;
end
%% decodificaci�n
%para la paridad 1
j=1;
sp=0;
k=1;
for c=1:6
    sp=canal(j)+sp;
    j=j+2;
end
if rem(sp,2)==0
    erro(k)=0;
    k=k+1;
else
    erro(k)=1;
    k=k+1;
end
%para la paridad 2
sp=canal(2)+canal(3)+canal(6)+canal(7)+canal(10)+canal(11);
if rem(sp,2)==0
    erro(k)=0;
    k=k+1;
else
    erro(k)=1;
    k=k+1;
end
%para la paridad 3
sp=canal(4)+canal(5)+canal(6)+canal(7)+canal(12);
if rem(sp,2)==0
    erro(k)=0;
    k=k+1;
else
    erro(k)=1;
    k=k+1;
end
%para la parida 4
sp=0;
for c=1:5
    sp=sp+canal(c+7);
end
if rem(sp,2)==0
    erro(k)=0;
    k=k+1;
else
    erro(k)=1;
    k=k+1;
end
cant_er=sum(erro);
j=0;
deco=canal;
l=1;
for c=1:4
    if erro(c)==1
        if j==0
            primer_er=c;
            j=1;
        end
        suma_er(l)=c;
        l=l+1;
    end
end
suma_er=sum(suma_er);
switch cant_er
    case 2
        switch primer_er
            case 1
                switch suma_er
                    case 3
                        if deco(3)==0
                            deco(3)=1;
                        else
                            deco(3)=0;
                        end
                    case 4
                        if deco(5)==0
                            deco(5)=1;
                        else
                            deco(5)=0;
                        end
                    case 5
                        if deco(9)==0
                            deco(9)=1;
                        else
                            deco(9)=0;
                        end
                end
            case 2
                switch suma_er
                    case 5
                        if deco(6)==0
                            deco(6)=1;
                        else
                            deco(6)=0;
                        end
                    case 6
                        if deco(10)==0
                            deco(10)=1;
                        else
                            deco(10)=0;
                        end
                end
            case 3
                if deco(12)==0
                    deco(12)=1;
                else
                    deco(12)=0;
                end
        end
    case 3
        switch suma_er
            case 6
                if deco(7)==0
                    deco(7)=1;
                else
                    deco(7)=0;
                end
            case 7
                if deco(11)==0
                    deco(11)=1;
                else
                    deco(11)=0;
                end
        end
    otherwise
        switch primer_er
            case 1
                if deco(1)==0
                    deco(1)=1;
                else
                    deco(1)=0;
                end
            case 2
                if deco(2)==0
                    deco(2)=1;
                else
                    deco(2)=0;
                end
            case 3
                if deco(4)==0
                    deco(4)=1;
                else
                    deco(4)=0;
                end
            case 4
                if deco(8)==0
                    deco(8)=1;
                else
                    deco(8)=0;
                end
        end
end
%% mensaje ya decodificado y solucionado los errores del canal
j=1;
for c=1:12
    if c==1 || c==2 || c==4 || c==8
    
    else
        mens(j)=deco(c);
        j=j+1;
    end
end
mens=dec2mvl(mens);
mens=transpose(mens);%se transpone y guarda la cadena en la variable mens
mens=bin2dec(mens);%teniendo en decimal la matriz se puede realizar la conversi�n de bin a dec
mens=char(mens);
disp(mens);

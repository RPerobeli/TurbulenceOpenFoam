function sinal
clear all
close all
clc

%pkg load signal;
desloc=load('coefficient_0.dat','-ascii'); 

[npontos, tam2] = size(desloc);

   
k =1;

  ttrans=3;       
%fprintf ('Intervalo de tempo da resposta =');
%dint = input ('Intervalo de tempo da resposta =');
dint=.01;
icont    = 0;
deltat   = 0;
ds       = 0;

coef =2;                                      
%desloc(:,coef)=desloc(:,coef)*k;
for i=1:npontos;
    deltata = deltat;
    dxa = desloc(i,coef);
    deltat=desloc(i,1);
    while (icont*dint + dint) < deltat
        if deltat == (icont + 1)*dint
            icont = icont + 1;
            saida=[icont*dint desloc(i,coef)];
            bfil(icont,1)=saida(1,1);
            bfil(icont,2)=saida(1,2);
        else
            if deltat > (icont + 1)*dint
                icont = icont + 1;
                dix = (dint*icont - deltata)*...
                    (desloc(i,coef) - dxa)/(deltat - deltata)+ dxa;
                saida= [icont*dint dix];
                bfil(icont,1)=saida(1,1);
                bfil(icont,2)=saida(1,2);

            end
        end
    end

end
t=bfil(:,1);
b=bfil(:,2);
plot(t,b); 
  ans=size(bfil);
  np=ans(1);
  icont=0;
                             
  for i=1:np;
      if bfil(i,1) <= ttrans;
          icont=icont+1;
      end
  end
  bfil2(:,1)=bfil(icont:np,1)-ttrans;
  media=mean(bfil(icont:np,2));
  bfil2(:,2)=bfil(icont:np,2)-media;
  media=media*k
    n=length(bfil2(:,2));
  rms=norm(bfil2(:,2))*k/sqrt(n)

 % save p1.dat bfil2 -ascii

%Figure(1);
Fs=1/dint;

t=bfil2(:,1);

xx=bfil2(:,2);


%Figure(2);
% i=682*2*2;
% window=i;
% figure
% [Pxx,f] =pwelch(xx,window,.5,[],Fs,'onesided');
% 
% plot(f,Pxx)
%  espec=[f Pxx];
%  save cl.esp espec -ascii
%  amp=max(Pxx)*1.2;  
%  axis([0 1 0 amp]);


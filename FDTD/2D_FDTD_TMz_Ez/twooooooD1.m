clc
clear
c0=3*10^8;
f=10*10^9;
ke=100;
e0=8.81*10^-12;
er=4
ed=er*e0
pmb=4*pi*10.e-7;
sikma=1
ud=c0/sqrt(er)
landa_d=ud/f
d=landa_d/20
dt=d/(2*c0);
R=d/2*e0
Ra=(c0*dt/d)^2
Rb=dt/pmb*d
Ca=(1-R*sikma*er)/(1+R*sikma*er)
Caa=(1-R*sikma)/(1+R*sikma)
Cb=Ra/er+R*sikma
Cbb=Ra/1+R*sikma
Ez=zeros(ke+1,ke+1);
Hy=zeros(ke+1,ke+1);
Hx=zeros(ke+1,ke+1);
Ezz=Rb*Ez;
middle=ke/2;
nstep=500;
t0=20;
spread=8;
 M=moviein(nstep);
 X=zeros(nstep,nstep,nstep);
  for t=1:nstep
 for j=2:ke
     for i=2:ke
         if ((i-25)^2+(j-25)^2)<=20
          Ezz(j,i)=Ca*Ezz(j,i)+Cb*(Hy(j,i+1)-Hy(j,i-1)-Hx(j+1,i)+Hx(j-1,i)); 
         end
         Ezz(j,i)=Caa*Ezz(j,i)+Cbb*(Hy(j,i+1)-Hy(j,i-1)-Hx(j+1,i)+Hx(j-1,i));
      Ezz(middle,middle)=1000*sin(2*pi*f*(t-1)*dt);
     %truncation or boundry condition on Ezz
      if t>=3   
      Ezz(:,1)=X(1:ke+1,t-2,1);
          Ezz(:,ke+1)=X(1:ke+1,t-2,2);
            end
      X(1:ke+1,t,1)=Ezz(:,2);
      X(1:ke+1,t,2)=Ezz(:,ke);
     end
 end
 for i=1:ke+1
     for j=2:ke
       Hx(j,i)=Hx(j,i)-(Ezz(j+1,i)-Ezz(j-1,i));
    %truncation or boundry condition on Hx
       if t>=3
     Hx(1,i)=1/3*X(i,t-2,5);
     Hx(ke+1,i)=1/3*X(i,t-2,6);
               end
 X(i,t,5)=Hx(2,i);
 X(i,t,6)=Hx(ke,i);
     
     
     end
 end
       for j=1:ke+1
           for i=2:ke
               Hy(j,i)=Hy(j,i)+(Ezz(j,i+1)-Ezz(j,i-1));
              %truncation or boundry condition on Hy
               if t>=3
     Hy(1,i)=1/3*X(i,t-2,3);
     Hy(ke+1,i)=1/3*X(i,t-2,4);
               end
 X(i,t,3)=Hy(2,i);
 X(i,t,4)=Hy(i,ke-1);
     end
       end
  mesh(Ezz);
%pcolor(Ezz)
colorbar
%plot(Ezz(5,:))
drawnow;
M(:,t) =getframe ;
 end
   movie(M,1);
         
        
         

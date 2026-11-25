clc
clear
c0=3*10^8;
f=2.5*10^9;
ke=50;
e0=8.81*10^-12;
pmb=4*pi*10.e9;
sikma=1
landa_d=c0/f
d=landa_d/20
dt=d/(2*c0)
cc=c0*dt/d
Ex=zeros(1,ke+1);
Hy=zeros(1,ke+1);
middle=ke/2
n=500
 M=moviein(n);
 %t0=20;
%spread=8;
X=zeros(n,2);
 %harkate yek bodi da rastaye y
for t=1:n
    for j=2:ke-1 
        Ex(j)=Ex(j)+cc*(Hy(j-1)-Hy(j));
        %truncation or boundry condition on Ex
      if t>=3
            Ex(1)=X(t-2,1);
            Ex(ke)=X(t-2,2);
           
           end
       X(t,1)=Ex(2);
       X(t,2)=Ex(ke-1);
       
    end
            Ex(middle)=sin(2*pi*f*(t-1)*dt);
    for j=1:ke
    Hy(j)=Hy(j)+cc*(Ex(j)-Ex(j+1));
    %truncation or boundry condition on Hy
    if t>=3
         Hy(ke)=X(t-2,3);
     end
     X(t,3)=Hy(ke-1);
    end
subplot(2,1,1)     
plot(Ex);axis([1 ke -3 3]);
subplot(2,1,2) 
plot(Hy);axis([1 ke -3 3]);
M(:,t) =getframe ;

end   
   movie(M,1);
   
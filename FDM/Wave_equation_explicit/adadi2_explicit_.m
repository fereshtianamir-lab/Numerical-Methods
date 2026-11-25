clc
clear
dx=.1
x=0:dx:1
r=1
u=1
dt=(dx/u)*sqrt(r)
n_t=round(1/dt)%number of time unit
n_x=max(size(x))  %number of x unit
phi_Explicit=zeros(n_t,n_x)
phi_Explicit(1,1:end)=sin(pi.*x)
for  j=2:n_t;
   % l(j)=(j*dt)
    %t=l'
    i=2:n_x-1;
   if j==2 
 phi_Explicit(j,i)=1/2*(phi_Explicit(j-1,i-1)+phi_Explicit(j-1,i+1));
else
    phi_Explicit(j,i)=(phi_Explicit(j-1,i-1)+phi_Explicit(j-1,i+1)-phi_Explicit(j-2,i))

     end
end


clc
clear
c0=3*10^8;
f=10*10^9;
ke=200;
e0=8.81*10^-12;
er=4;
ed=er*e0;
mu0=4*pi*1e-7;
epsilon0=(1/(36*pi))*1e-9;
sikma=1;
ud=c0/sqrt(er);
landa_d=ud/f;
delta=landa_d/20;
deltat=delta/(2*c0);
R=delta/2*e0;
Ra=(c0*deltat/delta)^2;
Rb=deltat/mu0*delta;
Ca=(1-R*sikma*er)/(1+R*sikma*er);
Caa=(1-R*sikma)/(1+R*sikma);
Cb=Ra/er+R*sikma;
Cbb=Ra/1+R*sikma;
Ez=zeros(ke+1,ke+1);
Hy=zeros(ke+1,ke+1);
Hx=zeros(ke+1,ke+1);
Ezz=Rb*Ez;
middle=ke/2;
nstep=200;
t0=20;
spread=8;
sigma=zeros(ke+1,ke+1);
sigma1=zeros(ke+1,ke+1);
sigma2=zeros(ke+1,ke+1);
sigma3=zeros(ke+1,ke+1);
x=ones(ke+1,1);
 M=moviein(nstep);
 epsilon=epsilon0*ones(ke+1,ke+1);
mu=mu0*ones(ke+1,ke+1);
 %Value of boundary width in spacesteps
bound_width=20;
%Electrical conductivity vector initialization
sigma=zeros(ke+1,ke+1);
%Order of polynomial on which sigma is modeled
gradingorder=6;
%Required reflection co-efficient
refl_coeff=1e-6;
%Polynomial model for sigma
sigmamax=(-log10(refl_coeff)*(gradingorder+1)*epsilon0*c0)/(2*bound_width*delta);
boundfact1=((epsilon(:,bound_width)/epsilon0)*sigmamax)/((bound_width^gradingorder)*(gradingorder+1));
boundfact2=((epsilon(:,ke+1-bound_width)/epsilon0)*sigmamax)/((bound_width^gradingorder)*(gradingorder+1));
z=0:1:bound_width;
xx=kron(x,z);
y=ones(ke+1,bound_width+1);
y(:,1)=0;
%tashkil matris sigma
sigma(bound_width+1:-1:1,:)=1e03*(boundfact1(1).*((xx'+0.5*ones(bound_width+1,ke+1)).^(gradingorder+1)-(xx'-0.5*y').^(gradingorder+1)));
sigma(ke+1-bound_width:1:ke+1,:)=1e03*(boundfact2(1)*((xx'+0.5*ones(bound_width+1,ke+1)).^(gradingorder+1)-(xx'-0.5*y').^(gradingorder+1)));
sigma1(:,bound_width+1:-1:1)=1e03*(boundfact1(1).*((xx+0.5*ones(ke+1,bound_width+1)).^(gradingorder+1)-(xx-0.5*y).^(gradingorder+1)));
sigma2(:,ke+1-bound_width:1:ke+1)=1e03*(boundfact2(1)*((xx+0.5*ones(ke+1,bound_width+1)).^(gradingorder+1)-(xx-0.5*y).^(gradingorder+1)));
sigma3=sigma+sigma1+sigma2;
sigma_star=(sigma3.*mu)./epsilon;
%zarayebe morede nazar jahate ijad sharte PML
A=((mu-0.5*deltat*sigma_star)./(mu+0.5*deltat*sigma_star)); 
B=(deltat/delta)./(mu+0.5*deltat*sigma_star);                                            
C=((epsilon-0.5*deltat*sigma3)./(epsilon+0.5*deltat*sigma3)) ;
D=(deltat/delta)./(epsilon+0.5*deltat*sigma3);              


 for t=1:nstep
 for j=2:ke
     for i=2:ke
         if ((i-25)^2+(j-25)^2)<=20;
          Ezz(j,i)=Ca*Ezz(j,i)+Cb*(Hy(j,i+1)-Hy(j,i-1)-Hx(j+1,i)+Hx(j-1,i)); 
         end
         Ezz(j,i)=C(j,i).*Ezz(j,i)+D(j,i).*(Hy(j,i+1)-Hy(j,i-1)-Hx(j+1,i)+Hx(j-1,i));
       Ezz(98:end-98,middle)=1000*sin(2*pi*f*(t-1)*deltat);
     end
 end
 for i=1:ke+1
     for j=2:ke
       Hx(j,i)=A(j,i)*Hx(j,i)-B(j,i)*(Ezz(j+1,i)-Ezz(j-1,i));
     end
 end
       for j=1:ke+1
           for i=2:ke
               Hy(j,i)=A(j,i)*Hy(j,i)+B(j,i)*(Ezz(j,i+1)-Ezz(j,i-1));
              
     end
       end
%subplot(2,1,1) 
mesh(Ezz);
%pcolor(Ezz)
colorbar
%subplot(2,1,2)
%plot(Ezz(middle,:),'r')
%xlabel('onedimention movement')
drawnow;
M(:,t) =getframe ;
 end
   movie(M,1);
         


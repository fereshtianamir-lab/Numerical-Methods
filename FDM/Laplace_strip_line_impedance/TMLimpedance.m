clc
clear
a=2.5 %(or:b); 
d=.5;
w=1;
t=0.001;
E0=8.81*10^-12;
E1=E0;
E2=2.35*E0;
h=0.05;
iteration=1000
n1=a/h;
n=n1+2
vd=100;
u=(a-d)/h;
c=3*(10^8);

v=zeros(n,n);
for r=1:2;%tekrare bedone dielectric
for j=2:n;
    i=1:(w/h);
    if j*h==(a-d)
        v(j,i)=vd;
    end
end
%tashkil matris potansiel

for q=1:iteration;
for j=2:n;
 for   i=1:n-3;
    if j<(a/h-d/h) ; 
        if i==1;
        v(j,i)=1/4*(v(j-1,i)+v(j+1,i)+2*v(j,i+1));
    else
        v(j,i)=1/4*(v(j-1,i)+v(j+1,i)+v(j,i+1)+v(j,i-1));
       end
    elseif j==(a/h-d/h);
        o=E1/(2*(E1+E2));
       L=E2/(2*(E1+E2));
        if i>=(w/h)
       v(j,i+1)=o*v(j-1,i)+L*v(j+1,i)+(1/4)*(v(j,i)+v(j,i+3));
       v(j,end)=0;
       v(j,end-1)=0
       v(j,end-2)=0
        end
              
    else j>(a/h-d/h);
        if j~=n;
            if i==1;
        v(j,i)=1/4*(v(j-1,i)+v(j+1,i)+2*v(j,i+1));
            else
                v(j,i)=1/4*(v(j-1,i)+v(j+1,i)+v(j,i+1)+v(j,i-1));
            end
          
        else
             if i==1
        v(j,i)=1/4*(2*v(j-1,i)+2*v(j,i+1));
             else
                 v(j,i)=1/4*(2*v(j-1,i)+v(j,i-1)+v(j,i+1));
            end
        end
    end
 end
end 
if r==1
    figure(1),imagesc(v),colorbar,title('Potential distribution with dielectric');
drawnow;
else
    figure(2),imagesc(v),colorbar,title('Potential distribution without dielectric');
drawnow;
end

%sathe gusi baray bedast avardan bar ruye hadi
p1=round((w+a)/h/2);% tedad nodhaye masire ofoghi sathe gusi
p2=round((a+d)/h/2);%tedad nodhaye masire amudi sathe gusi
s2=0;
for k=1:2;%(k=1)va(k=2):neshan dahande masire dakheli va kharegie sathe gusi betartib mibashand
s0=sum(v(n-p2,2:p1-1)*E1)+(v(n-p2,1)*E1/2);%(n-p2)neshan dahande shoroue matris az bala be pain mibashad
if k==1
    s0=s0+2*v(n-p2,p1)*E1;
end
for j=n-p2:n
 if j<(a/h-d/h)
    s0=s0+(v(j,p1)*E1);
elseif j==(a/h-d/h)
     s0=s0+v(j,p1)*(E1+E2)/2; 
elseif j==n
   s0=s0+(v(j,p1)*E2/2);
else
    s0=s0+(v(j,p1)*E2);
  end
end
if k==1
  s1=s0;
else
  s2=s0;
end
Q=abs(s1-s2)
 p1=p1+1;
 p2=p2+1;
end
if r==1%yani halati ke dielectricha vojud darand
C=4*Q/vd
end
E1=E0;
E2=E0;
C0=4*Q/vd
end
end
disp(C0)
disp(C)
 Z0=1/(c*sqrt(C*C0))
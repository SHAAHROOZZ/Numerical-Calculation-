clc
clear
close all
%% Inputs
x=[0 4.1 14.9 25.4 37.5 48.4 59 69.6 80.3 92.2 103.2 115.3 119.8]';
y=[31.6 22.3 7.1 2 3.54 7.6 10 8.2 4.3 1.8 5.7 21.2 31.1]';
t=[0 1 2 2.5 3 3.5 4 4.5 5 5.5 6 7 8]';
%% Fitting
fitOptions = fitoptions('poly3','Normalize','off', 'Robust', 'Bisquare');
X=fit(t,x,'poly3',fitOptions);
fitOptions = fitoptions('sin3','Normalize','off', 'Robust', 'Bisquare');
Y=fit(t,y,'sin3',fitOptions);
%% Creating Equations
syms T
x_t=X.p1*T^3+X.p2*T^2+X.p3*T+X.p4;
y_t=Y.a1*sin(Y.b1*T+Y.c1)+Y.a2*sin(Y.b2*T+Y.c2)+Y.a3*sin(Y.b3*T+Y.c3);
%% Discreet Equations
dt=0.001;
T=0:dt:max(t); 
x_T=eval(x_t); %calculationg x values
y_T=eval(y_t); %calculationg y values
%% Calculation of v & a
for i=2:length(T)
    vx(i)=(x_T(i)-x_T(i-1))/dt;
    vy(i)=(y_T(i)-y_T(i-1))/dt;
end
v=sqrt(vx.^2+vy.^2);
for i=2:length(T)
    ax(i)=(vx(i)-vx(i-1))/dt;
    ay(i)=(vy(i)-vy(i-1))/dt;
end
a=sqrt(ax.^2+ay.^2);
a(a==max(a))=nan;
%% Plot
dx=5;
X=0:dx:max(x)+dx;
dy=5;
Y=0:dy:max(y)+dy;
plot(x_T,y_T,'b-') % x-y
hold on
plot(x_T,v,'r') % x-v
plot(x_T,a,'k') % x-a
% Set plot options
xlabel('x _(_m_)') % add name to horizontal axis
ax=gca;
ax.XLim=([0,max(x)]); 
legend({'y','v','a'}) % add Legend to plot
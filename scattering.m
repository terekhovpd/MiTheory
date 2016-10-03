clc
clear all;

n = 2; % порядок функции
r = 70e-9; % радиус сферы
I = 1.3e-3; % интенсивность падающего излучения
lambda = 3e-7 : 2e-9 : 8e-7; % длина волны
f = 3e8./lambda; % частота
mu = 1; % магнитная проницаемость среды
mu1 = 1; % магнитная проницаемость шара
N = 1; % показателб преломления среды 
k = 2*pi*N./lambda; % волновой вектор

%{
EPS = dlmread('Si_eps.txt'); % диэлектрическая проницаемость шара
lambdaeps = 3e8 ./ (EPS(:,1) .* 1e12);
Eps = EPS(:,2) + 1i .* EPS(:,3);
eps = spline(lambdaeps,Eps, lambda);
N1 = sqrt( (real(eps) + abs(eps))./2 ); % показатель преломления шара
%}
eps = 16;
N1 = sqrt(eps);

%  An(n,mu,mu1,N,N1,r,lambda);
%  Bn(n,mu,mu1,N,N1,r,lambda);

% сечение рассеяния
Csca = 0;
for i=1:1:n
Csca = Csca + 2*pi./k.^2 .* (2.*i+1) .* ...
    (abs(An(i,mu,mu1,N,N1,r,lambda)).^2 + ...
    abs(Bn(i,mu,mu1,N,N1,r,lambda)).^2);
end

% сечение экстинкции
Cext = 0;
for i=1:1:n
Cext = Cext + 2*pi./k.^2 .* (2.*i+1) .* real(An(i,mu,mu1,N,N1,r,lambda) + Bn(i,mu,mu1,N,N1,r,lambda));
end

% сумма коэффициентов An
an = 0;
for i=1:1:n
an = an + An(i,mu,mu1,N,N1,r,lambda);
end

% сумма коэффициентов Bn
bn = 0;
for i=1:1:n
bn = bn + Bn(i,mu,mu1,N,N1,r,lambda);
end

figure(1);
plot(f,abs(an),f,abs(bn));
    legend('sum an','sum bn');
    xlabel('частота, Гц');

%Сечение рассеяния COMSOL
SCA = dlmread('scat.txt');
Scax = SCA(:,1);
Scay = SCA(:,3) ./ I;

%Поглощение COMSOL
%{
%ABS = dlmread('absCS.txt');
%Absx = ABS(:,1);
%Absy = ABS(:,3) ./ I;
%}

figure(2);
%subplot(2,1,1)
plot(f,Csca, Scax,Scay)
    legend('Юрий','Ксения');
    xlabel('частота, Гц');
    ylabel('Сечение рассеяния');
%{
subplot(2,1,2)
plot(3e8./lambda,Cext, Scax, Scay+Absy)
plot(3e8./lambda,Cext, Scax, Scay)
   legend('Юрий','Ксения');
   xlabel('частота, Гц');
   ylabel('Сечение экстинкции');

figure(3);
plot(f, N1)
xlabel('частота, Гц');
ylabel('коэффициент преломления');

figure(4);
subplot(2,1,1);
plot(lambdaeps,real(Eps),'k', lambdaeps,imag(Eps),'b');
subplot(2,1,2);
plot(lambda, real(eps),'k.', lambda, imag(eps),'b.');
%}
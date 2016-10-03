function [ bn ] = Bn( n, mu, mu1, N, N1, r, lambda)
% n - порядок коэффициента рассеяния
% mu - магнитная проницаемость среды
% mu1 - магнитная проницаемость шара
% N - показатель преломления среды
% N1 - показатель преломления шара
% r - радиус сферы
% lambfa - длина волны излучения

m = N1./N; % относительный показатель преломления
x = 2.*pi.*N.*r./lambda; % параметр дифракции

b1 = mu1 .* sphbes(n,m.*x,'j') .* (sphbes(n,x,'j') + x .* dsphbes(n,x,'j'));
b2 = mu .* sphbes(n,x,'j') .* (sphbes(n,m.*x,'j') + x.*m.*dsphbes(n,m.*x,'j'));
b3 = mu1 .* sphbes(n,m.*x,'j') .* (sphbes(n,x,'h') + x .* dsphbes(n,x,'h'));
b4 = mu .* sphbes(n,x,'h') .* (sphbes(n,m.*x,'j') + x.*m.*dsphbes(n,m.*x,'j'));

bn = (b1-b2)./(b3-b4);

end


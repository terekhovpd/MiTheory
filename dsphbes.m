function bs = dsphbes(n, x, type)
% retuns the derivate of spherical Bessel function

bs = (n.*sphbes(n-1,x,type) - (n+1).*sphbes(n+1,x,type))./(2.*n+1);

end


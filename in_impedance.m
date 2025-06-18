function [Zin,prop_const_m,z] = in_impedance(lambda,l,ZL,alpha_m,eps,Z0,n)

% This function calculates impedance through the line at each
% infinitesimely small unit. Inputs of the function wavelength, length of
% the transmission line, impedance of the load, microwave wavelength,
% infinitesimal length epsilon and characteristic impedance of the line. 
% Outputs of the function is impedance through line, complex propagation 
% constant of the line and length vector of the transmission line. 

% This function only contains microwave parameters.

c = 3e8;

z = 0:eps:l;
freq = c/lambda;

%beta_m = 2*pi/lambda;
beta_m = 2*pi*freq*n/c;
prop_const_m= alpha_m + 1i*beta_m; % gamma=alpha+j*beta
electrical_length = prop_const_m.*z;

Zin = Z0 * (ZL + Z0*tanh(electrical_length))./(Z0 + ZL*tanh(electrical_length));

end
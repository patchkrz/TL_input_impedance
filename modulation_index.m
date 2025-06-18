clc
clear all

% ---
% This code models modulation index formula and analyses three critical
% parameter which has effect on modulation bandwidth:
% 
% 1. Velocity mismatch
% 2. Impedance mismatch at load and generator
% 3. RF losses.
% 
% Abbreviations
% CPW: Coplanar waveguide
% TL: Transmission line
%
% ---

% ---
%c=3e8;
%lambda_m = 10e-2; % Microwave wavelength at 3GHz
%freq_m = c/lambda_m;
freq = 0:10:10e9;
ZL = 50; % Load impedance
Z0 = 50; % Characteristic impedance of TL
ZG = 50; % Generator impedance

l = 3e-2; % length of modulator = CPW length

%eps = 1e-4; % length of infinitesimally small section of TL

alpha_m = 0.00001; % microwave loss parameter

% ---
lambda_o = 1550e-9; % optical wavelength 
n_o_eff = 1.8125;

n_rf = 0.9*n_o_eff;

% function for impedance through the line
[Zin,prop_const_m,z] = in_impedance(lambda_m,l,ZL,alpha_m,eps,Z0,n_rf); 

u_pos = alpha_m*l + 1i*2*pi*freq_m*(n_rf-n_o_eff)*l/c;
u_neg = -alpha_m*l + 1i*2*pi*freq_m*(-n_rf-n_o_eff)*l/c;

Fu_pos = (1-exp(u_pos))/u_pos;
Fu_neg = (1-exp(u_neg))/u_neg;


m  = ((real(ZL)+real(ZG))/(real(ZL))) * abs((Zin)/(Zin+ZG)) ...
    * abs( ((ZL+Z0)*Fu_pos + ((ZL)-(Z0))*Fu_neg )/ ...
    ((ZL+Z0)*exp(alpha_m*l) + (ZL-Z0)*exp(-alpha_m*l)) );

%TODO: Zin has to be one value
%      I have to set it for frequency sweep. Think about the Zin value for
%      frequency sweep case. 



% plot(z,imag(Zin)/Z0)
% ax=gca;
% ax.XLabel.String = 'Electrical Length';
% ax.XLabel.FontSize = 16;
% ax.YLabel.String = '(X_{IN})/Z0';
% ax.YLabel.FontSize = 24;
% ax.FontWeight = 'bold';
% ax.Title.FontSize = 16;
% ax.Title.String = 'Impedance through CPW With Short Circuit Ended';
% ax.Title.FontWeight = 'bold';
% %ax.Linewidth = 2;
% xticks([lambda_m/4 lambda_m/2 3*lambda_m/4 lambda_m])
% xticklabels({'\lambda /4', '\lambda /2', '3\lambda /4', '\lambda'})
% grid on
% xline(lambda_m/4, '--k', 'Alpha', 0.3)       % Vertical dashed line at x=0, semi-transparent
% xline(lambda_m/2, '--k', 'Alpha', 0.3)
% xline(3*lambda_m/4, '--k', 'Alpha', 0.3)
% xline(lambda_m, '--k', 'Alpha', 0.3)
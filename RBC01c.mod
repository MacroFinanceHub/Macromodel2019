%--------------------------------------------------------------------------
% Modelo RBC basico loglinealizado (manualmente)
% La funcion de utilidad corresponde a la forma logaritmica 
% Codigo elaborado por: Carlos Rojas Quiroz
%--------------------------------------------------------------------------


var y c innv g lab kap r w z;
predetermined_variables kap;
varexo e_z e_g;
parameters alpha delta betta theta rho_z rho_g 
z_ss lab_ss r_ss  kap_ss w_ss y_ss c_ss inv_ss g_ss C_Y I_Y G_Y;

alpha  = 0.650;
delta  = 0.025;
betta  = 0.99;
theta  = 1/2.75;
rho_z  = 0.919919;
rho_g  = 0.954402;
z_ss   = 1;
G_Y    = 0.180;
lab_ss = 1/((1-theta)/(alpha*theta*z_ss)*((1-betta+alpha*betta*delta)/(1-betta+betta*delta)-G_Y)+1);
y_ss   = z_ss*(((1-alpha)*betta/(1-betta+betta*delta))^((1-alpha)/alpha))*lab_ss;
w_ss   = alpha*y_ss/lab_ss;
kap_ss = (1-alpha)*betta/(1-betta+betta*delta)*y_ss;
inv_ss = delta*kap_ss;
r_ss   = (1-alpha)*y_ss/kap_ss-delta;
c_ss   = ((1-betta+alpha*betta*delta)/(1-betta+betta*delta)-G_Y)*y_ss;
g_ss   = G_Y*y_ss;
C_Y    = c_ss/y_ss;
I_Y    = inv_ss/y_ss;

model (linear);
w = (lab_ss/(1-lab_ss))*lab + c;
c = c(+1) - (1-betta)*r(+1);
w = y - lab;
r_ss*r = (1-alpha)*y_ss/kap_ss*(y-kap);
y = C_Y*c + I_Y*innv + G_Y*g;
y = z + alpha*lab + (1-alpha)*kap;
kap(+1) = delta*innv + (1-delta)*kap;
z = rho_z*z(-1) + e_z;
g = rho_g*g(-1) + e_g;
end;

shocks;
var e_z; stderr 0.008289*100;
var e_g; stderr 0.003740*100;
end;
 
resid;
steady;
check;

stoch_simul(bandpass_filter=[8 32], nograph);

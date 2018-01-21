clear;
close all;

% Variables

phi=-3;
prob_low=0.1;
prob_high=1-prob_low;
alpha_upper=1;
alpha_lower=0;
w_init=10;
r_f=0.02;
r_high=0.12;
r_low=-0.08;

% Apply fminbnd
fun= @(alpha) (-utility(alpha,phi,prob_low,prob_high,w_init,r_f,r_high,r_low));
alpha_fminbnd = fminbnd(fun,alpha_lower,alpha_upper);

% Apply fmincon
A=[];
b=[];
Aeq=[];
beq=[];
lb=alpha_lower;
ub=alpha_upper;
alpha_fmincon = fmincon(fun,0,A,b,Aeq,beq,lb,ub);

% Plot Utility and Marginal Utility
alpha_v=nan(100,1);
a=nan(100,1);
a_marg=nan(100,1);

for i=1:100
   a(i,1)=utility(i/100,phi,prob_low,prob_high,w_init,r_f,r_high,r_low);
   a_marg(i,1)=marginal_utility(i/100,phi,prob_low,prob_high,w_init,r_f,r_high,r_low);
   alpha_v(i,1)=i/100;
end

figure
subplot(2,1,1); plot(alpha_v,a);
hline=refline((a(100,1)-a(1,1)),a(1,1));
hline.Color = 'r';
xlabel('alpha');
ylabel('utility');
legend('utility','Location','northwest');
subplot(2,1,2); plot(alpha_v,a_marg);
hline=refline((a_marg(100,1)-a_marg(1,1)),a_marg(1,1));
hline.Color = 'r';
xlabel('alpha');
ylabel('marginal utility');
legend('marginal utility','Location','northeast');

disp(['fminbnd solution at alpha=', num2str(alpha_fminbnd), '. fmincon solution at alpha=', num2str(alpha_fmincon)]);

% Define functions for utility and marginal utility
function util=utility(alpha,phi,prob_low,prob_high,w_init,r_f,r_high,r_low)
r=prob_high*r_high+prob_low*r_low;
util=(1/phi)*(w_init*(1+r_f+alpha*(r-r_f)))^(phi);
end

function mutil=marginal_utility(alpha,phi,prob_low,prob_high,w_init,r_f,r_high,r_low)
r=prob_high*r_high+prob_low*r_low;
mutil=(w_init*(r-r_f))/((w_init*(1+r_f+alpha*(r-r_f)))^(1-phi));
end




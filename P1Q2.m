%% Part 1 - loading and computing the logarithms
clear all;
clc;

A=xlsread('/Users/sebastiankuhnl/Desktop/GSEFM/Year 1/Semester 1.2/Mathematical Methods/Problem_Sets/PS1/data/OECD-Germany_Greece_GDP.xls');
Germany=A(1,:);
Greece=A(2,:);

LogGermany=log(Germany);
LogGreece=log(Greece);

%% Part 2 - Applying HP filter

%This version requires machine learning and statistics toolbox
smoothing = 1600; %unecessary since it is the default value of the function but done for sake of completeness
TrendGermany = hpfilter(LogGermany,smoothing);
TrendGreece = hpfilter(LogGreece,smoothing);

%% Part 3 - Applying OLS

%Creating time variable
Time = zeros(size(Greece));
Size = size(Greece);
for i=1:Size(1,2)
    Time(1,i)=i;
end

%OLS

Var_GRE=var(LogGreece);
Var_GER=var(LogGermany);
Cov_GRE=cov(Time,LogGreece);
Cov_GER=cov(Time,LogGermany);

b_1_GER=Var_GER/Cov_GER(1,2); 
b_1_GRE=Var_GRE/Cov_GRE(1,2);

Mean_Time=mean(Time);
Mean_GER=mean(LogGermany);
Mean_GRE=mean(LogGreece);

b_0_GER=Mean_GER-Mean_Time*b_1_GER;
b_0_GRE=Mean_GRE-Mean_Time*b_1_GRE;

Yhat_GER=b_0_GER+Time*b_1_GER;
Yhat_GRE=b_0_GRE+Time*b_1_GRE;

%figure
%plot(Time,Yhat_GER,Time,LogGermany);
%figure
%plot(Time,Yhat_GRE,Time,LogGreece);

%% Part 4 - Output Gap

Y_GER_trend_HP=exp(TrendGermany);
Y_GER_trend_OLS=exp(Yhat_GER);

Y_GRE_trend_HP=exp(TrendGreece);
Y_GRE_trend_OLS=exp(Yhat_GRE);

Y_Gap_GER_HP=Germany-Y_GER_trend_HP;
Y_Gap_GER_OLS=Germany-Y_GER_trend_OLS;

Y_Gap_GRE_HP=Greece-Y_GRE_trend_HP;
Y_Gap_GRE_OLS=Greece-Y_GRE_trend_OLS;

%% Part 5 - Plot

figure
plot(Time,LogGermany,Time,Yhat_GER,Time,TrendGermany);

figure
plot(Time,LogGreece,Time,Yhat_GRE,Time,TrendGreece);

figure
plot(Time,LogGermany,Time,Yhat_GER,Time,TrendGermany,Time,LogGreece,Time,Yhat_GRE,Time,TrendGreece);









%% Subquestion 4 - LU-Decomposition
clear;
clc;

a=3;
b=0.5;
c=1;
d=c;

A=[1,b;1 -d];

y=[a; c];

[L,U]=lu(A);

t=L\y;
x=U\t;

disp(['LU Result: The market clearing price ', num2str(x(1,1)), ' clears the market at the quantity ', num2str(x(2,1)), '!']);
%% Subquestion 5 - Gauss-Seidel fixed-point iteration

clear;


a=3;
b=0.5;
c=1;
d=c;

%initial guess of quantity
q=0.1;
%p=0.1;
%x=[q;p];

%Demand Function
%Dp=a-b*q;

%Supply Function
%Sp=c+d*q;

%Set up difference criterion to a value higher than in the while loop
difference=100;

%Set up empty vectors for storage of historical values
difference_hist=nan(100,1);
Dp_hist=nan(100,1);
Dq_hist=nan(100,1);
Sq_hist=nan(100,1);
Sp_hist=nan(100,1);
Time=nan(100,1);

%Iteration index
i=1;

%Begin iteration
while difference>0.01

    Dp=a-b*q;       %Demand-price from initial quantity
    Dp_hist(i,1)=Dp;
    Dq_hist(i,1)=q;
    Sq=(Dp-c)/d;    %Supply-quantity from Demand-price
    Sq_hist(i,1)=Sq;
    Sp=c+d*Sq;       %Supply-price for difference
    Sp_hist(i,1)=Sp;
   
    if i>1
    difference=abs(Sp_hist(i,1)-Dp_hist(i-1,1));
    difference_hist(i,1)=difference;
    end
    q=Sq;           %Quantity for next guess set
    Time(i,1)=i;
    i=i+1;
    
end
disp(['Gauss-Seidel Iteration Result (using quantity as initial guess): The market clearing price ', num2str(Sp), ' clears the market at the quantity ', num2str(Sq), ' after ',num2str(i-1),' iterations!']);

figure
scatter(Dq_hist,Dp_hist)
hold on
scatter(Sq_hist,Sp_hist)
plot(Dq_hist,Dp_hist,Sq_hist,Sp_hist)
line([Dq_hist(1,1) Dq_hist(1,1)], [Dp_hist(1,1) 0])

%TO SHOW HOW THE ALGORITHM WORKS!
for j=1:(i-1)
line([Dq_hist(j,1) Sq_hist(j,1)], [Dp_hist(j,1) Dp_hist(j,1)])
end

for j=1:(i-1)
line([Sq_hist(j,1) Sq_hist(j,1)], [Dp_hist(j,1) Sp_hist(j+1,1)])
end

title('Supply and Demand, using quantity as initial guess')
legend('Demand','Supply')
hold off

%To show convergence
figure
plot(Time,difference_hist)
title('Difference, using quantity as initial guess')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Alternatively: Using the price as a first guess
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

a=3;
b=0.5;
c=1;
d=c;

%Initial Guess

p=0.1;

%Demand Function
%Dp=a-b*q;

%Supply Function
%Sp=c+d*q;

%Set up difference criterion to a value higher than in the while loop
difference=100;

%Set up empty vectors for storage of historical values
difference_hist=nan(100,1);
Dp_hist=nan(100,1);
Dq_hist=nan(100,1);
Sq_hist=nan(100,1);
Sp_hist=nan(100,1);
Time=nan(100,1);

%Iteration index
i=1;

while difference>0.01
    
    Sq=(p-c)/d;    %Supply-quantity from price
    Sq_hist(i,1)=Sq;
    Sp=p;       %Supply-price for difference
    Sp_hist(i,1)=Sp;
    Dp=a-b*Sq;       %Demand-price from initial quantity
    Dp_hist(i,1)=Dp;
    Dq_hist(i,1)=Sq;
    
    %%%%%%WORK FROM HERE
   
    if i>1
    difference=abs(Sq_hist(i-1,1)-Dq_hist(i,1));
    difference_hist(i,1)=difference;
    end
    p=Dp;           %Quantity for next guess set
    Time(i,1)=i;
    i=i+1;
    
end

disp(['Gauss-Seidel Iteration Result (using price as initial guess): The market clearing price ', num2str(Sp), ' clears the market at the quantity ', num2str(Sq), ' after ',num2str(i-1),' iterations!']);

figure
scatter(Dq_hist,Dp_hist)
hold on
scatter(Sq_hist,Sp_hist)
plot(Dq_hist,Dp_hist,Sq_hist,Sp_hist)
line([Sq_hist(1,1) 0], [Sp_hist(1,1) Sp_hist(1,1)])

%TO SHOW HOW THE ALGORITHM WORKS!
for j=1:(i-1)
line([Dq_hist(j,1) Sq_hist(j+1,1)], [Dp_hist(j,1) Dp_hist(j,1)])
end

for j=1:(i-1)
line([Sq_hist(j,1) Sq_hist(j,1)], [Dp_hist(j,1) Sp_hist(j,1)])
end

title('Supply and Demand, using price as initial guess')
legend('Demand','Supply')
hold off

%% Subquestion 6 - 
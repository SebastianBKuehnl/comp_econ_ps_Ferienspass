clear;
i=1;
data=xlsread('MRW92QJE-data.xls');
%every row has 1 NaN, which is fine
while i<=length(data)
    summe=0;
    for j=1:size(data,2)
        if isnan(data(i,j))
            summe=summe+1;
        end
    end
    if summe>1
        data(i,:)=[];
        i=i-1;
    end
    i=i+1;
end
%subsamples
nonoil=[];
interm=[];
oecd=[];
for i=1:length(data)
    if data(i,3)==1
        nonoil=[nonoil;data(i,:)];
    end
    if data(i,4)==1
        interm=[interm;data(i,:)];
    end
    if data(i,5)==1
        oecd=[oecd;data(i,:)];
    end
end
%multiple regression
%nonoil
y1=log(nonoil(:,7))-log(nonoil(:,6));
x1=[ones(length(nonoil),1) log(nonoil(:,6)) log(nonoil(:,10)) log(nonoil(:,9)+0.05) log(nonoil(:,11))];
[b1,a11,a12,a13,stats1]=regress(y1,x1);
%interm
y2=log(interm(:,7))-log(interm(:,6));
x2=[ones(length(interm),1) log(interm(:,6)) log(interm(:,10)) log(interm(:,9)+0.05) log(interm(:,11))];
[b2,a21,a22,a23,stats2]=regress(y2,x2);
%nonoil
y3=log(oecd(:,7))-log(oecd(:,6));
x3=[ones(length(oecd),1) log(oecd(:,6)) log(oecd(:,10)) log(oecd(:,9)+0.05) log(oecd(:,11))];
[b3,a31,a32,a33,stats3]=regress(y3,x3);
%display
obs=[length(nonoil) length(interm) length(oecd)];
Sample={'Observations:'; 'Constants:' ;'SE'; 'ln(Y60)' ;'SE'; 'ln(I/G)'; 'SE'; 'ln(n+g+delta)' ;'SE'; 'ln(schooling)'; 'SE'; 'R^2'; 's.e.e'};
Nonoil=[length(nonoil) b1(1) abs((a11(1,1)+a11(1,2))*sqrt(obs(1))/1.96) b1(2) abs((a11(2,1)+a11(2,2))*sqrt(obs(1))/1.96) b1(3) abs((a11(3,1)+a11(3,2))*sqrt(obs(1))/1.96) b1(4) abs((a11(4,1)+a11(4,2))*sqrt(obs(1))/1.96) b1(5) abs((a11(5,1)+a11(5,2))*sqrt(obs(1))/1.96) stats1(1) stats1(4)];
Nonoil=transpose(Nonoil);
Intermediate=[length(interm) b2(1) abs((a21(1,1)+a21(1,2))*sqrt(obs(2))/1.96) b2(2) abs((a21(2,1)+a21(2,2))*sqrt(obs(2))/1.96) b2(3) abs((a21(3,1)+a21(3,2))*sqrt(obs(2))/1.96) b2(4) abs((a21(4,1)+a21(4,2))*sqrt(obs(2))/1.96) b2(5) abs((a21(5,1)+a21(5,2))*sqrt(obs(2))/1.96) stats2(1) stats2(4)];
Intermediate=transpose(Intermediate);
OECD=[length(oecd) b3(1) abs((a31(1,1)+a31(1,2))*sqrt(obs(3))/1.96) b3(2) abs((a31(2,1)+a31(2,2))*sqrt(obs(3))/1.96) b3(3) abs((a31(3,1)+a31(3,2))*sqrt(obs(3))/1.96) b3(4) abs((a31(4,1)+a31(4,2))*sqrt(obs(3))/1.96) b3(5) abs((a31(5,1)+a31(5,2))*sqrt(obs(3))/1.96) stats3(1) stats3(4)];
OECD=transpose(OECD);
T=table(Sample,Nonoil,Intermediate,OECD)
T.Properties.VariableNames{'Sample'} = 'Sample';
T.Properties.VariableNames{'Nonoil'} = 'Nonoil';
T.Properties.VariableNames{'Intermediate'} = 'Intermediate';
T.Properties.VariableNames{'OECD'} = 'OECD';




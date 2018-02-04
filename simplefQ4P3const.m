function a=simplefQ4P3const(x)
 b=(9.^(1./x).*1.02-1.02)./(0.06+0.06.*9.^(1./x));
 a=NaN(length(b));
 for j=1:length(b)
 if b(j)>1
     a(j)=1;
 else
     a(j)=b(j);
 end
end
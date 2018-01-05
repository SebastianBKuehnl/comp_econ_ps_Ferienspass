clear;
%create the hood
Hood=zeros(15,15);
%now generate your people
n=110; %Blacks
m=110; %whites
p=5;   %unoccupied
%move your people into the hood
%1: Black
%2: White
%3: unoccupied
plots=0;
for i=1:15
  for j=1:15
     sum=n+m+p;
      x=rand;
     if x<n/sum
         Hood(i,j)=1;
         n=n-1;
     else
       if x<(n+m)/sum
           Hood(i,j)=2;
           m=m-1;
       else
           Hood(i,j)=3;
           p=p-1;
       end
     end
  end    
end
%now this is the hood (black is blue, white is green, unoccupied is red
plots=plots+1;
figure
subplot(2,2,plots)
imagesc(Hood)
title({'Initial Setup, blue is black,';' green is white, red is unoccupied'})
colorbar
iterations=0;
%start iteration
for iterations=1:45
%detect mover
Neighbors=zeros(15,15);
Same=zeros(15,15);
movers=0;
Mover=[0 0 0];
Free=[0 0];
%check same skin middle
for i=1:15
   for j=1:15 
       Skin=Hood(i,j);
       if Skin==3
           Free=[Free;i j];
       else    
      for z=1:3 
      for w=1:3
          if (i+z-2>=1) && (i+z-2<=15) 
           if (j+w-2>=1) && (j+w-2<=15)
             if Hood(i+z-2,j+w-2)~=3
                 Neighbors(i,j)=Neighbors(i,j)+1; %number neighbors (including oneself)
             end    
           if isequal(Hood(i+z-2,j+w-2),Skin) 
            if (z~=2) || (w~=2) %dont count yourself
              Same(i,j)=Same(i,j)+1; %number same skin
            end
           end
           end
          end
      end
      end
      Neighbors(i,j)=Neighbors(i,j)-1; %deduct oneself
      if Same(i,j)/Neighbors(i,j)<=0.35
          movers=movers+1;
          Mover=[Mover;i j Skin];
          Free=[Free;i j];
      end
      end
   end    
end
Mover=Mover(2:end,:);
Free=Free(2:end,:);
%move into new house
sz = size(Mover);
for k=1:sz(1,1) %in this loop there is an error if movers<3
    newpos=unidrnd(length(Free),1,1);
    Hood(Free(newpos,1),Free(newpos,2))=Mover(k,3);
    Free(newpos,:)=[];
end
Mover=[0 0 0];
%make free houses unoccupied
for l=1:length(Free)
    Hood(Free(l,1),Free(l,2))=3;
end
if (iterations==30) || (iterations==15)
plots=plots+1;
subplot(2,2,plots)
imagesc(Hood)
title(['After ' num2str(iterations) ' iterations'])
colorbar
end
end
%end of iteration
plots=plots+1;
subplot(2,2,plots)
imagesc(Hood)
title('After 45 iterations')
colorbar

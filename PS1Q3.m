%% Set up the grid

clear all;
clc;

Board=zeros(15,15); 

%110 White (1 indicates white)
i=1;
while i<110

Col = randi(size(Board, 2));
Row = randi(size(Board, 1));
if Board(Col,Row)==0
    Board(Col,Row)=1;
    i=i+1;
else
end
end

%110 Black (2 indicates black)

j=1;
while j<110

Col = randi(size(Board, 2));
Row = randi(size(Board, 1));
if Board(Col,Row)==0
    Board(Col,Row)=2;
    j=j+1;
else
end
end

figure
Plot_0=imagesc(Board);

%% Spot unoccupied houses



Non_Occupied=zeros(5,2);
Non_Index=1;

for i=1:15
    for j=1:15
        if Board(i,j)==0
            
            Non_Occupied(Non_Index,1)=i;
            Non_Occupied(Non_Index,2)=j;
            if Non_Index<5
            Non_Index=Non_Index+1;
            
            end
        else
        end
    end
end

%% Evaluate position

Movers_Location=zeros(15,15);

for i=1:15
    for j=1:15
       Self=Board(i,j);
       %Evaluate at Borders
       if i==1||i==1||i==15||j==15
           
       else
       %Evaluate interior
       
           %Get neighboring values
           Upper_N=Board(i-1,j);
           Lower_N=Board(i+1,j);
           Left_N=Board(i,j+1);
           Right_N=Board(i,j+1);

           %Compare to neighbors
           Neigh=zeros(4,1);
           Neigh(1,1)=double((Self==Upper_N));
           Neigh(2,1)=double((Self==Lower_N));
           Neigh(3,1)=double((Self==Left_N));
           Neigh(4,1)=double((Self==Right_N));
           
           %Same_Upper=double((Self==Upper_N));
           %Same_Lower=double((Self==Lower_N));
           %Same_Left=double((Self==Left_N));
           %Same_Right=double((Self==Right_N));
           
           %at least 35% must be equal to not move
           Neigh_Eval=sum(Neigh)/4;
           
          if Neigh_Eval<0.35
              Movers_Location(i,j)=1;
          end
           
       
       end
    end
end





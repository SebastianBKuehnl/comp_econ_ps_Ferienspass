%% Set up the grid

clear;
clc;

Board=zeros(15,15); 
Iteration_Count=0;
%110 White (1 indicates white)
i=1;
while i<111

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
while j<111

Col = randi(size(Board, 2));
Row = randi(size(Board, 1));
if Board(Col,Row)==0
    Board(Col,Row)=2;
    j=j+1;
else
end
end

figure
subplot(2,2,1)
Plot_0=imagesc(Board);

for ij=1:45
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
Movers_Count=0;

for i=1:15
    for j=1:15
       Self=Board(i,j);
       %Evaluate at Borders
       %if i==1||j==1||i==15||j==15
           
          % if i==1
          
      
          %Elseif for every border possibility     
           
      % else
       %Evaluate interior
       
           %Get neighboring values
           if i==1
           Upper_N=0;
           else
           Upper_N=Board(i-1,j);
           end
           
           if i==15
           Lower_N=0;
           else
           Lower_N=Board(i+1,j);
           end
           
           if j==1
            Left_N=0;
           else
           Left_N=Board(i,j-1);
           end
           
           if j==15
           Right_N=0;
           else
           Right_N=Board(i,j+1);
           end

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
              Movers_Location(i,j)=1; %everyone with a one wants to move
              Movers_Count=Movers_Count+1;
          end
           
       
       %end
    end
end

%% Only five households are allowed to move each period (since only five houses are unoccupied)

Allowed_Movers=zeros(5,1); 
Allowed_Movers_Pos=zeros(5,2);
Want_to_Move=zeros(Movers_Count,2);
k=1;
for i=1:15
    for j=1:15
       if Movers_Location(i,j)==1 
           %Store to movers
           
      
           Want_to_Move(k,1)=i;
           Want_to_Move(k,2)=j;
           
           k=k+1;
       end
    end
end

%Pick five movers

for i=1:5
Allowed_Movers(i,1) = randi(Movers_Count);
end

for i=1:5
    Allowed_Movers_Pos(i,1)=Want_to_Move(Allowed_Movers(i,1),1);
    Allowed_Movers_Pos(i,2)=Want_to_Move(Allowed_Movers(i,1),2);
end

%% Let the five households move to a random unoccupied house

Moves_To=zeros(5,2);
Unoccupied_NowOccupied=zeros(5,1);
i=1;

while i<6
    
    Row=randi(5);
    if ismember(Row,Unoccupied_NowOccupied)==0
    Unoccupied_NowOccupied(i,1)=Row;
     
    Moves_To(i,1)=Non_Occupied(Row,1);
    Moves_To(i,2)=Non_Occupied(Row,2);
    i=i+1;
    end
    
end

%Set new location of selected movers to zero, set unoccupied houses to new
%values

for i=1:5
    Board(Non_Occupied(i,1),Non_Occupied(i,2))=Board(Allowed_Movers_Pos(i,1),Allowed_Movers_Pos(i,2));
    Board(Allowed_Movers_Pos(i,1),Allowed_Movers_Pos(i,2))=0;
end

Iteration_Count=Iteration_Count+1;
Title= ['Iteration' num2cell(Iteration_Count)];

if ij==15
    subplot(2,2,2)
    Plot_1=imagesc(Board);
    title(Title)
elseif ij== 30
    subplot(2,2,3)
    Plot_2=imagesc(Board);
    title(Title)
elseif ij== 45
    subplot(2,2,4)
    Plot_3=imagesc(Board);
    title(Title)
        
end
        
end

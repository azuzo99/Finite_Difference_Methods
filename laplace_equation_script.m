clear,clc,close all

%% Opis problemu
% Niech dana będzie geometria w postaci kwadratu o wymiarach 1x1
% Rozwiążmy równanie ciepła Laplace'a w stanie ustalonym dla 2D
% Dodatkowo uprośćmy problem wprowadzając równość kroku ( dx=dy=dh)
figure(1)
xlim([0 1.5])
ylim([0 1.5])
line([0 1],[0 0])
line([0 1],[1 1])
line([1 1],[1 0])
line([0 0],[0 1])
title('Geometria')

%% Założenia
% Nasz problem posiada warunki brzegowe Dirichleta
% Dodatkowo problem jest symetryczny

%% Rozwiązanie
n=50; % ilość elementów siatki n x n
x=linspace(0,1,n); % wektor długości x
y= linspace(0,1,n); % wektor długości y
dh=y(2)-y(1);
% Wprowadzamy warunki brzegowe:
T_u=100;
T_d=0;
T_r=0;
T_l=0;
% mamy w takim razie n*n wartości
T=zeros((n^2)); % macierz zer
% Nadanie warunków brzegowych macierzy wyników
T(1,1:end)=T_u;
T(end,1:end)=T_d;
T(1:end,end)=T_r;
T(1:end,1)=T_l;

%% generacja macierzy wartości nieznanych temperatur
% mamy dane wartości dwóch wierszy oraz dwóch kolumn
% dlatego ilość nieznanych zmniejsza się do n-2*n-2
% wykorzystamy Kronecker product do stworzenia naszej macierzy
B=zeros((n-2)^2/2);
B1=eye((n-2)^2/2);
a=linspace(1,1,(n-2)^2/2-1);
B2=B+diag(a,1)+diag(a,-1);
v1=[ 4 -1 ; -2 4];
v2=[ -1 0; 0 -1];
A=kron(B1,v1)+kron(B2,v2);
% nadamy warunki brzegowe i przygotujemy macierz wyrazów wolnych
BC=zeros(n-2);
BC(:,1)=T_l;
BC(:,end)=T_r;
BC(1,:)=T_u;
BC(end,:)=T_d;
BC=transpose(BC);
BC=reshape(BC,[],1)
% rozwiązanie
C=inv(A)*BC


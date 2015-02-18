% ----- Projet deformation 2D seance du 21/01/15 --------


close all;
clear all;
%coucou

%vidObj = VideoReader('respiration.wmv');
%get(vidObj);

%img=read(vidObj,1);
img = imread('');
imshow(img);
% On recupere les coordonnees de deux points que l'on clique sur l'image
[x,y] = ginput(2)

% Variable d'echantillonnage de la grille
ech = 4;

figure;
%img1=read(vidObj,300);
img1 = imread('');
imshow(img1);

x1=x(1);
y1=y(1);

x2=x(2);
y2=y(2);
 
d1 = (x2-x1)/ech;
d2 = (y2-y1)/ech;

% Parametres de balayage 
xDeb = x1-100;
yDeb = y1-100;

xFin = x2+100;
yFin = y2+100;

sDeb = -10;
sFin = 10;

tetaDeb = -30;
tetaFin = 30;

pasX = 10;
pasY = 10;
pasS = 2;
pasTeta = 3;

% Affichage de la grille avec 4 cases
[X,Y] = meshgrid(x1:d1:x2, y1:d2:y2);
figure;
imshow(img);
hold on;
plot(X,Y,'g');
hold on;
plot(X',Y','g');

% On recupere nos 3 canaux R,G et B
R = img(:,:,1);
V = img(:,:,2);
B = img(:,:,3);

R1 = img1(:,:,1);
V1 = img1(:,:,2);
B1 = img1(:,:,3);

% On creer une image d'intensites a partir de l'image originale
I = 0.21*R + 0.72*V + 0.07*B;
I1 = 0.21*R1 + 0.72*V1 + 0.07*B1;


% On definit 4 paramatres s, u, v, teta

for(u=xDeb:pasX:xFin)
   for(v=yDeb:pasY:yFin) 
     for(s=sDeb:pasS:sFin)  
       for(teta=tetaDeb:pasTeta:tetaFin)
           
           Rot = [cos(teta) -sin(teta) ; sin(teta) cos(teta)];
           for(xLigne=round(x1):1:round(x2))
                for(yLigne=round(y1):1:round(y2))
                    trans = [u;v];
                    xMat = [xLigne;yLigne];
                    xPrimeMat = s*Rot*xMat + trans; 
                end
           end
           
       end
     end   
   end   
end
 
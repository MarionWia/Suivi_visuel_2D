clear all;
close all;

imgInit = imread('imageOriginale_respiration.jpg');
imshow(imgInit);
img = imread('image300_respiration.jpg');
figure;
imshow(img);
u = 0;
v = 0;
teta = 0;
s = 1;

a0 = [ u ; v ; teta; s]
size  = size(a0)


% Creation de la r�gion d'int�ret
I = imcrop(imgInit);
imshow(I);

% Conversion de l'image en couleur en intensit�
R = imgInit(:,:,1);
V = imgInit(:,:,2);
B = imgInit(:,:,3);

R1 = img(:,:,1);
V1 = img(:,:,2);
B1 = img(:,:,3);

R2 = I(:,:,1);
V2 = I(:,:,2);
B2 = I(:,:,3);

% On creer une image intensite a partir de l'image originale
Iinit = 0.21*R + 0.72*V + 0.07*B;
I1 = 0.21*R1 + 0.72*V1 + 0.07*B1;
imgIntensite = 0.21*R2 + 0.72*V2 + 0.07*B2;
figure;
imshow(imgIntensite);

gradIm = gradient(imgIntensite);

Rtr=[cos(teta) sin(teta);-sin(teta) cos(teta)];

S=[(1/s).*Rtr(1,1) (1/s).*Rtr(1,2) 0 0;(1/s)*Rtr(2,1) (1/s)*Rtr(2,2) 0 0;0 0 1 0;0 0 0 1/s];


% Calcul de Jo 

% Calcul de G(x)


taille=size(imgIntensite);
nbligne=taille(1);
nbcolonne=taille(2);


Gx=zeros(2*nbligne*nbcolonne,4);

for i=1:1:nbligne
    for j=1:1:nbcolonne
        X=[i;j];
        G=[1 0 -X(2) X(1);0 1 X(1) X(2)]; 
        
        Gx(i,j)=G;
       
        %J=GradI.*G.*S;
    end
end
 
 
 

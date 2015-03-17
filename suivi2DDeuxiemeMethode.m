clear all;
close all;

imgInit = imread('imageOriginale_respiration.jpg');% Image N°1
imshow(imgInit);
img = imread('image300_respiration.jpg');% Image N°2
figure;
imshow(img);
u = 0;
v = 0;
teta = 0;
s = 1;

a0 = [ u ; v ; teta; s];


% Creation de la région d'intéret
[I,rect] = imcrop(imgInit);
imshow(I);

% Conversion de l'image en couleur en intensité
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
Iinit = 0.21*R + 0.72*V + 0.07*B;% Image N°1
I1 = 0.21*R1 + 0.72*V1 + 0.07*B1;% Image N°2
imgIntensite = 0.21*R2 + 0.72*V2 + 0.07*B2; % Image région d'intérêt
figure;
imshow(imgIntensite);
title('Image intensite de la region d''interet selectionnee sur l''image originale');

[gradIm] = gradient(imgIntensite);

Rtr=[cos(teta) sin(teta);-sin(teta) cos(teta)];

S=[(1/s).*Rtr(1,1) (1/s).*Rtr(1,2) 0 0;(1/s)*Rtr(2,1) (1/s)*Rtr(2,2) 0 0;0 0 1 0;0 0 0 1/s];


% Calcul de Jo 



taille = size(imgIntensite);
nbligne=taille(1,1);
nbcolonne=taille(1,2);
nbPixel = nbligne*nbcolonne;

%Gx=zeros(2*nbligne*nbcolonne,4);
% Prendre les pixels par rapport au centre de la zone
 centreImCrop = [];
 centreImCrop(1,1) = rect(1,1)+ nbcolonne/2;
 centreImCrop(1,2) = rect(1,2)+ nbligne/2;
G = [];
for i=1:nbligne
    for j=1:nbcolonne
        
        %G = [G;1 0 -j i;0 1 i j]; 

        jTranslate = j - nbcolonne/2;
        iTranslate = i - nbligne/2;
        G=[G;1 0 -jTranslate iTranslate;0 1 iTranslate jTranslate]; 

            
    end
end

 %Jo =[nbPixel;4];
 
for i =1:nbPixel
    j = 2*i;
    a = (gradIm(j-1:j, :))';
    b = G(j-1:j,:);
    Jo(i,:) = a*b;
    
end 
  
  % Calcul de la pseudo-inverse de J0
  
 % JoPseudoInv = inVtmp*JoTrans;
  
  %JoTrans = Jo';
  %tmp = JoTrans*Jo;
  
  JoPseudoInv = pinv(Jo);

% FORWARD MAPPING

tailleGrille = size(imgIntensite);

% Matrice de 0 
imgTmp = zeros(tailleGrille);

tailleimgTmp = size(imgTmp);

xMin = rect(1,1); % coordonnee x du point d'origine dans l'image crop par rapport a l'image initiale
yMin = rect(1,2); % coordonnee y du point d'origine dans l'image crop par rapport a l'image initiale

% Matrice de transformation affine
matTransform = [s*cos(teta) s*sin(teta) u; -s*sin(teta) s*cos(teta) v; 0 0 1]

T = maketform('affine',matTransform);
imTransforme = imtransform(imgIntensite,T);
figure;
imshow(imTransforme);
% Calcul de l'erreur entre R(to) et R(t+dt)

% Image (N°1) Initiale Intensité à to: Iinit
% Image (N°2) à t+dt : I1

%close all;
% test
figure;
subplot(3,1,1)
imshow(imgIntensite);
title('Image à to');
subplot(3,1,2)
imshow(imTransforme);
title('Image à t+dt');

% matrice erreur
m_Erreur=imTransforme-imgIntensite;

subplot(3,1,3)
imshow(m_Erreur);
title('erreur');

% Calcul de l'inverse de S
Sinv=inv(S);
tailleErreur = size(m_Erreur);
error = reshape(m_Erreur,tailleErreur(1,1)*tailleErreur(1,2),1);
% Calcul de delta_a
tmp = -1*Sinv*JoPseudoInv;
delta_a=tmp*double(error);

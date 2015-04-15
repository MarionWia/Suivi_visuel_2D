clear all;
close all;

% Chargement de l'Image N°1
imgInit = imread('imageOriginale_respiration.jpg');
figure('Name','Image initiale avant crop','NumberTitle','off')
imshow(imgInit);

% Chargement de l'image N°2
img = imread('image_2_respiration.jpg');
figure('Name','Image 2','NumberTitle','off')
imshow(img);

% Initialisation du jeu de paramètre
% u et v définissent la translation
% teta est l'angle de rotation
% s est le facteur d'échelle
u = 0;
v = 0;
teta = 0;
s = 1;

a0 = [ u ; v ; teta; s]; % Vecteur contenant les paramètres


% Creation de la région d'intéret (crop de l'image en niveau de gris)
[I,rect] = imcrop(imgInit);
figure('Name','Image Init cropée','NumberTitle','off')
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

% Calcul du gradient sur la région d'interet
[gradIm] = gradient(imgIntensite);

% matrice de rotation
Rtr=[cos(teta) sin(teta);-sin(teta) cos(teta)];

S=[(1/s).*Rtr(1,1) (1/s).*Rtr(1,2) 0 0;(1/s)*Rtr(2,1) (1/s)*Rtr(2,2) 0 0;0 0 1 0;0 0 0 1/s];


% Calcul de Jo
taille = size(imgIntensite);
nbligne=taille(1,1);
nbcolonne=taille(1,2);
nbPixel = nbligne*nbcolonne;

% Prendre les pixels par rapport au centre de la zone
centreImCrop = [];
centreImCrop(1,1) = rect(1,1)+ rect(1,3)/2;
centreImCrop(1,2) = rect(1,2)+ rect(1,4)/2;

% Calcul de G
G = [];
for i=1:nbligne
    for j=1:nbcolonne
        
        jTranslate = j - nbcolonne/2;
        iTranslate = i - nbligne/2;
        G=[G;1 0 -jTranslate iTranslate;0 1 iTranslate jTranslate];
    end
end

% calcul de Jo
Jo = JCalc( nbPixel, G,gradIm );

% Calcul de la pseudo-inverse de J0
JoPseudoInv = pinv(Jo);

% Realisation du forward mapping
imTransforme = forwardMapping( rect, s, teta, u,v,I1  );

% Calcul de l'erreur entre R(to) et R(t+dt)
% Image (N°1) Initiale Intensité à to: imgIntensite
% Image (N°2) à t+dt : imTransforme

figure;
subplot(2,1,1)
imshow(imgIntensite);
title('Image à to');
subplot(2,1,2)
imshow(imTransforme);
title('Image à t+dt');
tailleImTransforme = size(imTransforme);

% matrice erreur
m_Erreur=abs(imTransforme-imgIntensite);

figure;
imshow(m_Erreur,[]);
title('erreur');

% Calcul de l'inverse de S
Sinv=inv(S);
tailleErreur = size(m_Erreur);
error = reshape(m_Erreur,tailleErreur(1,1)*tailleErreur(1,2),1);

% Calcul de delta_a
tmp = -1*Sinv*JoPseudoInv;
delta_a=tmp*double(error);

% mise à jour de a0
a0 = a0 + delta_a;

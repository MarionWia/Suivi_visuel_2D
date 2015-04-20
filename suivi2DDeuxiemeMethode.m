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

Iinit=greyconversion(imgInit); % Création de l'image intensité à partir de l'image originale : Image N°1
I1=greyconversion(img); % Image N°2
imgIntensite=greyconversion(I); % Image région d'intérêt

figure;
imshow(imgIntensite);
title('Image intensite de la region d''interet selectionnee sur l''image originale');

% Calcul du gradient sur la région d'interet
[gradIm] = gradient(imgIntensite);

% matrice de rotation
Rtr=[cos(a0(3,1)) sin(a0(3,1));-sin(a0(3,1)) cos(a0(3,1))];

S=[(1/a0(4,1)).*Rtr(1,1) (1/a0(4,1)).*Rtr(1,2) 0 0;(1/a0(4,1))*Rtr(2,1) (1/a0(4,1))*Rtr(2,2) 0 0;0 0 1 0;0 0 0 1/a0(4,1)];


% Calcul de la taille de l'image
taille = size(imgIntensite);
nbligne=taille(1,1);
nbcolonne=taille(1,2);
nbPixel = nbligne*nbcolonne;

% Calcul de G
G = GCalc(nbligne, nbcolonne);

% calcul de Jo
Jo = JCalc( nbPixel, G,gradIm );

% Calcul de la pseudo-inverse de J0
JoPseudoInv = pinv(Jo);

% Realisation du forward mapping
imTransforme = forwardMapping( rect, a0(4,1), a0(3,1), a0(1,1),a0(2,1),I1  );

% Calcul de l'erreur entre R(to) et R(t+dt)
% Image (N°1) Initiale Intensité à to: imgIntensite
% Image (N°2) à t+dt : imTransforme
figure;
subplot(2,1,1)
imshow(imgIntensite); % Affichage de l'image a to
title('Image à to');
subplot(2,1,2)
imshow(imTransforme); % Affichage de l'image a t+dt
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



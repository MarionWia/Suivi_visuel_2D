clear all;
close all;

% Chargement de l'Image N�1
imgInit = imread('imageOriginale_respiration.jpg');
figure('Name','Image initiale avant crop','NumberTitle','off') 
imshow(imgInit);

% Chargement de l'image N�2
img = imread('image300_respiration.jpg');
figure('Name','Image 2','NumberTitle','off') 
imshow(img);

% Initialisation du jeu de param�tre
u = 0;
v = 0;
teta = 0;
s = 1;

a0 = [ u ; v ; teta; s]; % Vecteur contenant les param�tres


% Creation de la r�gion d'int�ret (crop de l'image en nveau de gris)
[I,rect] = imcrop(imgInit);
figure('Name','Image Init crop�e','NumberTitle','off') 
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
Iinit = 0.21*R + 0.72*V + 0.07*B;% Image N�1
I1 = 0.21*R1 + 0.72*V1 + 0.07*B1;% Image N�2
imgIntensite = 0.21*R2 + 0.72*V2 + 0.07*B2; % Image r�gion d'int�r�t
figure;
imshow(imgIntensite);
title('Image intensite de la region d''interet selectionnee sur l''image originale');

% Calcul du gradient sur la r�gion d'interet
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
 centreImCrop(1,1) = rect(1,1)+ nbcolonne/2;
 centreImCrop(1,2) = rect(1,2)+ nbligne/2;
 
 % Calcul de G
 G = [];
 for i=1:nbligne
    for j=1:nbcolonne
        
        jTranslate = j - nbcolonne/2;
        iTranslate = i - nbligne/2;
        G=[G;1 0 -jTranslate iTranslate;0 1 iTranslate jTranslate];      
    end
 end
 
% Calcul de Jo
for i =1:nbPixel
    j = 2*i;
    a = (gradIm(j-1:j, :))';
    b = G(j-1:j,:);
    Jo(i,:) = a*b;
    
end 
  
  % Calcul de la pseudo-inverse de J0
  JoPseudoInv = pinv(Jo);

% FORWARD MAPPING
tailleGrille = size(imgIntensite);

xMin = rect(1,1); % coordonnee x du point d'origine dans l'image crop par rapport a l'image initiale
yMin = rect(1,2); % coordonnee y du point d'origine dans l'image crop par rapport a l'image initiale

% Definition des quatre points de la grille dans l'image initiale
Q1 = [xMin ; yMin; 1];
Q2 = [xMin+tailleGrille(1,1); yMin; 1];
Q3 = [xMin ; yMin+tailleGrille(1,2); 1];
Q4 = [xMin+tailleGrille(1,1) ; yMin+tailleGrille(1,2);1];

% Matrice de transformation affine
matTransform = [s*cos(teta) s*sin(teta) u; -s*sin(teta) s*cos(teta) v; 0 0 1]

% Transformation inverse
invMatTransform = inv(matTransform);

% Application de la transformation pour trouver les quatre coins dans la
% deuxi�me image
Q1_imtransform = matTransform*Q1;
Q2_imtransform = matTransform*Q2;
Q3_imtransform = matTransform*Q3;
Q4_imtransform = matTransform*Q4;

%  Creation de l'image a l'interieur des qautre points Q_imtransform
if(Q1_imtransform(1,1) > Q3_imtransform(1,1))
    debX = Q3_imtransform(1,1)
else
   debX = Q1_imtransform(1,1) 
end
if(Q2_imtransform(1,1) > Q4_imtransform(1,1))
    finX = Q2_imtransform(1,1)
else
  finX = Q4_imtransform(1,1)  
end

if(Q1_imtransform(2,1) > Q2_imtransform(2,1))
    debY = Q2_imtransform(2,1)
else
   debY = Q1_imtransform(2,1) 
end
if(Q3_imtransform(2,1) > Q4_imtransform(2,1))
    finY = Q4_imtransform(2,1)
else
  finY = Q3_imtransform(2,1)  
end
im2Grille = I1(debX:finX,debY:finY);
figure('Name','FIGURE TEST','NumberTitle','off') 
imshow(im2Grille);

% calcul de l'image ou on a appliqu� la transformation inverse
T = maketform('affine',invMatTransform);
imTransforme = imtransform(im2Grille,T);
figure('Name','region d"interet apres le warping','NumberTitle','off');
imshow(imTransforme);


% Calcul de l'erreur entre R(to) et R(t+dt)
% Image (N�1) Initiale Intensit� � to: imgIntensite
% Image (N�2) � t+dt : imTransforme

figure;
subplot(3,1,1)
imshow(imgIntensite);
title('Image � to');
subplot(3,1,2)
imshow(imTransforme);
title('Image � t+dt');
tailleImTransforme = size(imTransforme)
testT = tailleImTransforme(1,1) -1
testT1 = tailleImTransforme(1,2) -1
imtransformReduite = imTransforme(1:testT,1:testT1);

% matrice erreur
m_Erreur=imtransformReduite-imgIntensite;

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

% mise � jour de a0
a0 = a0 + delta_a;

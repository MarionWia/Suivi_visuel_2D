clear all;
close all;

imgInit = imread('imageOriginale_respiration.jpg');
imshow(imgInit);

% taille = size(imgInit);

% Creation de la r�gion d'int�ret
[I,rect] = imcrop(imgInit);
imshow(I);

% Conversion de l'image en couleur en intensit�R = imgInit(:,:,1);

R2 = I(:,:,1);
V2 = I(:,:,2);
B2 = I(:,:,3);

% On creer une image intensite a partir de l'image originale
imgIntensite = 0.21*R2 + 0.72*V2 + 0.07*B2;
figure;
imshow(imgIntensite);

tailleGrille = size(imgIntensite);

% Matrice de 0 
imgTmp = zeros(tailleGrille);

tailleimgTmp = size(imgTmp);

xMin = rect(1,1); % coordonnee x du point d'origine dans l'image crop par rapport a l'image initiale
yMin = rect(1,2); % coordonnee y du point d'origine dans l'image crop par rapport a l'image initiale

for (i=1:1:tailleimgTmp(1,1))
    for (j=1:1:tailleimgTmp(1,2))

    trans(1,1) = (xMin + i) + u; % u a recuperer
    trans(1,2) = (yMin + j) + v; % v a recuperer   
              
    end
end

imgTmpS = imresize(imgTmp,s); % s a recuperer

imgTmpR = imrotate(imgTmp,teta); % teta a recuperer





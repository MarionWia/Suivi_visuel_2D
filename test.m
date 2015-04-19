close all;
clear all;

% Chargement de l'image N°2
img = imread('imageOriginale_respiration.jpg');
figure('Name','Image 2','NumberTitle','off')
%imshow(img);

% Creation de la région d'intéret (crop de l'image en nveau de gris)
[I,rect] = imcrop(img);
figure('Name','Image Init cropée','NumberTitle','off')
%imshow(I);

% Conversion de l'image en couleur en intensité
R1 = I(:,:,1);
V1 = I(:,:,2);
B1 = I(:,:,3);

% On creer une image intensite a partir de l'image originale
imgIntensite = 0.21*R1 + 0.72*V1 + 0.07*B1; % Image région d'intérêt
figure;
imshow(imgIntensite);
title('Image intensite de la region d''interet selectionnee sur l''image originale');

[img_grad_x , img_grad_y ] = gradient_sobel(imgIntensite);

subplot(2,1,1);
imshow(img_grad_x);
title('Horizontal gradient (detect vertical edges)');
subplot(2,1,2);
imshow(img_grad_y);
title('Vertical gradient (detect horizontal edges)'); 



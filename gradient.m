% ----- Calcul du gradient avec l'information d'intensite

function [ grad_x , grad_y ] = gradient( grey_image )

h  = fspecial('sobel');
grad_y = imfilter( grey_image , h  , 'replicate' );
grad_x = imfilter( grey_image , h' , 'replicate' );

% On applique les filtres Sx et Sy : filtres de Sobel

% Sx = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
% Sy = [1 2 1 ; 0 0 0 ; -1 -2 -1];
% 
% gradIx = conv2(Sx,intensity_matrix);
% gradIy = conv2(Sy,intensity_matrix);

% gradI = [gradIx ; gradIy]; % vecteur gradient 1*2

% Enlever les bords qui ont été rajouté avec le calcul du gradient
% tailleGrad = size(gradIx);
% gradIxDim = gradIx(2:(tailleGrad(1,1)-1) , 2:(tailleGrad(1,2)-1));
% dim = size(gradIxDim);
% gradIyDim = gradIy(2:(tailleGrad(1,1)-1) , 2:(tailleGrad(1,2)-1));
% 
% % Modifier la taille de la matrice: créer un vecteur ligne
% gradIx1 = reshape(gradIxDim,dim(1,1)*dim(1,2),1);
% gradIy1 = reshape(gradIyDim,dim(1,1)*dim(1,2),1);
% gradIm = [gradIx1 ; gradIy1];


end
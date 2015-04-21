% ----- Calcul du gradient avec l'information d'intensite

function [ grad_Ix1 , grad_Iy1 ] = gradient_sobel( grey_image )

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
tailleGrad = size(gradIx);
gradIxDim = grad_x(2:(tailleGrad(1,1)-1) , 2:(tailleGrad(1,2)-1));
dim = size(gradIxDim);
gradIyDim = grad_y(2:(tailleGrad(1,1)-1) , 2:(tailleGrad(1,2)-1));

% Modifier la taille de la matrice: créer un vecteur ligne
grad_Ix1 = reshape(gradIxDim,dim(1,1)*dim(1,2),1);
grad_Iy1 = reshape(gradIyDim,dim(1,1)*dim(1,2),1);


end
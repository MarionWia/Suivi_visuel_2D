% ----- Calcul du gradient avec l'information d'intensite

function [ gradI ] = gradient( intensity_matrix )

% On applique les filtres Sx et Sy : filtres de Sobel

Sx = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
Sy = [1 2 1 ; 0 0 0 ; -1 -2 -1];

Gx = conv2(Sx,intensity_matrix);
Gy = conv2(Sy,intensity_matrix);

gradI = sqrt((Gx.*Gx)+(Gy.*Gy)); % module du gradient
figure;
imshow(gradI,[]);
title('Image filtree avec G');



end


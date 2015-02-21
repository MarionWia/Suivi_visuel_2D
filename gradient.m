% ----- Calcul du gradient avec l'information d'intensite

function [ gradIx , gradIy] = gradient( intensity_matrix )

% On applique les filtres Sx et Sy : filtres de Sobel

Sx = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
Sy = [1 2 1 ; 0 0 0 ; -1 -2 -1];

gradIx = conv2(Sx,intensity_matrix);
gradIy = conv2(Sy,intensity_matrix);

gradI = [gradIx ; gradIy]; % vecteur gradient 1*2

end


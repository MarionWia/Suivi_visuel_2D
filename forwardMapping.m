function [imTransforme ] = forwardMapping( rect, s, teta, u,v,I)
%forwardMapping réalise le mapping inverse

xMin = rect(1,1); % coordonnee x du point d'origine dans l'image crop par rapport a l'image initiale
yMin = rect(1,2); % coordonnee y du point d'origine dans l'image crop par rapport a l'image initiale

% Definition des quatre points de la grille dans l'image initiale
Q1 = [xMin ; yMin; 1]
Q2 = [xMin+rect(1,3); yMin; 1]
Q3 = [xMin ; yMin+rect(1,4); 1]
Q4 = [xMin+rect(1,3) ; yMin+rect(1,4);1]

% Matrice de transformation affine
matTransform = [s*cos(teta) s*sin(teta) u; -s*sin(teta) s*cos(teta) v; 0 0 1];

% Transformation inverse
invMatTransform = inv(matTransform);

% Application de la transformation pour trouver les quatre coins dans la
% deuxième image
Q1_imtransform = matTransform*Q1
Q2_imtransform = matTransform*Q2
Q3_imtransform = matTransform*Q3
Q4_imtransform = matTransform*Q4


debX = Q1_imtransform(1,1);
finX = Q2_imtransform(1,1);
debY = Q1_imtransform(2,1);
finY = Q4_imtransform(2,1);
im2Grille = I(debY:finY,debX:finX);
figure('Name','FIGURE TEST','NumberTitle','off')
imshow(im2Grille);

% calcul de l'image ou on a appliqué la transformation inverse
T = affine2d(invMatTransform');
imTransforme = imwarp(im2Grille,T);
figure('Name','region d"interet apres le warping','NumberTitle','off');
imshow(imTransforme);

end


function [ Igrey ] = untitled( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Fonction qui permet de convertir l'image en gris et en intensité

R = I(:,:,1);
V = I(:,:,2);
B = I(:,:,3);

% On creer une image intensite a partir de l'image originale I
Igrey = 0.21*R + 0.72*V + 0.07*B;% Image N°1


end


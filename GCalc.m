function [ G ] = GCalc( nbligne, nbcolonne )
%GCalc permet de calculer G

% Calcul de G
G = [];
for i=1:nbligne
    for j=1:nbcolonne
        
        jTranslate = j - nbcolonne/2;
        iTranslate = i - nbligne/2;
        G=[G;1 0 -jTranslate iTranslate;0 1 iTranslate jTranslate];
    end
end


end


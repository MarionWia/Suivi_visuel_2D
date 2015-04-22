function [ Jo ] = JCalc( nbPixel, G,gradIm )
%JCalc est une fonction qui calcule le jacobien

% Calcul de Jo
for i =1:nbPixel
    j = 2*i;
    a = (gradIm(j-1:j, :))'
    b = G(j-1:j,:)
    Jo(i,:) = a*b;
    
end

end


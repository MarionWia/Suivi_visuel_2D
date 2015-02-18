clear all;
close all;

imgInit = imread('imageOriginale_respiration.jpg');
imshow(imgInit);
img = imread('image300_respiration.jpg');
figure;
imshow(img);
u = 0;
v = 0;
teta = 0;
s = 1;
a0 = [ u ; v ; teta; s]
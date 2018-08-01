clear all, close all, clc;

foto = imread("./Exemplos/pare.jpg");

ident = preprocessing(foto);

template1 = imread("./Templates/R_1.jpg");
[fronteira1,maior_corr1] = match(ident, foto, template1);

template2 = imread("./Templates/R_3.jpg");
[fronteira2,maior_corr2] = match(ident, foto, template2);

corr = max(maior_corr1,maior_corr2);

figure, imshow(foto);
rectangle('Position', fronteira1, 'EdgeColor', 'blue', 'LineWidth', 3);
clear all, close all, clc;

[foto] = imread("pare.jpg");

template1 = imread("./Temp_placa/R_1.jpg");
[fronteira1,maior_corr1] = match(foto,template1);

template2 = imread("./Temp_placa/R_3.jpg");
[fronteira2,maior_corr2] = match(foto,template2);

corr = max(maior_corr1,maior_corr2);


figure, imshow(foto);
rectangle('Position', fronteira1, 'EdgeColor', 'blue', 'LineWidth', 3);
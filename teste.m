clear all, close all, clc;

[foto] = imread("placa-para.jpg");
figure, imshow(foto);

redplane = foto(:, :, 1);
greenplane = foto(:, :, 2);
blueplane = foto(:, :, 3);

% destaca objetos vermelhos (exemplo desse site: https://www.mathworks.com/examples/matlab/community/32661-find-green-object)
justRed = redplane - greenplane/2 - blueplane/2;

figure, imshow(justRed);
justRed = im2bw(justRed, 0.2);

%% faz abertura para tentar deixar apenas os objetos vermelhos
justRed = bwareaopen(justRed, 30);
justRed = imfill(justRed, 'holes');
justRed = imclose(justRed, strel("disk", 4, 0));
justRed = bwareaopen(justRed, 30);

figure, imshow(justRed);

%% recupera objetos que podem ser placas
conec = bwconncomp(justRed);
regioes = regionprops(conec, "basic");

figure, imshow(justRed);
figure, imshow(foto);
for i = 1:rows(regioes)
  fronteira = regioes(i).BoundingBox;
  rectangle('Position', fronteira, 'EdgeColor', 'blue', 'LineWidth', 3);
  placa = imcrop(foto, [fronteira(1) fronteira(2) fronteira(3) fronteira(4)]);
  figure, imshow(placa);
endfor
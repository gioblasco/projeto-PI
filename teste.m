clear all, close all, clc;

<<<<<<< HEAD
[foto] = imread("placa-transito.jpg");
template = imread("./Temp_placa/R_3.jpg");
=======
[foto] = imread("pare-rua3.jpg");
template = imread("./Temp_placa/teste.jpg");
>>>>>>> 19523c6187b2533e61bf396886417c1d2ac1def6
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

%% recupera objetos que podem ser placas
conec = bwconncomp(justRed);
regioes = regionprops(conec, "basic", "Perimeter");
figure, imshow(foto);

<<<<<<< HEAD
for i = 1:rows(regioes)
    fronteira = regioes(i).BoundingBox;
    placa = imcrop(foto, ajusta_bbox(fronteira, size(foto)));
    placa = im2bw(rgb2gray(placa));
    % formula de Polsby-popper para calcular compactness
    compacidade = 4*pi*regioes(i).Area/regioes(i).Perimeter^2;
    
    % descarta objetos com compacidade menor que 0.8
    if compacidade >= 0.8
      template_resized = im2bw(rgb2gray(imresize(template, size(placa))));
      correlacao(i) = corr2(placa, template_resized);
    else
      correlacao(i) = -2;
    endif
    
    figure, subplot(1,2,1), imshow(placa);
    subplot(1,2,2), imshow(template_resized);
=======
figure, imshow(foto);
for i = 1:rows(regioes)
  fronteira = regioes(i).BoundingBox;  
  placa = imcrop(foto, floor(fronteira));
  placa = im2bw(rgb2gray(placa));
  rectangle('Position', fronteira, 'EdgeColor', 'blue', 'LineWidth', 3);
  %figure, subplot(1,2,1), imshow(placa);
  template_resized = im2bw(rgb2gray(imresize(template, size(placa))));
  correlacao(i) = corr2(placa, template_resized);
  %subplot(1,2,2), imshow(template_resized), title(num2str(correlacao));
>>>>>>> 19523c6187b2533e61bf396886417c1d2ac1def6
endfor

[maior_corr, melhor_regiao] = max(correlacao)
fronteira = regioes(melhor_regiao).BoundingBox;
figure, imshow(foto);
rectangle('Position', fronteira, 'EdgeColor', 'blue', 'LineWidth', 3);
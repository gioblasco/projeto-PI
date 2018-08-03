function [found] = preprocessing(foto)
  
foto = imadjust(foto);

figure, imshow(foto);

redplane = foto(:, :, 1);
greenplane = foto(:, :, 2);
blueplane = foto(:, :, 3);

% destaca objetos vermelhos (exemplo desse site: https://www.mathworks.com/examples/matlab/community/32661-find-green-object)
justRed = redplane - greenplane/2 - blueplane/2;

%figure, imshow(justRed);
if graythresh(justRed) > 0.15
  justRed = im2bw(justRed, graythresh(justRed));
else
  justRed = im2bw(justRed, 0.15);
endif

%% faz a abertura para tentar deixar apenas os objetos vermelhos
justRed = imfill(justRed, 'holes');
justRed = imopen(justRed, strel("disk", 4, 0));

% watershed - para separar objetos mt proximos
D = bwdist(~justRed);
D = -D;
D(~justRed) = Inf;

L = watershed(D);
L(~justRed) = 0;

%% remove ruidos que sao menores que a 2% da imagem
ruido = round(rows(foto)*columns(foto)*0.002);
L = bwareaopen(L, ruido);

figure, imshow(L);

found = L;

end
function [found] = preprocessing(foto)
  
% pre-processamento para encontrar os objetos vermelhos da imagem

% ajusta os valores de intensidade da foto
foto = imadjust(foto);

redplane = foto(:, :, 1);
greenplane = foto(:, :, 2);
blueplane = foto(:, :, 3);

% destaca objetos vermelhos da imagem (exemplo desse site: https://www.mathworks.com/examples/matlab/community/32661-find-green-object)
justRed = redplane - greenplane/2 - blueplane/2;

%figure, imshow(justRed);
% se o graythresh for grande o suficiente, usa ele
if graythresh(justRed) > 0.15
  justRed = im2bw(justRed, graythresh(justRed));
else % se nao, definimos 0.15 como um threshold padrao
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

found = L;

end
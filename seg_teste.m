function [isolated] = seg_teste(img)

figure, imshow(img);

red = img(:,:,1);
max(red)
green = img(:,:,2);
blue = img(:,:,3);
% dificil definir esses parametros, pq cada imagem apresenta um vermelho diferente
rMask = red > 100;
gMask = green < 50;
bMask = blue < 100;
redObjectMask = uint8(rMask & gMask & bMask); 
isored = zeros(size(redObjectMask),'uint8');
isored(:,:,1) = img(:,:,1) .* redObjectMask;
isored(:,:,2) = img(:,:,2) .* redObjectMask;
isored(:,:,3) = img(:,:,3) .* redObjectMask;
bwImage = im2bw(isored,0);

isolated = bwImage;

figure, imshow(bwImage);
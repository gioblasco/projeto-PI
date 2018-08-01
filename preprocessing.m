function [found] = preprocessing(foto)

redplane = foto(:, :, 1);
greenplane = foto(:, :, 2);
blueplane = foto(:, :, 3);

% destaca objetos vermelhos (exemplo desse site: https://www.mathworks.com/examples/matlab/community/32661-find-green-object)
justRed = redplane - greenplane/2 - blueplane/2;

figure, imshow(justRed);
justRed = im2bw(justRed, 0.2);

%% faz fechamento para tentar deixar apenas os objetos vermelhos
justRed = bwareaopen(justRed, 30);
justRed = imfill(justRed, 'holes');
justRed = imclose(justRed, strel("disk", 4, 0));
justRed = bwareaopen(justRed, 30);

found = justRed;

end
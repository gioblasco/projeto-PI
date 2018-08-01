clear all, close all, clc;

foto = imread("./Exemplos/pare.jpg");

figure, imshow(foto);

ident = preprocessing(foto);

%% pega arquivos da pasta
folder = './Templates/';
files = dir(folder);

fronteira = [];
maior_corr = [];
for i = 3:length(files)
	template = imread(strcat('./Templates/', files(i).name));
	[fronteira(i, :), maior_corr(i, 1)] = match(ident, foto, template);
end

[corr, indcorr] = max(maior_corr);

nome = mapname(files(indcorr).name);
figure, imshow(foto), title(nome);
if(corr > 0)
  rectangle('Position', fronteira(indcorr, :), 'EdgeColor', 'blue', 'LineWidth', 3);
endif
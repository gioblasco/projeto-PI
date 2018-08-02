clear all, close all, clc;

foto = imread("./Exemplos/placas2.jpg");

figure, imshow(foto);

ident = preprocessing(foto);

figure, imshow(ident);

%% pega arquivos da pasta
folder = './RedTemplates/*.jpg';
files = dir(folder);

fronteira = [];
maior_corr = [];
[regioes, compacidades] = compactness(ident);
range = compacidades < 1 & compacidades > 0;
maximo = max(compacidades(range));

for i = 1:length(files)
	template = imread(strcat('./RedTemplates/', files(i).name));
	[fronteira(i, :), maior_corr(i, 1)] = match(foto, template, regioes, compacidades, maximo);
end

[corr, indcorr] = max(maior_corr);

figure, imshow(foto);

if(corr > 0)
  nome = mapname(files(indcorr).name);
  rectangle('Position', fronteira(indcorr, :), 'EdgeColor', 'blue', 'LineWidth', 3);
else
  nome = 'PLACA NAO IDENTIFICADA';
endif

title(nome);
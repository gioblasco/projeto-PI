% esta main eh utilizada para identificação de imagens com uma placa apenas
clear all, close all, clc;

foto = imread("./ExemplosCertos/placas3.jpg");

figure, imshow(foto);

% pega imagem pre-processada
ident = preprocessing(foto);

%% pega arquivos da pasta
folder = './RedTemplates/*.jpg';
files = dir(folder);

fronteira = [];
maior_corr = [];
proibido = [];

% calcula a compacidade/circularidade
[regioes, compacidades] = compactness(ident);
range = compacidades < 1 & compacidades > 0;
maximo = max(compacidades(range));

% faz match com cada template de placa
for i = 1:length(files)
	% leitura do template
	template = imread(strcat('./RedTemplates/', files(i).name));
	[fronteira(i, :), maior_corr(i, 1)] = match(foto, template, regioes, compacidades, maximo);
end

% pega a maior correlacao entre todos os templates
[corr, indcorr] = max(maior_corr);

% se a correlacao n for negativa e houver fronteira (ou seja, algum  objeto foi identificado)
if(corr > 0 && !isempty(fronteira))
  % checa se é proibida
  proibido = checkAllowed(foto, fronteira(indcorr,:));
  
  figure, imshow(foto);
  
  % determina nome conforme o nome do arquivo
  nome = mapname(files(indcorr).name, proibido);
  
  % desenha retangulo em volta da placa
  rectangle('Position', fronteira(indcorr, :), 'EdgeColor', 'blue', 'LineWidth', 3);
  
else % se nenhuma possivel placa foi identificada
  figure, imshow(foto);
  nome = 'PLACA NAO IDENTIFICADA';
endif

title(nome);
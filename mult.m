% esta main eh utilizada para identificação de imagens com várias placas
clear all, close all, clc;

foto = imread("./ExemplosCertos/placas3.jpg");

figure, imshow(foto);

original = foto;

%% pega arquivos da pasta
folder = './RedTemplates/*.jpg';
files = dir(folder);

% conta o numero de placas identificadas
count = 0;

notfound = 0;

% enquanto houver alguma placa para ser identificada
while notfound == 0

% pega imagem pre-processada
ident = preprocessing(foto);

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
if(corr > 0.1 && !isempty(fronteira))
  % checa se é proibida
  proibido = checkAllowed(foto, fronteira(indcorr,:));
  figure, imshow(original);
  
  % determina nome conforme o nome do arquivo
  nome = mapname(files(indcorr).name, proibido);
  title(nome);
  count = count + 1;
  
  % desenha retangulo em volta da placa
  rectangle('Position', fronteira(indcorr, :), 'EdgeColor', 'blue', 'LineWidth', 3);
  
  % colore espaco da placa identificada para nao ser identificada novamente
  ajustada = ajusta_bbox(fronteira(indcorr, :), size(foto));
  x2 = ajustada(1) + ajustada(3);
  y2 = ajustada(2) + ajustada(4);
  foto(ajustada(2):y2, ajustada(1):x2, :) = 0;
else 

   % se nenhuma possivel placa foi identificada
   if count == 0
    figure, imshow(original);
    nome = 'PLACA NAO IDENTIFICADA';
    title(nome);
   endif
   
   % nao achou mais placas
   notfound = 1;
endif

endwhile
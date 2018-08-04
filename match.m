function [fronteira, maior_corr] = match(foto, template, regioes, compacidades, maximo)

correlacao = [];
fronteira = [];
for i = 1:rows(regioes)
    fronteira = regioes(i).BoundingBox;
    placa = imcrop(foto, ajusta_bbox(fronteira, size(foto)));
    placa = im2bw(rgb2gray(placa), graythresh(placa));

    %descobrir se todos os pixels da imagem sao iguais
    pixels = sum(sum(placa));
    
	  ruido = round(rows(placa)*columns(placa)*0.001);
	  placa = bwareaopen(placa, ruido);
    
    % descarta objetos com compacidade menor que 0.8 e objetos cujos pixels são todos da mesma cor (0 ou 1)
    if ((compacidades(i,1) >= 0.8 && compacidades(i,1) < 1) || (compacidades(i,1) == maximo)) && (pixels != rows(placa)*columns(placa)) && pixels != 0
      template_resized = im2bw(rgb2gray(imresize(template, size(placa))));
      correlacao(i) = corr2(placa, template_resized);
    else
      correlacao(i) = -2;
    endif
	
	  figure, imshow(placa), title(num2str(correlacao(i)));
endfor


[maior_corr, melhor_regiao] = max(correlacao);

if length(regioes) == 0
	maior_corr = -2;
	melhor_regiao = 1;
else
  fronteira = regioes(melhor_regiao).BoundingBox;
endif

end
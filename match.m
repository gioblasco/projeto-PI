function [fronteira,maior_corr] = match(ident, foto, template)

%% recupera objetos que podem ser placas
conec = bwconncomp(ident);
regioes = regionprops(conec, "basic", "Perimeter");

for i = 1:rows(regioes)
    fronteira = regioes(i).BoundingBox;
    placa = imcrop(foto, ajusta_bbox(fronteira, size(foto)));
    placa = im2bw(rgb2gray(placa));

    % formula de Polsby-popper para calcular compactness
    compacidade = 4*pi*regioes(i).Area/regioes(i).Perimeter^2;
    
    %descobrir se todos os pixels da imagem sao iguais
    pixels = sum(sum(placa));
    
    % descarta objetos com compacidade menor que 0.8
    if compacidade >= 0.8 && (pixels != rows(placa)*columns(placa)) && pixels != 0
      template_resized = im2bw(rgb2gray(imresize(template, size(placa))));
      correlacao(i) = corr2(placa, template_resized);
    else
      correlacao(i) = -2;
    endif

endfor

[maior_corr, melhor_regiao] = max(correlacao);
fronteira = regioes(melhor_regiao).BoundingBox;
end
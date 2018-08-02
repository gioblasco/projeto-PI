function [regioes, compacidades] = compactness(ident)

%% recupera objetos que podem ser placas
conec = bwconncomp(ident);
regioes = regionprops(conec, "basic", "Perimeter");

compacidades = [];
for i = 1:rows(regioes)
    % formula de Polsby-popper para calcular compactness
    compacidades(i, 1) = 4*pi*regioes(i).Area/(regioes(i).Perimeter)^2;
	  if compacidades(i, 1) < 0.5 || compacidades(i, 1) > 1
		  compacidades(i, 1) = ((regioes(i).Perimeter)^2/regioes(i).Area)/1000;
    endif
endfor
end
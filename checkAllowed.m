function proibido = checkAllowed(foto, fronteira)
% checa se o numero de euler do objeto com a maior correlacao encontrada eh positivo
% se for negativo, possivelmente eh uma placa de proibido pois
% ha mais buracos do que objetos encontrados (1 obj, 2 buracos)

  placa = imcrop(foto, ajusta_bbox(fronteira, size(foto)));
  placa = im2bw(rgb2gray(placa), graythresh(placa));
  ruido = round(rows(placa)*columns(placa)*0.02);
  placa = bwareaopen(placa, ruido);
  placa = imfill(placa, 'holes');
  
  % neuler = numobjs - numburacos
  euler = bweuler(~placa);
  
  if euler >= 0
    proibido = 0;
  else
    proibido = 1;
  endif
 
end

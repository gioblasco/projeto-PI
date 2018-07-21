function [new] = ajusta_bbox(bb, foto_size)

new = ones(1, 4);
new(1) = bb(1);
new(2) = bb(2);
new(3) = bb(3);
new(4) = bb(4);

new = floor(new);

if new(1) < 1
  new(1) = 1;
endif

if new(2) < 1
  new(2) = 1;
endif

if new(1) + new(3) > foto_size(2)
  dif = new(1) + new(3) - foto_size(2);
  new(3) = new(3) - dif;
endif

if new(2) + new(4) > foto_size(1)
  dif = new(2) + new(4) - foto_size(1);
  new(4) = new(4) - dif;
endif

end
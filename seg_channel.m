function [maskedforSkin]=seg_channel(rgbImage)

format long g;
format compact;
 fontSize = 25;
 
 figure, imshow(rgbImage);
% impixelinfo

% % Get the dimensions of the image.  numberOfColorBands should be = 3.
 [rows, columns, numberOfColorBands] = size(rgbImage);
 %Display the original color image.
 figure, subplot(3, 2, 1);
 imshow(rgbImage);
 title('Original Color Image', 'FontSize', fontSize);
 % Enlarge figure to full screen.
 set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% % % Let's compute and display the histogram of the red channel
 [pixelCount, grayLevels] = imhist(redChannel);
 subplot(3, 2, 2); 
 bar(grayLevels, pixelCount);
 grid on;
 title('Histogram of red channel image', 'FontSize', fontSize);
 xlim([0 grayLevels(end)]); % Scale x axis manually.
 
 % Let's compute and display the histogram of the green channel
% [pixelCount, grayLevels] = imhist(greenChannel);
% subplot(3, 2, 3); 
% bar(grayLevels, pixelCount);
% grid on;
% title('Histogram of green channel image', 'FontSize', fontSize);
% xlim([0 grayLevels(end)]); % Scale x axis manually.
% 
% % Let's compute and display the histogram of the blue channel
% [pixelCount, grayLevels] = imhist(blueChannel);
% subplot(3, 2, 4); 
% bar(grayLevels, pixelCount);
% grid on;
% title('Histogram of blue channel image', 'FontSize', fontSize);
% xlim([0 grayLevels(end)]); % Scale x axis manually.

[maximo, index] = max(pixelCount)
skinPixels = redChannel > 0 & greenChannel < 50 & blueChannel > 50 & blueChannel < 150;
% Mask the image using bsxfun() function to get skin pixels.
maskedforSkin = bsxfun(@times, rgbImage, cast(skinPixels, class(rgbImage)));

% Show the skin pixels
 subplot(3, 2, 5);
 imshow(maskedforSkin);
 title('Skin Pixels', 'FontSize', fontSize);
 
 figure, imshow(maskedforSkin);
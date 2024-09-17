% Exercise 3
clear;
close all;

image = imread("exercise3.jpg");

red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

black = zeros(size(image,1),size(image,2));
just_red = cat(3, red, black, black);
just_green = cat(3, black, green, black);
just_blue = cat(3, black, black, blue);

figure ("Name","exercise3");
subplot(2,2,1), imshow(image), title("input image");
subplot(2,2,2), imshow(just_red), title("red image");
subplot(2,2,3), imshow(just_green), title("green image");
subplot(2,2,4), imshow(just_blue), title("blue image");
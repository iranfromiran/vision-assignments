% Exercise 2
clear;
close all;

rgbimage = imread("exercise2.jpg");
image = rgb2gray(rgbimage);
imageDouble = im2double(image);

horizontalD =  [-1 -2 -1; 0 0 0; 1 2 1] / 4;
h = abs(imfilter(imageDouble, horizontalD));

verticalD = [-1 0 1; -2 0 2; -1 0 1] / 4;
v = abs(imfilter(imageDouble, verticalD));

g = sqrt(h.^ 2 + v.^ 2);

figure("Name","exercise2");
subplot(2,2,1), imshow(image), title("Input image");
subplot(2,2,2), imshow(h), title("Horizontal edges");
subplot(2,2,3), imshow(v), title("Vertical edges");
subplot(2,2,4), imshow(g), title("All Edges");
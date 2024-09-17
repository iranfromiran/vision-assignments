% Exercise 4
clear;
close all;

image = imread("exercise4.jpg");
tohsv = rgb2hsv(image);
hsvImage = tohsv;

color = [0.127 0.167]; %range of yellow color
colorRange = hsvImage(:, :, 1) >= color(1) & hsvImage(:, :, 1) <= color(2);
saturation = hsvImage(:, :, 2);
saturation(~colorRange) = 0;
hsvImage(:, :, 2) = saturation;

yellowImage = hsv2rgb(hsvImage);
figure ("Name","exercise4");
subplot(1,2,1), imshow(image), title("input image");
subplot(1,2,2), imshow(yellowImage), title("yellow objects");

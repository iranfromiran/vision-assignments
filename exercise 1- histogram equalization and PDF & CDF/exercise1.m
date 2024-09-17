% Exercise 1
clear;
close all;

image = imread("exercise1.jpg");

hist = imhist(image);
PDF = hist / numel(image);
CDF = 7 * cumsum(PDF);


Eq_image=  uint8(255 * CDF(image + 1) / 7);

Eq_hist = imhist(Eq_image);
Eq_PDF = Eq_hist / numel(image);
Eq_CDF = 7 * cumsum(Eq_PDF);

figure("Name","exercise1");
subplot(2, 3, 1), imshow(image), title('Input Image');
subplot(2, 3, 2), plot(PDF), title('PDF');
subplot(2, 3, 3), plot(CDF), title('CDF');
subplot(2, 3, 4), imshow(Eq_image), title('Equalized Image');
subplot(2, 3, 5), plot(Eq_PDF), title('PDF of Equalized Image');
subplot(2, 3, 6), plot(Eq_CDF), title('CDF of Equalized Image');
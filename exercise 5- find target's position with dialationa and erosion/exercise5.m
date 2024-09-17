% Exercise 5
clear;
close all;
image = im2bw(imread("kid3.png"));
kid = im2bw(imread("kid.tif"));
kidReverse = imrotate(kid, 180);

kids = kid | kidReverse;
kidsDialate = imdilate(image, kids);

wminuskids= not(kid | kidReverse);
imageComplement = not(image);
kidsErode = imerode(imageComplement, wminuskids);
ekidsPosition = kidsDialate .* kidsErode;

figure ("Name","exercise5");
subplot(2, 4, 1); imshow(image), title("Main image");
subplot(2, 4, 2); imshow(kid), title("Target image");
subplot(2, 4, 3); imshow(kidsDialate), title("Dialate image with kids");
subplot(2, 4, 5); imshow(imageComplement), title("Image complement");
subplot(2, 4, 6); imshow(wminuskids), title("W minus kid and reverse kid");
subplot(2, 4, 7); imshow(kidsErode), title("Erode complement image with kids");
subplot(2, 4, 8); imshow(ekidsPosition), title("Position of target image");
figure(2); imshow(ekidsPosition), title("Position of target images in main image");
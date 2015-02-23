clc;
clear all;
close all;


im=imread('C:\Users\koundi\Desktop\lena.jpg');
im=rgb2gray(im);
f=imresize(im,1);
F=fft2(f);
M=size(im,1);
N=size(im,2);

PSF.h=fspecial('gaussian',[3 3], 0.5);
H=fft2(PSF.h,M,N);

noise=fspecial('gaussian',[3 3], 0.5);
Ns=fft2(noise,M,N);


G=F.*H+Ns;
g=abs(ifft2(G));
g=mat2gray(g);

restored=deconvreg(g,PSF);

restored=mat2gray(restored);
SNR=norm(F,2)/norm(g,2)

figure
subplot(1,3,1)
imshow(f);
title('Original');
subplot(1,3,2)
imshow(g);
%imagesc(g),colormap(gray);
title('Degraded');
subplot(1,3,3)
imshow(restored);
%imagesc(restored),colormap(gray);
title('Restored');

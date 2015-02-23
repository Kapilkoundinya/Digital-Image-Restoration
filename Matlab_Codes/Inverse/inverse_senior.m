clc;
close all;
clear all;

im=imread('C:\Users\koundi\Desktop\lena.jpg');
im=rgb2gray(im);
f=imresize(im,0.5);
h=ones(4,4)./8;

F=fft2(f);
H=fft2(h,256,256);

G=F.*H;
g=ifft2(G);
g=mat2gray(g);

Hinv=1.\H;

Fcap=G.*Hinv;
fcap=ifft2(Fcap);
fcap=mat2gray(fcap);

SNR=norm(F,2)/norm(Fcap-G,2)

figure
subplot(1,3,1)
imshow(f);
title('Original');
subplot(1,3,2)
imshow(g);
%imagesc(g),colormap(gray);
title('Degraded');
subplot(1,3,3)
imshow(fcap);
%imagesc(fcap),colormap(gray);
title('Restored');





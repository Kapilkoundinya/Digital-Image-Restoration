clc;
close all;
clear all;

im=imread('C:\Users\koundi\Desktop\lena.jpg');
im=rgb2gray(im);
f=imresize(im,0.5);
h=ones(4,4)./8;
n=randn(256,256);

F=fft2(f);
H=fft2(h,256,256);
N=fft2(randn);

G=F.*H+N;
g=ifft2(G);

Hinv=1.\H;

Fcap=G.*Hinv;
fcap=ifft2(Fcap);

SNR=norm(F,2)/norm(G,2)

figure
subplot(1,3,1),imshow(f);
title('Original');
subplot(1,3,2),imshow(g);
title('Degraded');
subplot(1,3,3),imshow(fcap);
title('Restored');





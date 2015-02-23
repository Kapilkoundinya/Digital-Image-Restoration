clc;
clear all;
close all;

im=imread('C:\Users\koundi\Desktop\lena.jpg');
im=rgb2gray(im);
f=imresize(im,0.5);
imshow(f),title('Original');



h=ones(4,4)/4^2;
F=fft2(f);
H=fft2(h,256,256);
G=F.*H;
g=abs(ifft2(G));
figure,imagesc(g),colormap(gray),title('Degraded');
Hinv=ones(256,256)*pinv(H);
Fcap=G.*Hinv;
fcap=ifft2(Fcap);

figure, imagesc(abs(fcap)),colormap(gray),title('Restored');
SNR=norm(F,2)/norm(g,2);
clc;
close all;
clear all;

img=imread('C:\Users\koundi\Desktop\lena.jpg'); %input image in spatial domain
noise = input('Enter the magnitude for the noise signal : ');
img=rgb2gray(img);

F= fft2(img);   %input image in freq domain
subplot(1,3,1)
imshow(img);
title('original');

M=size(img,1);
N=size(img,2);
h = fspecial('gaussian', [3 3], 0.5); %channel and noise in spatial domain
H= fft2(h,M,N); %channel in freq domain

Mean=0;
Var=0.001;
n=fspecial('gaussian', [3 3], 0.5);
%n=noise*rand(M,N);
Ns=fft2(n,M,N); %noise in freq domain

G= F.*H +Ns;   %degraded image
g = abs(ifft2(G));
g= mat2gray(g);
subplot(1,3,2)
imshow(g);
title('degraded');


%q=fspecial('laplacian');
%Q=fft2(q,M,N);

lambda=1;
Fcap = zeros(M,N);
for k1=1:M
for k2=1:N
Fcap(k1,k2) = ( conj( H(k1,k2) ) / ( pow2( abs( H(k1,k2) ) )+ lambda^-1 ) )* G(k1,k2);
end
end

fcap = abs(ifft2(Fcap));
fcap= mat2gray(fcap);
subplot(1,3,3);
%imagesc(fcap),colormap(gray);
imshow(fcap);,title('Restored');

SNR = norm(Fcap,2)/norm(Ns,2)
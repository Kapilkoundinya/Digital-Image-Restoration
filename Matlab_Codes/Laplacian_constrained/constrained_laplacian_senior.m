clc;
close all;
clear all;

img=imread('C:\Users\koundi\Desktop\lena.jpg');
noise = input('Enter the magnitude for the noise signal : ');
img=rgb2gray(img);

F= fft2(img);
subplot(1,3,1)
imshow(img);
title('original');

M=size(img,1);
N=size(img,2);

h = fspecial('gaussian', [3 3], 0.5);
H= fft2(h,M,N);

Ns=fft2(h,M,N);

G= F.*H +Ns;
g = abs(ifft2(G));
g=mat2gray(g);
subplot(1,3,2)
imshow(g);
title('degraded');



q=fspecial('laplacian');
Q=fft2(q,M,N);
lambda=1;
Fcap = zeros(M,N);
Hstar=conj(H);
for k1=1:M
for k2=1:N
Fcap(k1,k2) = (Hstar(k1,k2)/(pow2(abs(H(k1,k2))))+lambda^-1*(pow2(abs(Q(k1,k2)))))*G(k1,k2);
end
end

fcap = abs(ifft2(Fcap));
fcap=mat2gray(fcap);

subplot(1,3,3);
imshow(fcap);
%imagesc(fcap),colormap(gray);
title('Restored');

SNR = norm(Fcap,2)/norm(Ns,2)


clc;
close all;
clear all;
img=imread('C:\Users\koundi\Desktop\lena.jpg');
noise = input('Enter the magnitude for the noise signal : ');
img=rgb2gray(img);
F= fft2(img);
subplot(1,3,1)
imshow(img);
M=size(img,1);
N=size(img,2);
h = fspecial('gaussian', [3 3], 0.5);
H= fft2(h,M,N);
n=noise*randn(M,N);
Ns=fft2(n,M,N);
G= F.*H +Ns;
subplot(1,3,2)
imshow(G);
g = abs(ifft2(G));
q=fspecial('laplacian');
Q=fft2(q,M,N);
lambda=1;
Fcls=zeros(M,N);
29
for k1=1:M
for k2=1:N Fcls(k1,k2)=conj(H(k1,k2))*G(k1,k2)/abs(H(k1,k2))^2+(1/(2*lambda));
end;
end;
f=ifft2(Fcls);
subplot(1,3,3)
imagesc(f);
colormap(gray)
SNR=norm(F,2)/norm(Ns,2)
clc;
close all;
clear all;

%input
img=imread('C:\Users\koundi\Desktop\lena.jpg'); %input image in spatial domain
noise = input('Enter the magnitude for the noise signal : ');
img=rgb2gray(img);
F= fft2(img); %input image in freq domain
M=size(img,1); %rows of input image
N=size(img,2);  %columns of the input image

%channel 
h = fspecial('gaussian', [3 3], 0.5); %channel in spatial domain
H= fft2(h,M,N); %channel in freq domain

%Noise
n=noise*randn(M,N); %Noise in spatial domain
Ns=fft2(n,M,N); %noise in freq domain

%Degradation
G= F.*H +Ns;  %degraded image in spatial domain
g = abs(ifft2(G)); %degraded image in freq domain


%Restoration
q=fspecial('laplacian');
Q=fft2(q,M,N);
lamda=1;
Fcls=zeros(M,N);
for k1=1:M
for k2=1:N
Fcls(k1,k2)=(conj(H(k1,k2))*G(k1,k2))/(abs(H(k1,k2)))^2+lamda^-1*(abs(Q(k1,k2))^2); %restored image in freq domain
end;
end;
f=ifft2(Fcls); 

%SNR calculation
SNR=norm(F,2)/norm(Ns,2)

%Plotting of Results
subplot(1,3,1)
imshow(img);
title('original')
subplot(1,3,2)
g=mat2gray(g);
imshow(g);
title('destorted')
subplot(1,3,3)
imagesc(f);
colormap(gray)

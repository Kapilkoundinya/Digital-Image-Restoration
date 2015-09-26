clc;
close all;
clear all;

%input 
img=imread('C:\Users\koundi\Desktop\lena.jpg'); %input image in spatial domain
img=rgb2gray(img);
F= fft2(img);   %input image in freq domain
M=size(img,1);  %rows of input image
N=size(img,2);  %columns of the input image


%channel 
h=ones(M,N); %channel in spatial domain
H=fft2(h,M,N); %channel in freq domain

%Noise 
n=randn(M,N); %Noise in spatial domain
Ns=fft2(n,M,N); %noise in freq domain

%Degradation
G= F.*H +Ns;   %degraded image in spatial domain
g = abs(ifft2(G)); %degraded image in freq domain
g=mat2gray(g);

%Restoration
Fcap = G./H;
fcap = abs(ifft2(Fcap)); %restored image in freq domain
fcap= mat2gray(fcap);

%SNR calculation
SNR = norm(Fcap,2)/norm(Ns,2)


%Plotting of Results
figure;
subplot(1,3,1)
imshow(img);
title('original');
subplot(1,3,2)
imshow(g);
title('degraded');
subplot(1,3,3);
imshow(fcap),title('Restored');




clc;
close all;
clear all;

%input 
img=imread('C:\Users\koundi\Desktop\lena.jpg'); %input image in spatial domain
img=rgb2gray(img);
F= fft2(img);   %input image in freq domain
M=size(img,1);  %rows of input image
N=size(img,2);  %columns of the input image
image_vector=im2col(img);
rf=autocorr(img); %autocorrelation function of input image
sf=fft(rf); %powerspectral density of input

%channel 
h = fspecial('gaussian', [3 3], 0.5); %channel in spatial domain
H= fft2(h,M,N); %channel in freq domain
%h=ones(M,N);
%H=fft2(h,M,N);
%Noise 
noise = input('Enter the magnitude for the noise signal : ');
n = fspecial('gaussian', [3 3], 0.5); %Noise in spatial domain
Ns=fft2(n,M,N);
noise_vector=im2col(n)
rn=autocorr(noise);
sn=fft2(rn);  %powerspectral density of input
%n=randn(M,N);
%Ns=fft2(n,M,N); %noise in freq domain

%Degradation
G= F.*H+Ns ;   %degraded image in spatial domain
g = abs(ifft2(G)); %degraded image in freq domain


%Restoration
lambda=1;
Fcap = zeros(M,N);
for k1=1:M
for k2=1:N
Fcap(k1,k2) = ( conj( H(k1,k2) ) / ( pow2( abs( H(k1,k2) ) )+ lambda^-1*(  sn(k1,k2) / sf(k1,k2) )  )  )* G(k1,k2); % restored image in spatial domain
end
end
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
imshow(G);
title('degraded');
subplot(1,3,3);
imshow(fcap),title('Restored');




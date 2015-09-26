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
h=ones(4,4)./8; %channel in spatial domain
H=fft2(h,M,N); %channel in freq domain


%Degradation
G= F.*H ;   %degraded image in spatial domain
g = (ifft2(G)); %degraded image in freq domain
g=mat2gray(g);


%Restoration
Hin=1./H;
Fcap = G.*Hin;
fcap = abs(ifft2(Fcap)); %restored image in freq domain
fcap= mat2gray(fcap);

%SNR calculation
SNR = norm(F,2)/norm(Fcap-G,2)


%Plotting of Results
figure;
subplot(1,3,1)
imshow(img);
title('original');
subplot(1,3,2)
imshow(g);
title('degraded');
subplot(1,3,3);
imshow(fcap);
title('Restored');




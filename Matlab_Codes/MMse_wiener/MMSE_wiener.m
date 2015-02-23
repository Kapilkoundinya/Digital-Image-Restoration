clc;
clear all;
close all;

%input 
RGB=imread('C:\Users\koundi\Desktop\lena.jpg'); %input image in spatial domain
org = rgb2gray(RGB);

%Degradation
degr=imnoise(org,'gaussian',0,0.005);

%In built Wiener Functions
rest10=wiener2(degr,[10 10]);
rest6=wiener2(degr,[6 6]);
p=double(0);
disp(p);
for x=1:1:256
disp(p);
for y=1:1:256
q=double((org(x,y)).^2)/((org(x,y)-rest6(x,y)).^2);
p=p+q;
end;
end;

%SNR calculation
SNR=norm(double(rest10))/norm(double(degr))

%Pltoting the Results
figure
subplot(2,2,1)
imshow(org),title('Original');
subplot(2,2,2)
imshow(degr),title('Degraded');
subplot(2,2,3)
imshow(rest10),title('Restoration10');
subplot(2,2,4)
imshow(rest6),title('Restoration6');



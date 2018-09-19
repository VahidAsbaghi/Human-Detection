%% Function sobel_xy
function [alpha_max1,alpha11]=sobel_xy(im_eye)
%% this function: do sobel edge detection operator and find angle of edges
%% directions

%% ************************************************************************
im_eye11=histeq(im_eye); %histogram equalization process

% comparative filter
M=mean(mean(im_eye11)); 
h=(1/9)*ones(3,3);
m=imfilter(im_eye11,h);
sigma=(im_eye11-m).^2;
sigma1=imfilter(sigma,h)+0.1;
A=0.1*M./sigma1;
im_eye12=A.*(im_eye11-m)+m;
% end of comparative filter
hh=(1/25)*ones(5,5); 
im_new1=imfilter(im_eye12,hh,'same'); %smooth image by a 5*5 average filter for noise reduction

im_eye=im_new1;

sobel_x=[-1,-2,-1;0,0,0;1,2,1]; %sobel operator on x direction
sobel_y=[-1,0,1;-2,0,2;-1,0,1]; %sobel operator on y direction
eye_x=imfilter(im_eye,sobel_x,'symmetric'); %filtering image by sobel in x direction
eye_y=imfilter(im_eye,sobel_y,'symmetric'); %filtering image by sobel in y direction

alpha=atand(double(double(eye_x)./double(eye_y))); %compute angle of gradient of edges
alpha11=alpha;

%quantization process of angles in 14 angles
a1=alpha>=85;
alpha(a1)=90;
bm(1)=sum(sum(a1));
a2=alpha>=80 & alpha<85;
alpha(a2)=85;
bm(2)=sum(sum(a2));
a2=alpha>=75 & alpha<80;
alpha(a2)=80;
bm(3)=sum(sum(a2));
a2=alpha>=70 & alpha<75;
alpha(a2)=75;
bm(4)=sum(sum(a2));
a2=alpha>=65 & alpha<70;
alpha(a2)=70;
bm(5)=sum(sum(a2));
a2=alpha>=60 & alpha<65;
alpha(a2)=65;
bm(6)=sum(sum(a2));
a2=alpha>=55 & alpha<60;
alpha(a2)=60;
bm(7)=sum(sum(a2));
a2=alpha>=50 & alpha<55;
alpha(a2)=55;
bm(8)=sum(sum(a2));
a2=alpha>=45 & alpha<50;
alpha(a2)=50;
bm(9)=sum(sum(a2));
a2=alpha>=40 & alpha<45;
alpha(a2)=45;
bm(10)=sum(sum(a2));
a2=alpha>=35 & alpha<40;
alpha(a2)=40;
bm(11)=sum(sum(a2));
a2=alpha>=30 & alpha<35;
alpha(a2)=35;
bm(12)=sum(sum(a2));
a2=alpha>=25 & alpha<30;
alpha(a2)=30;
bm(13)=sum(sum(a2));
a2=alpha>=20 & alpha<25;
alpha(a2)=25;
bm(14)=sum(sum(a2));
a2=alpha>=15 & alpha<20;
alpha(a2)=20;
bm(15)=sum(sum(a2));
a2=alpha>=10 & alpha<15;
alpha(a2)=15;
bm(16)=sum(sum(a2));
a2=alpha>=5 & alpha<10;
alpha(a2)=10;
bm(17)=sum(sum(a2));
a2=alpha>=0 & alpha<5;
alpha(a2)=5;
bm(18)=sum(sum(a2));
[~,II]=sort(bm,'descend'); %sort based on number of representation of angles
alpha_max1=abs(II-19)*5;
a1=isnan(alpha);
alpha(a1)=0;


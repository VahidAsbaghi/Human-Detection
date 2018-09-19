%% Function hough_circle_2
function [xc,yc,Ix1,Iy1,rr1]=hough_circle_2(im1,Ix,Iy,rr,flag1)
%% 
% this function based on hough transform and region growing method 
% find outer boundary of iris.
%% ************************************************************************
% using of a special comparative filter for denoising and sharpening of
% weak edges
im11=double(im1);
M=mean(mean(im11));
h=(1/9)*ones(3,3);
m=imfilter(im11,h);
sigma=(im11-m).^2;
sigma1=imfilter(sigma,h)+0.1;
A=.001*M./sigma1;
im2=A.*(im11-m)+m;

[lx,ly]=size(im1);


% region growing algorithm
rp=rr+20; %start from 20+(radius of pupil) for find iris radius
def=0;
flag=0;
while def<20 && flag==0
    rp=rp+1;
    Ixp=Ix;
    Iyp=Iy;
    xcp=round(Iyp+rp*cos(-pi/6:0.01:pi/6));
    ycp=round(Ixp+rp*sin(-pi/6:0.01:pi/6));
    xcp1=round(Iyp+rp*cos(pi-pi/6:0.01:pi+pi/6));
    ycp1=round(Ixp+rp*sin(pi-pi/6:0.01:pi+pi/6));
    xcs=round(Iyp+(rp+5)*cos(-pi/6:0.01:pi/6));
    ycs=round(Ixp+(rp+5)*sin(-pi/6:0.01:pi/6));
    xcs1=round(Iyp+(rp+5)*cos(pi-pi/6:0.01:pi+pi/6));
    ycs1=round(Ixp+(rp+5)*sin(pi-pi/6:0.01:pi+pi/6));
    l_ycs=length(ycs);
    l_ycs1=length(ycs1);
    l_xcs=length(xcs);
    l_xcs1=length(xcs1);
    if isequal(double(ycs<lx),ones(1,l_ycs)) && isequal(double(ycs1<lx),ones(1,l_ycs1)) && isequal(double(xcs<ly),ones(1,l_xcs)) && isequal(double(xcs1<ly),ones(1,l_xcs1)) && isequal(double(ycs>=1),ones(1,l_ycs)) && isequal(double(ycs1>=1),ones(1,l_ycs1)) && isequal(double(xcs>=1),ones(1,l_xcs)) && isequal(double(xcs1>=1),ones(1,l_xcs1))
        def=mean(mean(abs(im2(ycp,xcp)-im2(ycs,xcs))+abs(im2(ycp1,xcp1)-im2(ycs1,xcs1))));
    else
        flag=-1;
    end
end

xc=Ixp+rp*cos(0:0.01:2*pi); %find x component of boundary
yc=Iyp+rp*sin(0:0.01:2*pi); %find y component of boundary coordinates based on parametric formula of circle
Ix1=Ixp;
Iy1=Iyp;
rr1=rp;

%plot boundary of iris
if flag1~=1
figure;
imshow(im1,[]);
hold on;
plot(yc,xc);
end
% plot(xcp,ycp);
% plot(xcp1,ycp1);
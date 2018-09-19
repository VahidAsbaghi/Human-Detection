%% Function hough_circle
function [xc,yc,Ix,Iy,rr]=hough_circle(im1,flag)
%% Function Find pupil boundary of eye image
% 1- edge detection based on sobel
% 2- find best circle boundary based on hough
%% ************************************************************************
im_edge=edge(im1,'sobel'); % sobel edge detection

im=im_edge;

[lx,ly]=size(im);

tt=im==1;
xtx=round(0.3*lx);
yty=round(0.2*ly);
i=0;
% hough algorithm for circle detection
for l=xtx:lx-xtx
    i=i+1;
    j=0;
    for p=yty:ly-yty
        j=j+1;
        r{i,j}=uint(round((repmat(((1:lx)-l).^2,ly,1)+repmat((((1:ly)-p).^2)',1,lx)).^0.5));
        rol=r{i,j}.MantBits';
        [param_mat(i,j),F(i,j)]=mode(rol(tt));
    end
end
[Fx,Ix]=max(F);
[~,Iy]=max(Fx);
rr=param_mat(Ix(Iy),Iy);
while rr>40
    F(Ix(Iy),Iy)=0;
    [Fx,Ix]=max(F);
    [~,Iy]=max(Fx);
    rr=param_mat(Ix(Iy),Iy);
end
%
%
xc=Ix(Iy)+rr*cos(0:0.01:2*pi)+xtx-1; % x parameters of pupil circle
yc=(Iy)+rr*sin(0:0.01:2*pi)+yty-1; % y parameters of pupil circle
Ix=Ix(Iy);
Iy=Iy+yty-1;
Ix=Ix+xtx-1;

% show pupil boundary
if flag~=1
figure;
imshow(im1,[]);
hold on;
plot(yc,xc,'r');
end

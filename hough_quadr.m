%% Function hough_quadr
function [y,a,b,c]=hough_quadr(im1)
%% This Function: determine upper eyelash boundary based on hough transform
% 1- edge detection based on sobel operator and automatic thresholding
% 2- implement hough transform to find upper eyelash boundary
%%
im_edge=edge(im1,'sobel'); %sobel edge detection operator
im=im_edge;
[lx,ly]=size(im);

% hough transform algorithm
tt=im==1;
k=0;
for i=0.001:0.001:0.01
    k=k+1;
    l=0;
    for j=-0.95:0.01:-0.9
        l=l+1;
        c{k,l}=uint(round((repmat(1:lx,ly,1)-i*repmat((1:ly)',1,lx).^2-j*repmat((1:ly)',1,lx))));
        rol=c{k,l}.MantBits';
        [param_mat(k,l),F(k,l)]=mode(rol(tt));
    end
end
[F1,Ix]=max(F);
[F2,Iy]=max(F1);
Ix=Ix(Iy);
b1=param_mat(Ix,Iy);

a=0.001+(Ix-1)*0.001;
b=(-0.95+(Iy-1)*0.01);
c=b1;
y=a*((1:ly).^2)+b*(1:ly)+b1;
figure;
imshow(im1,[]);
hold on;
plot((1:ly),y,'r');

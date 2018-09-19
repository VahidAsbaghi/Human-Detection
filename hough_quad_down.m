%% Function hough_quad_down
function [y,a,b,c1]=hough_quad_down(im1)
%% This Function compute down eyelash boundary curve
% 1- canny edge detection 
% 2- emplement hough transform algorithm to find polynomial with degree two
% for down eyelash curve
%% 
[lx,ly]=size(im1);

im_edge=edge(im1,'canny'); %canny edge detection

%emplement hough transform
im=im_edge;
tt=im==1;
k=0;
for i=-0.01:0.001:0 % change 'a' value with 0.001 step
    k=k+1;
    l=0;
    for j=0.5:0.01:0.9 %change 'b' value with 0.01 step
        l=l+1;
        c{k,l}=uint(round((repmat(1:lx,ly,1)-i*repmat((1:ly)',1,lx).^2-j*repmat((1:ly)',1,lx)))); %compuet 'c' value for given 'a','b' and each pixel coordinates
        rol=c{k,l}.MantBits';
        [param_mat(k,l),F(k,l)]=mode(rol(tt)); 
    end
end
[F1,Ix]=max(F); %select 'c' value with maximum representation on pixeles for a given 'a','b'
[F2,Iy]=max(F1);
Ix=Ix(Iy);
b1=param_mat(Ix,Iy);
a=(-0.01+(Ix-1)*0.001); 
b=(0.5+(Iy-1)*0.01);
c1=b1;
y=a*((1:ly).^2)+b*(1:ly)+b1; %compute curve 'y' coordinate values
figure;
imshow(im1,[]);
hold on;
plot(1:ly,y,'r');
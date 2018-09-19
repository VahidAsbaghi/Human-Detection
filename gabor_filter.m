%% Function gabor_filter
function [fn]=gabor_filter(map,flag)
%% This Function DO:
% 1- do histogram equalization of image\
% 2- Define real gabor filter collection on 16 angle from 0 to 2*pi
% 3- Filter image with every filter on each direction
% 4- Do main feature extraction based on sobel operator and find main edges
% directions for each window of original image
% 5- Make main feature vector 
%% ************************************************************************
[lx,ly]=size(map);
map1=map(1:round(2*lx/3),:);
map3=histeq(map1); %histogram equalization

[lx,ly]=size(map3);

% define variables for gabor filter
ul=0.1;
uh=0.4;
M=50;
m=0;
N=8;
x0=1;
y0=1;
teta=[0,pi/8,pi/4,3*pi/8,pi/2,5*pi/8,6*pi/8,7*pi/8,pi,9*pi/8,10*pi/8,11*pi/8,12*pi/8,13*pi/8,14*pi/8,15*pi/8];
u0=uh;
v0=0.01;
sigmax=0.1;
sigmay=10;
sigmau=(1/2*pi)*sigmax;
sigmav=(1/2*pi)*sigmay;

up=repmat((1:lx)/lx,ly,16).*[repmat(cos(teta(1)),ly,lx),repmat(cos(teta(2)),ly,lx),repmat(cos(teta(3)),ly,lx),repmat(cos(teta(4)),ly,lx),repmat(cos(teta(5)),ly,lx),repmat(cos(teta(6)),ly,lx),repmat(cos(teta(7)),ly,lx),repmat(cos(teta(8)),ly,lx),repmat(cos(teta(9)),ly,lx),repmat(cos(teta(10)),ly,lx),repmat(cos(teta(11)),ly,lx),repmat(cos(teta(12)),ly,lx),repmat(cos(teta(13)),ly,lx),repmat(cos(teta(14)),ly,lx),repmat(cos(teta(15)),ly,lx),repmat(cos(teta(16)),ly,lx)]+repmat((1:ly)'/ly,1,16*lx).*[repmat(sin(teta(1)),ly,lx),repmat(sin(teta(2)),ly,lx),repmat(sin(teta(3)),ly,lx),repmat(sin(teta(4)),ly,lx),repmat(sin(teta(5)),ly,lx),repmat(sin(teta(6)),ly,lx),repmat(sin(teta(7)),ly,lx),repmat(sin(teta(8)),ly,lx),repmat(sin(teta(9)),ly,lx),repmat(sin(teta(10)),ly,lx),repmat(sin(teta(11)),ly,lx),repmat(sin(teta(12)),ly,lx),repmat(sin(teta(13)),ly,lx),repmat(sin(teta(14)),ly,lx),repmat(sin(teta(15)),ly,lx),repmat(sin(teta(16)),ly,lx)];
vp=-repmat((1:lx)/lx,ly,16).*[repmat(sin(teta(1)),ly,lx),repmat(sin(teta(2)),ly,lx),repmat(sin(teta(3)),ly,lx),repmat(sin(teta(4)),ly,lx),repmat(sin(teta(5)),ly,lx),repmat(sin(teta(6)),ly,lx),repmat(sin(teta(7)),ly,lx),repmat(sin(teta(8)),ly,lx),repmat(sin(teta(9)),ly,lx),repmat(sin(teta(10)),ly,lx),repmat(sin(teta(11)),ly,lx),repmat(sin(teta(12)),ly,lx),repmat(sin(teta(13)),ly,lx),repmat(sin(teta(14)),ly,lx),repmat(sin(teta(15)),ly,lx),repmat(sin(teta(16)),ly,lx)]+repmat((1:ly)'/ly,1,16*lx).*[repmat(cos(teta(1)),ly,lx),repmat(cos(teta(2)),ly,lx),repmat(cos(teta(3)),ly,lx),repmat(cos(teta(4)),ly,lx),repmat(cos(teta(5)),ly,lx),repmat(cos(teta(6)),ly,lx),repmat(cos(teta(7)),ly,lx),repmat(cos(teta(8)),ly,lx),repmat(cos(teta(9)),ly,lx),repmat(cos(teta(10)),ly,lx),repmat(cos(teta(11)),ly,lx),repmat(cos(teta(12)),ly,lx),repmat(cos(teta(13)),ly,lx),repmat(cos(teta(14)),ly,lx),repmat(cos(teta(15)),ly,lx),repmat(cos(teta(16)),ly,lx)];
map_fft=(fft2(map3));
fn=cell(16,1);
fz=[];
for i=1:16
    G=exp(-0.5*((up(:,(i-1)*lx+1:i*lx)-u0).^2/(sigmau^2)+((vp(:,(i-1)*lx+1:i*lx)-v0).^2/(sigmav^2))))+cos(-2*pi*(x0*(up(:,(i-1)*lx+1:i*lx)-u0)+y0*(vp(:,(i-1)*lx+1:i*lx)-v0))); %make gabor filter for each angle
    
    map_F=map_fft.*G'; % filter windowed image in fourier domain
    
    gabor_map=ifft2(map_F); %inverse fft
    gabor_map1=abs(gabor_map);
    m1=min(min(gabor_map1));
    m2=max(max(gabor_map1));
    gabor_map2=(gabor_map1-m1)*255/(m2-m1);
    
    if i==1 && flag~=1
        figure;
        imshow(gabor_map2,[]);
        title('Gabor Filtered Map Image for Zero Angle Filter');
    end
    ghg=gabor_map2(15:round(0.9*lx),1:round(0.8*ly));
    [lx1,ly1]=size(ghg);
    ff=[];
    kk=20;
    % feature extracting based on sobel operator
    for jj=0:5:ly1-kk
        for ii=0:5:lx1-20
            gg=round(ghg(ii+1:ii+20,jj+1:jj+kk));
            [alpha_max1,~]=sobel_xy(uint8(gg));
            ff=[ff;(alpha_max1(3:6))'];
        end
    end    
    fn{i,1}=ff;    %feature vector construction
    fz=[ff,fz];    
end
imfz=max(fz,[],2);

fn{17,1}=imfz;
fn{18,1}=mean(fz,2);

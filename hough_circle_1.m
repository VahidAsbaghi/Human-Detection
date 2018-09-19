%% Function hough_circle_1
function [xc,yc,Ix1,Iy1,rr1]=hough_circle_1(im1,Ix,Iy,rr,a,b,c,a1,b1,c1)
%% Function find outer boundary of iris based on hough
% 1- smooth image for noise remove using 3*3 average filter
% 2- edge detection based on canny approach
% 3- remove edge points upper than upper eyelash and lower than lower
% eyelash
% 4- using hough transform find circle bound of iris
%% ************************************************************************
[llx,lly]=size(im1);

     h=(1/9)*ones(3,3); % 1-

    im11=imfilter(im1,h);
   
    im_edge1=edge(im11,'canny'); %2-
    
    im_edge=im_edge1;

    im_edge(1:2,:)=0;
    im_edge(:,1:2)=0;
    im_edge(llx-3:llx,:)=0;
    im_edge(:,lly-3:lly)=0;
    im=im_edge;
[lx,ly]=size(im1);
%3-
y_up1=a*((1:ly).^2)+b*(1:ly)+c+10;
y_down=a1*((1:ly).^2)+b1*(1:ly)+c1;
for i=1:ly
    if y_up1(i)>=0 
        im(1:uint8(round(y_up1(i))),i)=0;
    end
     if y_down(i)>0.5 
        im(uint16(round(y_down(i))):lx,i)=0;
     end
    for j=1:lx
        if ((i-Ix)^2+(j-Iy)^2)^0.5<rr+10
            im(i,j)=0;
        end
    end   
end

%4-
tt=im==1;
xtx=round(0.3*lx);
yty=round(0.2*ly);
i=0;
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
[Fx,Ix1]=max(F);
[FF,Iy1]=max(Fx);
rr1=param_mat(Ix1(Iy1),Iy1);

    xc=Ix1(Iy1)+rr1*cos(0:0.01:2*pi)+xtx;
    yc=(Iy1)+rr1*sin(0:0.01:2*pi)+yty;
    Ix1=Ix1(Iy1)+xtx;
    Iy1=Iy1+yty;

% figure;
% imshow(im1,[]);
% hold on;
% plot(yc,xc);
% plot(xcp,ycp);
% plot(xcp1,ycp1);
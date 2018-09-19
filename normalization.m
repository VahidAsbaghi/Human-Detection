%% Function normalization
function map=normalization(im_eye,Ix,Iy,Ix1,Iy1,rr,rr1,flag)
%% This function: normalize iris circular image on a rectangular image in
%% 'r' and 'teta' domain 
%% ************************************************************************
i=0;
[lx,ly]=size(im_eye);

ll=((2*(Ix-Ix1))^2+(2*(Iy-Iy1))^2)^0.5; %compute distnaces between iris and pupil center coordinates
teta=atan((Iy-Iy1)/(Ix-Ix1)); %compute angle of slope of line 'll'
if isnan(teta)
    teta=0;
end
for l=0:0.01:2*pi % sampling of iris image on angle with 0.01 step
    i=i+1;
    lp=2*rr1+abs(ll*cos(teta-l))-2*rr;

    pr=lp/100;
    k=0;
    while k<99 % sampling of iris in each angle on radius direction as 100 samples
       alpha=(k^1.5/9.55);
       kk=(alpha)+2;
       x=2*Iy+(2*rr+(kk)*pr)*cos(l);
       y=2*Ix+(2*rr+(kk)*pr)*sin(l);
       if x<=ly && y<=lx && x>0.5 && y>0.5
           map(k+1,i)=im_eye(round(y),round(x));
       else
           map(k+1,i)=0;
       end
       k=k+1;
    end
end
if flag~=1
figure;
imshow(map,[]);
title('Map Normalized Iris Image');
end
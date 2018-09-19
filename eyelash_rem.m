function imp=eyelash_rem(im2,Ix,Iy)
x0=2*Ix;
y0=2*Iy;
% figure;
% imshow(im2,[]);
[lx,ly]=size(im2);
imp=double(im2);
for k=1:5
for i=11:ly-10
    for j=11:x0-10
        f=double(imp(j,i+1)+imp(j,i+2)+imp(j,i+3)+imp(j,i+4)+imp(j,i-1)+imp(j,i-2)+imp(j,i-3)+imp(j,i-4))/8;
        t=imp(j,i);
        if f-t>30
            z=(1/438)*(sum(sum(imp(j-10:j+10,i-10:i+10)))-imp(j,i)-imp(j,i+1)-imp(j,i-1));
            imp(j,i)=z;
            if imp(j,i)>200
                 imp(j,i)=im2(j,i);
            end
        end
        
    end
end
end
figure;
imp=uint8(round(imp));
imshow(((imp)),[]);

%% Main Function
function main(NN,NN1,flag)
%% this function is main implemented function on determining feature
%% vectors for each person. each person have 7 eye image in dataset. 108 person are in dataset
%% ************************************************************************
dir1='CA\CA1\'; %read CASIA V.1 main address in root address of program 
dirlist1=dir(dir1);
co=0;
f_mat=cell(18,1);

class1=zeros((NN1-NN+1)*7,1); %define class vector of each image firstly zero
tic();
for i=NN+2:NN1+2 % person numbers from NN to NN1 that selected by user
    u=[dir1 dirlist1(i).name '\1\']; % '1' address that contain 3 images
    u1=[dir1 dirlist1(i).name '\2\']; % '2' address that contain 4 images
    url1=dir(u);
    for j=3:5  % first read 3 images in '1' directory
        co=co+1;
        im_eye=imread([u url1(j).name]); % read eye images
        [lx,ly]=size(im_eye);  
        im1=imresize(im_eye,[round(0.5*lx),round(0.5*ly)]); % resize images to 50% of original size
        [~,~,Ix,Iy,rr]=hough_circle(im1,flag);  % compute pupil boundary with a circle
%         im2=im1;
%         imp=eyelash_rem(im2,Ix,Iy);
%         [y,a,b,c]=hough_quadr(imp);
%         [y,a1,b1,c1]=hough_quad_down(imp);
        % IMPORTANT: IF YOU WANT IMPLEMENT ALGORITHM WITH FIRST METHOD:
        % 1- UNCOMMENT LINES 23,24,25,26,30 LINE AS EXECUTABLE LINE BY REMOVE '%' 
        % 2- SELSET LINE 31 OF THIS FUNCTION AS COMMENT WITH '%' CHARACTER 
        %[xc1,yc1,Ix1,Iy1,rr1]=hough_circle_1(im1,Ix,Iy,rr,a,b,c,a1,b1,c1);
        [xc,yc,Ix1,Iy1,rr1]=hough_circle_2(im1,Ix,Iy,rr,flag); %find outer boundary of iris
        map=normalization(im_eye,Ix,Iy,Ix1,Iy1,rr,rr1,flag); %normalize iris image on a rectangular map
        class1(1,co)=i-2; %set class number to each image
        [fn]=gabor_filter(uint8(map),flag); %make feature vector based on gabor filters
        for ii=1:18
            f_mat{ii,1}(:,co)=fn{ii,1};
        end
     end
    url1=dir(u1);
    for j=3:6 %secondly read eye images in '2' directory
        co=co+1;
        im_eye=imread([u1 url1(j).name]);
        [lx,ly]=size(im_eye);
        im1=imresize(im_eye,[round(0.5*lx),round(0.5*ly)]);
        [~,~,Ix,Iy,rr]=hough_circle(im1,flag);
%         im2=im1;
%         imp=eyelash_rem(im2,Ix,Iy);
%         [y,a,b,c]=hough_quadr(imp);
%         [y,a1,b1,c1]=hough_quad_down(imp);
         % IMPORTANT: IF YOU WANT IMPLEMENT ALGORITHM WITH FIRST METHOD:
        % 1- UNCOMMENT LINE 46,47,48,49,53 LINE AS EXECUTABLE LINE BY REMOVE '%' 
        % 2- SELSET LINE 54 OF THIS FUNCTION AS COMMENT WITH '%' CHARACTER 
        %[xc1,yc1,Ix1,Iy1,rr1]=hough_circle_1(im1,Ix,Iy,rr,a,b,c,a1,b1,c1);
        [xc,yc,Ix1,Iy1,rr1]=hough_circle_2(im1,Ix,Iy,rr,flag);
        map=normalization(im_eye,Ix,Iy,Ix1,Iy1,rr,rr1,flag);
        class1(1,co)=i-2;
        [fn]=gabor_filter(uint8(map),flag);
        for ii=1:18
            f_mat{ii,1}(:,co)=fn{ii,1};
        end
    end
end
save('feature_mat_new.mat','f_mat');
timet=toc();
ccll=1:108;

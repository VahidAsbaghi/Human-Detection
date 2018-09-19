%% Function test_single_image
function Res=test_single_image(url)
%% this function: test selected single image and compare it with all train
%% images and return class of test image

%% ************************************************************************
%url='CA/CA1/024/1/024_1_2.bmp';
load('f_mat_tr.mat'); % load train feature vectors
load('class_tr.mat'); % load class of train images
class1_tr=class_tr; 
im_eye=imread(url); % read test image
[lx,ly]=size(im_eye);
im1=imresize(im_eye,[round(0.5*lx),round(0.5*ly)]); %resize image to 50% of original size
[~,~,Ix,Iy,rr]=hough_circle(im1,0); %find pupil circle boundary
[xc,yc,Ix1,Iy1,rr1]=hough_circle_2(im1,Ix,Iy,rr,0); %find outer iris circle boundary
map=normalization(im_eye,Ix,Iy,Ix1,Iy1,rr,rr1,0); %normalize iris image
[fn]=gabor_filter(uint8(map),0); %make feature vector of test image
[lx1,ly1]=size(f_mat_tr{1,1});
k=0;
fmat=cell(16,1);
for i=1:4:ly1
    k=k+1;
    for j=1:16
        fmat{j,1}(:,k)=mean(f_mat_tr{j,1}(:,i:i+3),2); %make mean feature vector of train images 
    end
end
ccll=1:108;

cl1=0;
cl2=0;
cl3=0;
cl4=0;
class11=0;
k=0;
dist_plot=0;
for j=1:16 %compute distanes between test feature and train feature vectors in each angle of gabor filter
    k=k+1;
    f_mat_f=f_mat_tr{j,1};
    fmat_f=fmat{j,1};
    f_matf_test=fn{j,1};
    [lx,ly]=size(f_matf_test);
    [llx,lly]=size(fmat_f);
    [llx1,lly1]=size(f_mat_f);
    for i=1:ly
        dist1=sum((repmat(f_matf_test(:,i),1,lly)-fmat_f).^2,1);
        dist11_0=((repmat(f_matf_test(:,i),1,lly1)-f_mat_f).^2);
        dist11_1=((repmat(f_matf_test(:,i),1,lly1)-[f_mat_f(5:llx1,:);f_mat_f(llx1-3:llx1,:)]).^2);
        dist11_11=((repmat(f_matf_test(:,i),1,lly1)-[f_mat_f(1:4,:);f_mat_f(1:llx1-4,:)]).^2);
        dist11=min(dist11_0,dist11_1);
        dist11=sum(min(dist11,dist11_11),1);
        [C,I]=min(dist1);
        [dist2,II]=sort(dist11);
        cl1(i,k)=class1_tr(II(1));
        cl2(i,k)=class1_tr(II(2));
        cl3(i,k)=class1_tr(II(3));
        cl4(i,k)=ccll(I);
        class11(i,k)=mode([cl1(i,k),cl2(i,k),cl4(i,k)]);
        dist_plot=dist1+dist_plot;
    end
end
ccl1=mode(cl1,2);
ccl2=mode(cl2,2);
ccl3=mode(cl3,2);
ccl4=mode(cl4,2);
ccl5=mode(class11,2);
cc=[ccl1,ccl4,ccl5];
ccf=mode(cc,2);
figure;
plot(dist_plot);
title('Plot Test Image Euclidean Distance with Train Samples');
xlabel('Train Image Number');
ylabel('Euclidean Distance');
[~,Res]=min(dist_plot);
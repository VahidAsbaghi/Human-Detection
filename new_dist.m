%% Function new_dist
function [er_rate,ly]=new_dist(tr_num)
%% this function compute distances between test vectors and train vectors as
%% accordance procedure
%% ************************************************************************
tic();
load('19-kk=20-final.mat');%load all images feature vectors for test
[lx,ly]=size(f_mat{1,1});

r2=tr_num;
k=0;
for i=1:7 %select eye images for test. train images vectors are known as 'tr_num' input
    t=0;
    for j=1:4
        if r2(j)==i
            t=t+1;
        end
    end
    if t==0
        k=k+1;
        r1(k)=i;
    end
end
f_mat_tr=cell(18,1);
f_mat_test=cell(18,1);
for i=1:7:ly %make train and test feature vectors separately
    for j=1:18
        f_mat_test{j,1}=[f_mat_test{j,1},f_mat{j,1}(:,i+r1(1)-1),f_mat{j,1}(:,i+r1(2)-1),f_mat{j,1}(:,i+r1(3)-1)];
        for k=1:4
            f_mat_tr{j,1}=[f_mat_tr{j,1},f_mat{j,1}(:,i+r2(k)-1)];
        end
    end
end
i=1;
k=1;
kk=1;
while i<=108 %make class target vectors for test and train images
    class1_test(k:k+2,1)=i;
    class1_tr(kk:kk+3,1)=i;
    kk=kk+4;
    k=k+3;
    i=i+1;
end

[lx1,ly1]=size(f_mat_tr{1,1});
k=0;
fmat=cell(16,1);
for i=1:4:ly1
    k=k+1;
    for j=1:16
        fmat{j,1}(:,k)=mean(f_mat_tr{j,1}(:,i:i+3),2); %make mean train vector by average of all train images
    end
end
ccll=1:108;

cl1=0;
cl2=0;
cl3=0;
cl4=0;
class11=0;
k=0;
[lx,ly]=size(f_mat_test{1,1});
dist_sum=zeros(ly,108);
for j=1:16 %compute euqlidean distances between train and test vectors for each angle of gabor filter
    k=k+1;
    f_mat_f=f_mat_tr{j,1};
    f_matf_test=f_mat_test{j,1};
    fmat_f=fmat{j,1};
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
        dist_sum(i,:)=dist_sum(i,:)+dist1;
    end
end
ccl1=mode(cl1,2);
ccl2=mode(cl2,2);
ccl3=mode(cl3,2);
ccl4=mode(cl4,2);
ccl5=mode(class11,2);
[~,ccls]=min(dist_sum,[],2);
cc=[ccls,ccl4,ccl5];
ccf=mode(cc,2);
time_test=toc();
err=ccf~=class1_test;
err1=sum(err); %compute error numbers of images baesd on averaged train vector and report as result
er_rate=err1/ly;

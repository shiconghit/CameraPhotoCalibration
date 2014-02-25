clc;clear all;
%论文里面标准的L a b
lab_stander=[];
lab_stander(:,1) =[38.08	66.38	51.06	43.3	56.36	71.6	61.7	41.22	51.57	30.77	72.58	71.6	29.73	55.65	41.22	81.35	51.57	51.57	96	81.35	66.67	51.57	35.99	20.54];
lab_stander(:,2) =[12.09	13.22	0.38	-16.52	12.84	-30.71	27.54	17.95	43	25.74	-28.17	12.45	28.47	-41.52	50.85	-4.13	48.98	-19.85	-0.06	-0.05	-0.04	-0.03	-0.03	-0.02];
lab_stander(:,3) =[14.39	17.14	-22.06	21.46	-25.29	1.17	58.23	-43.16	14.75	-23.38	58.61	66.58	-51.99	33.73	25.86	79.25	-15.96	-24.01	0.06	0.06	0.05	0.04	0.03	0.02];
%网站上的L a b
lab_isli=[];
lab_iseli(:,1) =[37.986	65.711	49.927	43.139	55.112	70.719	62.661	40.02	51.124	30.325	72.532	71.941	28.778	55.261	42.101	81.733	51.935	51.038	96.539	81.257	66.766	50.867	35.656	20.461];
lab_iseli(:,2) =[13.555	18.13	-4.88	-13.095	8.844	-33.397	36.067	10.41	48.239	22.976	-23.709	19.363	14.179	-38.342	53.378	4.039	49.986	-28.631	-0.425	-0.638	-0.734	-0.153	-0.421	-0.079];
lab_iseli(:,3) =[14.059	17.81	-21.925	21.905	-25.399	-0.199	57.096	-45.964	16.248	-22.587	57.255	67.857	-50.297	31.37	28.19	79.819	-14.574	-28.638	1.186	-0.335	-0.504	-0.27	-1.231	0.973];

rgb=imread('sample1.jpg');
[h,w]=size(rgb);
%height=h;
%weith=w
w=fix(w/3);
n=0;
avgRed=[];
avgGre=[];
avgBlu=[];
for j=1:1:4
    for i=1:1:6
%        for ii=fix(1+(j-1)*h/4+h/12):1:fix(1+(j-1)*h/4+h/6)
%            for jj=fix(1+(i-1)*w/6+w/18):1:fix(1+(i-1)*w/6+w/9)
%                rgb(ii,jj,1)=0;
%                rgb(ii,jj,2)=0;
%                rgb(ii,jj,3)=0;
%            end
%        end
     n=n+1;
     Red=[];
     Green=[];
     Blue=[];
     Red=rgb(fix(1+(j-1)*h/4+h/12):fix(1+(j-1)*h/4+h/6),fix(1+(i-1)*w/6+w/18):fix(1+(i-1)*w/6+w/9),1);
     Green=rgb(fix(1+(j-1)*h/4+h/12):fix(1+(j-1)*h/4+h/6),fix(1+(i-1)*w/6+w/18):fix(1+(i-1)*w/6+w/9),2);
     Blue=rgb(fix(1+(j-1)*h/4+h/12):fix(1+(j-1)*h/4+h/6),fix(1+(i-1)*w/6+w/18):fix(1+(i-1)*w/6+w/9),3);
     avgRed(n)=mean(mean(Red));
     avgGre(n)=mean(mean(Green));
     avgBlu(n)=mean(mean(Blue));
    end
end
avg(:,:,1)=avgRed;
avg(:,:,2)=avgGre;
avg(:,:,3)=avgBlu;

[L, a, b]=rgb2lab(avg);
M=[L',a',b']'
X=inv(M*M')*M*lab_iseli;
T=X';
%X=inv(M*M')*M*lab_stander;
rgb_befor=imread('befor3.jpg');
figure(1),imshow(rgb_befor)
lab= colorspace('Lab<-RGB',rgb_befor);
[h,w]=size(rgb_befor);
w=fix(w/3);
for i=1:1:h
    for j=1:1:w
        lab(i,j,1)=T(1,1)*lab(i,j,1)+T(1,2)*lab(i,j,2)+T(1,3)*lab(i,j,3);
        lab(i,j,2)=T(2,1)*lab(i,j,1)+T(2,2)*lab(i,j,2)+T(2,3)*lab(i,j,3);
        lab(i,j,3)=T(3,1)*lab(i,j,1)+T(3,2)*lab(i,j,2)+T(3,3)*lab(i,j,3);
    end
end
lab= colorspace('Lab->RGB',lab);
figure(2),imshow(lab)
%lab = colorspace('Lab<-RGB',rgb)
%newrgb = colorspace('Lab->RGB',lab_stander);
%imshow(newrgb)
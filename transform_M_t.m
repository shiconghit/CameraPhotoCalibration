clc;clear all;
M_ref_O=[79.35	69.25	64.53	56.51	47.55	42.45	35.13	33.08	30.4	29.04	28.64	23.96;
        83.25	71.69	66.51	57.82	48.32	43.27	34.87	33.91	31.1	30.32	29.2	24.15;
        88.2	77.23	73.92	67.66	60.39	55.89	48.4	47.3	44.07	42.35	41.32	36.55];
for i=1:1:12
    str=[num2str(i) '.jpg'];
    rgb=imread(str);
    [h,w]=size(rgb);
    w=fix(w/3);
    Red=[];
    Green=[];
    Blue=[];
    Red=rgb(:,:,1);
    Green=rgb(:,:,2);
    Blue=rgb(:,:,3);
    avg(1,i)=mean(mean(Red));
    avg(2,i)=mean(mean(Green));
    avg(3,i)=mean(mean(Blue));
end
M_ref_trgb=avg;
X=inv(M_ref_trgb*M_ref_trgb')*M_ref_trgb*M_ref_O';
M_t=X'
M_t*M_ref_trgb


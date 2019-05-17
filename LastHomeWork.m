clear
close all
HorseImage1 = Cal256binHSV('/Users/mingmingqiu/Desktop/Horse1.jpg');
HorseImage2 = Cal256binHSV('/Users/mingmingqiu/Desktop/Horse2.jpg');
ElephantImage1 = Cal256binHSV('/Users/mingmingqiu/Desktop/Elephant1.jpg');
ElephantImage2 = Cal256binHSV('/Users/mingmingqiu/Desktop/Elephant2.jpg');

subplot(2,2,1),imshow(HorseImage1,[]),title('Horse1 HSV color');
subplot(2,2,2),imshow(HorseImage2,[]),title('Horse2 HSV color');
subplot(2,2,3),imshow(ElephantImage1,[]),title('Elephant1 HSV color');
subplot(2,2,4),imshow(ElephantImage2,[]),title('Elephant2 HSV color');

function Hist = Cal256binHSV(Im)
Image = imread(Im);
[M,N,O] = size(Image);
[h,s,v] = rgb2hsv(Image);

H = h;
S = s;
V = v;
h = h * 360;
%h:16; s:4; v:4%
for i = 1:M
    for j = 1:N
        if h(i,j) <= 15 || h(i,j) >345
            H(i,j) = 0;
        end
        if h(i,j)<= 25 && h(i,j) > 15
            H(i,j) = 1;
        end
        if h(i,j) <= 45 && h(i,j) >25
            H(i,j) = 2;
        end
        if h(i,j) <= 55 && h(i,j)>45
            H(i,j) = 3;
        end
        if h(i,j) <= 75 && h(i,j) >55
            H(i,j) = 4;
        end
        if h(i,j) <= 95 && h(i,j) >75
            H(i,j) = 5;
        end
        if h(i,j) <= 105 && h(i,j) >95
            H(i,j) = 6;
        end
        if h(i,j) <= 125 && h(i,j) >105
            H(i,j) = 7;
        end
        if h(i,j) <= 155 && h(i,j) >125
            H(i,j) = 8;
        end
        if h(i,j) <= 175 && h(i,j) >155
            H(i,j) = 9;
        end
        if h(i,j) <= 205 && h(i,j) >175
            H(i,j) = 10;
        end
        if h(i,j) <= 235 && h(i,j) >205
            H(i,j) = 11;
        end
        if h(i,j) <= 265 && h(i,j) >235
            H(i,j) = 12;
        end
        if h(i,j) <= 285 && h(i,j) >265
            H(i,j) = 13;
        end
        if h(i,j) <= 300 && h(i,j) >325
            H(i,j) = 5;
        end
        if h(i,j) <= 325 && h(i,j) >345
            H(i,j) = 15;
        end
    end
end

%s:4%
for i = 1:M
    for j = 1:N
        if s(i,j) <= 0.15 && s(i,j) >0
            S(i,j) = 1;
        end
        if s(i,j) <= 0.4 && s(i,j) > 0.15
            S(i,j) = 2;
        end
        if s(i,j) <= 0.7 && s(i,j) >0.4
            S(i,j) = 3;
        end
        if s(i,j) <= 1 && s(i,j) >0.7
            S(i,j) = 4;
        end
    end
end
%o:4%
for i = 1:M
    for j = 1:N
        if v(i,j) <= 0.15 && v(i,j) >0
            V(i,j) = 1;
        end
        if v(i,j) <= 0.4 && v(i,j) > 0.15
            V(i,j) = 2;
        end
        if v(i,j) <= 0.7 && v(i,j) > 0.4
            V(i,j) = 3;
        end
        if v(i,j) <= 1 && v(i,j) > 0.7
            V(i,j) = 4;
        end
    end
end

% 4 x 16 matrix%
Hist = zeros(16,4);
for i = 1:M
    for j = 1:N
        for k = 1 : 16
            for l = 1:4
                if l == S(i,j) && k == H(i,j) + 1
                    Hist(k,l) = Hist(k,l) + 1;
                end
            end
        end
    end
end
for k = 1:16
    for l = 1:4
        His((k-1)*4+l) = Hist(k,l);
    end
end
His = His/sum(His) * 1000;
%Hist_h
m = 0;
for j = 1:300
    if rem(j,16) == 1 && m <16
        for k = 0 : 15
            for i = 1:200
                hist_h(i,j+k) = m;
            end
        end
        m = m + 1;
    end
end
%His_s
m=0;
for j = 1:300
    if rem(j,4) == 1 && m<64
        n = rem(m,4);
        for k = 0:3              
            for i =1:200              
                hist_s(i,j+k) = n+1;                
            end                     
        end
        m = m+1; 
    end    
end
% hist_v
for j = 1:256
    for i = 1:200
        hist_v(i,j) = 0.98;
    end
end
for k = 1:64
    for j = 1:256
        if floor((j-1)/4) == k
            for i = 1:200
                if i<200-His(k+1)%i>His(k+1)%
                    hist_v(i,j) = 0;
                end
            end
        end
    end
end
Hist = hsv2rgb(hist_h/16,hist_s/4,hist_v);
end


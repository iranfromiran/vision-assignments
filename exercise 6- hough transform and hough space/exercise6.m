% Exercise 6
clear;
close all;
image = imread('LineSharp.png');
image = im2gray(image);
binary_img = imbinarize(image);

[iHeight,iWidth] = size(binary_img);
distMax = round(sqrt(iHeight^2 + iWidth^2)); % Maximum possible distance from origin
theta = -90:1:89; % range of theta values
rho = -distMax:1:distMax; % range of rho values
H = zeros(length(rho),length(theta), 'int32'); % Allocate accumulator array
% Scan through edge image
for ix=1:iWidth
    for iy=1:iHeight
        if binary_img(iy,ix) ~= 0
            % Fill in accumulator array
            for iTheta = 1:length(theta)
                t = theta(iTheta)*pi/180; % get angle in radians                
                % Calculate distance from origin, given this angle
                % Let's use (1,1) as the "origin"
                r = (ix-1)*cos(t) + (iy-1)*sin(t);
                % Find rho value that is closest to this
                [d, iRho] = min(abs(rho-r));
                if d <= 1
                    H(iRho,iTheta) = H(iRho,iTheta) + 1; % Inc accumulator array
                end
            end
        end
    end
end

peaks = hough_peaks(H);
hough_lines_draw(image, peaks, rho, theta);


figure(1);
subplot(1, 2, 1), imshow(H, []), title("hough space");

 function hough_lines_draw(img, peaks, rho, theta)
   subplot(1, 2, 2), imshow(img), hold on;
    for i = 1 : size(peaks,1)
       rho_i = rho(peaks(i,1)) + 1;
       theta_i = theta(peaks(i,2)) * pi / 180;
       if theta_i == 0
           x1 = rho_i;
           x2 = rho_i;
           if rho_i > 0
               y1 = 1;
               y2 = size(img,1);
               plot([x1,x2],[y1,y2],'b','LineWidth',2), title("draw line detected by hough transform"); 
           end           
       else
           x1 = 1;
           x2 = size(img, 2);
           y1 = (rho_i - x1 * cos(theta_i)) / sin(theta_i) + 1;
           y2 = (rho_i - x2 * cos(theta_i)) / sin(theta_i) + 1;
           plot([x1,x2],[y1,y2],'b','LineWidth',2), title("draw line detected by hough transform");  
       end
             
    end
end


function peaks = hough_peaks(H)
    npeaks = 1;
    thold =  0.5 * max(H(:));
    neighborHSize = floor(size(H) / 100.0) * 2 + 1;
    
    peaks = zeros(npeaks, 2);
    num = 0;
    while(num < npeaks)
        maxvalueH = max(H(:));
        if (maxvalueH >= thold)
            num = num + 1;
            [row,col] = find(H == maxvalueH);
            peaks(num,:) = [row(1),col(1)];
            rStart = max(1, row - (neighborHSize(1) - 1) / 2);
            rEnd = min(size(H,1), row + (neighborHSize(1) - 1) / 2);
            cStart = max(1, col - (neighborHSize(2) - 1) / 2);
            cEnd = min(size(H,2), col + (neighborHSize(2) - 1) / 2);
            for i = rStart : rEnd
                for j = cStart : cEnd
                        H(i,j) = 0;
                end
            end
        else
            break;          
        end
    end
    peaks = peaks(1:num, :);            
end

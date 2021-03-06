%This is the demonstration of the stereo vision applied on the enhanced
%underwater images.

% Load the stereoParameters object.
load('handshakeStereoParams.mat');

limg = imread('frame293Fig12.jpg'); %left image
rimg = imread('frame293Fig11.jpg'); %right image

%Applying image rectification
[limg1, rimg1] = rectifyStereoImages(limg, rimg, stereoParams);

figure; 
imshow(stereoAnaglyph(limg1, rimg1));
title('Rectified Images');

disparityMap = disparity(rgb2gray(limg1), rgb2gray(rimg1));
figure 
imshow(disparityMap, [0, 64]);
title('Disparity Map');
colormap jet
colorbar

%Building the data-point cloud
points3D = reconstructScene(disparityMap, stereoParams);

% Converting to meters and creating the 3D object
points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', limg1);

% Create a streaming point cloud viewer
player3D = pcplayer([-2, 2], [-2, 2], [0, 5], 'VerticalAxis', 'y', 'VerticalAxisDir', 'down');

% Visualize the point cloud
view(player3D, ptCloud);



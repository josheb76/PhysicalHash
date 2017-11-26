function im_rectified = Rectify( im )
% Rectify takes in an image and allows the user to select four points. It
% returns a square image where the selected points have been warped to the
% corners. Helpful if the camera is not directly above the print bed. This
% could be automated with image processing techniques in future work.

dim = max(size(im));

%Ref: https://www.mathworks.com/matlabcentral/answers/69442-stretch-quadrilateral-roi-to-pre-definded-rectangle-size
figure(1), imshow(im)
manualVerts = ginput(4); %choose in order: [1 2; 3 4]
tform = cp2tform(manualVerts,[1 1; dim 1; 1 dim; dim dim],'projective');
im_rectified = imtransform(im,tform,'XData',[1 dim],'YData',[1 dim],'XYScale',[1 1]);

close(1)
subplot(1,2,1), imshow(im)
subplot(1,2,2), imshow(im_rectified)

end
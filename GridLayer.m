function [ im_processed ] = GridLayer(im, technology, qr_size)
% GridLayer takes in a rectified image of the printed QR code, the
% technology (PBF/ME), and the size of the QR code. It returns a binary
% matrix of the interpretted QR.

%% Define constants
inset_percent_R = 0.3;
inset_percent_C = 0.2;

%% Set up number of pixels per grid square and padding inset
pixelsR = size(im,1) / qr_size;
pixelsC = size(im,2) / qr_size;
insetR = round(inset_percent_R * pixelsR);
insetC = round(inset_percent_C * pixelsC);

%% Set up vectors defining border of each grid square
%create total vector to contain one past maximum dimension
r_spacing = 1:pixelsR:size(im,1)+pixelsR/2;
c_spacing = 1:pixelsC:size(im,2)+pixelsC/2;

%subtract 1 from the last element to stop OOB
r_spacing(end) = r_spacing(end)-1;
c_spacing(end) = c_spacing(end)-1;

%round to whole numbers for indexing
r_spacing = round(r_spacing);
c_spacing = round(c_spacing);

%% Loop
im_processed = zeros(qr_size,qr_size,'logical');
for row=1:qr_size
    for col=1:qr_size
        rmin = r_spacing(row);
        rmax = r_spacing(row+1);
        cmin = c_spacing(col);
        cmax = c_spacing(col+1);
        
        subim = im(rmin+insetR : rmax-insetR, cmin+insetC : cmax-insetC, :);
        
%         %visualize each dot. set a breakpoint after these lines if uncommented
%         subim_verts = [cmin,rmin;cmax,rmin;cmax,rmax;cmin,rmax;cmin,rmin];
%         subplot(1,2,1), imshow(mat2gray(im)), hold on
%         plot(subim_verts(:,1),subim_verts(:,2),'r-')
%         subplot(1,2,2), imshow(mat2gray(subim)), hold off
        
        if strcmp(technology,'PBF') == 1
            im_processed(row,col) = sum(sum(subim == 0)) / numel(subim) < 0.2;
        elseif strcmp(technology,'ME') == 1
            rgb_mean = reshape(mean(mean(subim)),[1,3]);
            im_processed(row,col) = rgb_mean(1) > 120;
        else
            error('Invalid AM technology. Enter either ''PBF'' or ''ME''.');
        end
    end
end

%% Display grid used
figure

subplot(1,2,1), imshow(im), hold on
title('Gridded image')
%title('Clustered image')
for row = r_spacing
    plot([1,size(im,1)],[row,row],'-r');
end
for col = c_spacing
    plot([col,col],[1,size(im,2)],'-r');
end
hold off

subplot(1,2,2), imshow(im_processed,[]), hold on
title('Processed image')
% for row = 0.5:num_squares
%     plot([0.5,size(im_processed,1)+0.5],[row,row],'-r');
% end
% for col = 0.5:num_squares+0.5
%     plot([col,col],[0.5,size(im_processed,2)+0.5],'-r');
% end
hold off

end
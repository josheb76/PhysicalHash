function GenerateQR_2D(str,qr_size)
% GenerateQR_2D takes the string to be encoded and uses an online service
% to generate the QR image. In a true implementation of the system, this
% should be done locally and not via an online service. The qr_size
% parameter should be either 25 or 29. It is variable because the minimum
% size of the code is dependent on the ratio of alphanumeric characters in
% the string being encoded. The output of this method is two .scad files.
% They will be automatically loaded into OpenSCAD when GenerateQR_3D.scad
% and GenerateQR_3D_negative.scad are opened.

%% Create code from goqr.me and interpret as 2D binary array
url = ['http://api.qrserver.com/v1/create-qr-code/?size=',num2str(qr_size+2),'x',num2str(qr_size+2),'&data=']; %http://goqr.me/
qr_url = strcat(url,str);
[qr_code,map] = imread(qr_url,'png');

%% Trim to size x size
qr_code(:,qr_size+2)=[]; qr_code(qr_size+2,:)=[];
qr_code(:, 1)=[]; qr_code( 1,:)=[];

%% Show and write QR code
figure, imshow(qr_code,map)
imwrite(imresize(qr_code,10),map,'qr_2D.png')

%% Export for use in OpenSCAD
%dark pixels
dot_locs = find(qr_code)-1;
dot_locs_formatted = sprintf('%.0f,',dot_locs(:)');
dot_locs_formatted = dot_locs_formatted(1:end-1);
%write
fileID = fopen('openscad_formatted_dot_locs.scad','w');
fprintf(fileID,'dot_locs = [');
fprintf(fileID,dot_locs_formatted);
fprintf(fileID,'];');
fprintf(fileID,'qr_size = ');
fprintf(fileID,num2str(qr_size));
fprintf(fileID,';');
fclose(fileID);

%light pixels
dot_locs = find(~qr_code)-1;
dot_locs_formatted = sprintf('%.0f,',dot_locs(:)');
dot_locs_formatted = dot_locs_formatted(1:end-1);
%write
fileID = fopen('openscad_formatted_dot_locs_neg.scad','w');
fprintf(fileID,'dot_locs = [');
fprintf(fileID,dot_locs_formatted);
fprintf(fileID,'];');
fprintf(fileID,'qr_size = ');
fprintf(fileID,num2str(qr_size));
fprintf(fileID,';');
fclose(fileID);

end
function [ message ] = DecodeQR( file )
% DecodeQR takes a processed QR code as input and returns the message
% stored in it. In a true implementation of the system, this should be
% done locally and not via an online service. For this method to work,
% you must modify:
% -host, username, and password on lines 12, 13, and 14
% -directory on line 18
% -server_url on line 27

%% Upload QR code to server
%create FTP object
host = 'thebrandmans.net';
username = 'thebrand';
password = 'longItude1!1';
ftpobj = ftp(host,username,password);

%move to directory and copy in image
directory = '/public_html/research/';
cd(ftpobj,directory);
mput(ftpobj,file);

%close FTP connection
close(ftpobj)

%% Inerpret QR using goqr.me's API
url = 'http://api.qrserver.com/v1/read-qr-code/?fileurl='; %http://goqr.me/
server_url = 'http://thebrandmans.net/research/';
fileurl = urlencode([server_url,file]);
url = [url,fileurl];

options = weboptions('Timeout',15);
response = webread(url,options);
message = response.symbol.data;

end
function CSXGeomPlot(CSX_filename)
% function CSXGeomPlot(CSX_filename)
%
% plot the geometry stored in the CSX file using QCSXCAD & AppCSXCAD
%
% CSXCAD matlab interface
% -----------------------
% author: Thorsten Liebig

if nargin < 1
    error 'specify the xml file to open'
end

filename = mfilename('fullpath');
dir = fileparts( filename );
AppCSXCAD_Path = [dir filesep '../../AppCSXCAD' filesep]
   
if (~exist(AppCSXCAD_Path,'dir'))
    AppCSXCAD_Path = [dir filesep '..' filesep]  
end

if isunix
	AppCSXCAD_Path = [AppCSXCAD_Path 'AppCSXCAD.sh'];
else
	AppCSXCAD_Path = [AppCSXCAD_Path 'AppCSXCAD'];
end

command = [AppCSXCAD_Path ' ' CSX_filename];
disp( ['invoking AppCSXCAD : ' command] );
system(command);
# Main Executables
### Material Extrusion
- RunMe_Designer_ME.m
- RunMe_MeasurementSystem_ME.m
### Powder Bed Fusion
- RunMe_Designer_PBF.m
- RunMe_MeasurementSystem_PBF.m

# STL Generation
Instructions are written to the console when RunMe_Designer_ME/PBF.m is run
- GenerateQR_3D.scad
- GenerateQR_3D_negative.scad

# Experimental Data
Physical measurements used in the implementations in Section 4.2 and Chapter 5 of the thesis
### Material Extrusion
- qr_rectified_me.jpg
- extrusion_temperature_data_1.mat
- extrusion_temperature_data_2.mat
- extrusion_temperature_data_3a.mat
- extrusion_temperature_data_3b.mat
- layer_time_data_1.mat
- layer_time_data_2.mat
- layer_time_data_3a.mat
- layer_time_data_3b.mat
### Powder Bed Fusion
- qr_rectified_pbf.jpg
- ambient_temperature_data.mat

# Other MATLAB Methods
- averagefilter.m ([credit](https://www.mathworks.com/matlabcentral/fileexchange/40266-sauvola-local-image-thresholding))
- DataHash.m ([credit](https://www.mathworks.com/matlabcentral/fileexchange/31272-datahash))
- DecodeQR.m
- GenerateParameterPlaintext.m
- GenerateQR_2D.m
- GridLayer.m
- LoadPredefinedRanges.m
- Rectify.m
- sauvola.m ([credit](https://www.mathworks.com/matlabcentral/fileexchange/40266-sauvola-local-image-thresholding))

# Auto-Generated Files from MATLAB/OpenSCAD
- openscad_formatted_dot_locs.scad
- openscad_formatted_dot_locs_neg.scad
- qr_2D.png
- qr_3D_1.stl
- qr_3D_2.stl
- qr_processed.jpg
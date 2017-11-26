module qr_code(width,height,inset,dot_locs) {
    rotate([0,0,-90]) translate([-width/2,-width/2,0]) 
    union() {
        cube(size=[width,width,height/2]);
        
        square_size = width/qr_size;
        dot_size = (1-2*inset)*square_size;
        for(i=[0:len(dot_locs)-1]) {
            curr = dot_locs[i];
            x = square_size*(curr%qr_size) + square_size/2;
            y = square_size*(floor(curr/qr_size)) + square_size/2;
            z = height/4 + height/2;
            translate([x,y,z]) {
                cube(size=[dot_size,dot_size,height/2],center=true);
            }
        } //for
    } //union
}

include <openscad_formatted_dot_locs.scad>;
qr_code(40,0.8,0.02,dot_locs);
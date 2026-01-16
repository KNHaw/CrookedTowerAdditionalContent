// Crooked_Tower_1b.scad
 
// Parameters - to generate image in module
// cube_size = 30;
// cube_overlap = 0;    // Amount to overlap the cubes
// text_size = 4.5;
// big_text_size = 7;
// rounding = 4;
// magnet_diam = 0;     // divot to put a magnet in
// magnet_height = 0;


// Parameters - to generate 3D prop to print on my MP Mini Delta
cube_size = 40;
cube_overlap = 0.5;    // Amount to overlap the cubes
text_size = 5.5;
big_text_size = 9;
rounding = 4;
magnet_diam = 14;     // divot to put a magnet in
magnet_height = 6;




// Common parameters
extrude_size = 1;
text_color = "black";
cube_color_1 = "tan";
cube_color_2 = "gray";
label_tilt = 45;
 
// Put a label on the north face of a cube
module north_label(label_text)
{
    color(text_color)
        translate([0, 0, (cube_size / 2)-cube_overlap]) // Stick on N face
            linear_extrude(height = extrude_size+cube_overlap)  // Extrude the text by 2 mm
                text(label_text, size = big_text_size, 
        valign = "center", halign = "center", font="Liberation Sans:style=Bold");
}

// Put a 3 line label on the north face of a cube
module north_3line_label(label_text_1, label_text_2, label_text_3)
{
    margin = 1.5;
    color(text_color)
        translate([0, 0, (cube_size / 2)-cube_overlap]) // Stick on N face
            {
            // Upper line
            translate ([0,text_size+margin,0])
                linear_extrude(height = extrude_size+cube_overlap)  // Extrude the text by 2 mm
                    text(label_text_1, size = text_size, valign = "center", halign = "center", font="Liberation Sans:style=Bold");
            
            // Middle line
            linear_extrude(height = extrude_size+cube_overlap)  // Extrude the text by 2 mm
                text(label_text_2, size = text_size, valign = "center", halign = "center", font="Liberation Sans:style=Bold");
                
            // Lower line
            translate ([0,-(text_size+margin), 0])
                linear_extrude(height = extrude_size+cube_overlap)  // Extrude the text by 2 mm
                    text(label_text_3, size = text_size, valign = "center", halign = "center", font="Liberation Sans:style=Bold");
            
            }
}
 
// Apply a label on a given cube face
// direction: 1=up, 2=down, 3=north, 4=west, 5=south, 6=east
module apply_label(direction, label_text)
{
    if (direction==1) rotate( [0,0,0]) north_label(label_text); // Up face - 45 tilt on face
    else if (direction==2) rotate( [180,0,0]) north_label(label_text); // Down face - 45 tilt on face
    else if (direction==3) rotate( [90,0,0]) north_label(label_text); // North face - 45 tilt on face
    else if (direction==4) rotate( [90,0,90]) north_label(label_text); // West face - 45 tilt on face
    else if (direction==5) rotate( [90,0,180]) north_label(label_text); // South face - 45 tilt on face
    else if (direction==6) rotate( [90,0,-90]) north_label(label_text); // East face - 45 tilt on face
}
 



// Apply a label on a given cube face
// direction: 1=up, 2=down, 3=north, 4=west, 5=south, 6=east
module apply_3line_label(direction, label_1, label_2, label_3)
{
    if (direction==1) rotate( [0,0,0]) north_3line_label(label_1, label_2, label_3); // Up face
    else if (direction==2) rotate( [180,0,0]) north_3line_label(label_1, label_2, label_3); // Down face
    else if (direction==3) rotate( [90,0,0]) north_3line_label(label_1, label_2, label_3); // North face
    else if (direction==4) rotate( [90,0,90]) north_3line_label(label_1, label_2, label_3); // West face
    else if (direction==5) rotate( [90,0,180]) north_3line_label(label_1, label_2, label_3); // South face
    else if (direction==6) rotate( [90,0,-90]) north_3line_label(label_1, label_2, label_3); // East face
}
 


// Apply a label on a given cube face
// direction: 1=up, 2=down, 3=north, 4=west, 5=south, 6=east
module apply_tilted_label(direction, label_text)
{
    if (direction==1) rotate( [0,0,label_tilt]) north_label(label_text); // Up face - 45 tilt on face
    else if (direction==2) rotate( [180,0,label_tilt]) north_label(label_text); // Down face - 45 tilt on face
    else if (direction==3) rotate( [90,label_tilt,0]) north_label(label_text); // North face - 45 tilt on face
    else if (direction==4) rotate( [90,label_tilt,90]) north_label(label_text); // West face - 45 tilt on face
    else if (direction==5) rotate( [90,label_tilt,180]) north_label(label_text); // South face - 45 tilt on face
    else if (direction==6) rotate( [90,label_tilt,-90]) north_label(label_text); // East face - 45 tilt on face
}
// Make a cube with color 1
module cube_1() {
    // Main cube    
    color(cube_color_1) minkowski()  {
        cube(cube_size-rounding, center=true);
        sphere(r=rounding/2);
        }
    }
 
// Make a cube with color 2
module cube_2() {
    // Main cube    
    color(cube_color_2) minkowski()  {
        cube(cube_size-rounding, center=true);
        sphere(r=rounding/2);
        }
    }
 
// Demo directions on cubes
module compass_cube() {
    cube_1();
    apply_label(1, "UP");
    apply_label(2, "DOWN");
    apply_label(3, "NORTH");
    apply_label(4, "WEST");
    apply_label(5, "SOUTH");
    apply_label(6, "EAST");    
    }
 
// Compass Cube - demo
//compass_cube();
 
///////////////////
// Crooked Tower
///////////////////
 
// Room B1 - no labels
translate([(0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap))]) {
    cube_1();
    apply_3line_label(2, "B1", "Lower", "Attrium");
    }
 
// Rooom B2
translate([(0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap)), (1* (cube_size - cube_overlap))]) {
    

    difference(){
        union()
        {
            cube_1();
            apply_3line_label(3, "B2", "Upper", "Attrium");
            apply_3line_label(5, "B2", "Upper", "Attrium");
        }    
        // Remove divot for embedded magnet
        translate([0,0,extrude_size])   // Adjust for text on top face of B4
            rotate( [90,0,-90]) // East side of cube
                translate([0,0,((cube_size - cube_overlap)/2-magnet_height)])        
                    cylinder(h=50, d=magnet_diam, center=false);
        }     
    
    
}
 
// Rooom B3
translate([(0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap)), (2* (cube_size - cube_overlap))]) {
    difference(){
        union()
        {
            cube_1();
            apply_3line_label(3, "B3", "Construct", "Storage");
            apply_3line_label(5, "B3", "Construct", "Storage");
            apply_tilted_label(1, "UP");
        }    
        // Remove divot for embedded magnet
        translate([0,0,extrude_size])  // Adjust for text on top face of B4
            rotate( [90,0,-90]) // East side of cube
                translate([0,0,((cube_size - cube_overlap)/2-magnet_height)])        
                    cylinder(h=50, d=magnet_diam, center=false);
        } 
}
 
 
// Room B4
translate([(-1* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap))]) {
    cube_1();
    apply_3line_label(1, "B4", "Matilda");
    
    apply_tilted_label(2, "DOWN");
    apply_tilted_label(3, "NORTH");
    apply_tilted_label(4, "WEST");
    apply_tilted_label(5, "SOUTH");
    apply_tilted_label(6, "EAST");
    }
 
// Room B5
translate([(0* (cube_size - cube_overlap)), (-1* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap))]) {
    cube_1();
    apply_3line_label(1, "B5", "Aseir");
    
    apply_tilted_label(2, "DOWN");
    apply_tilted_label(3, "NORTH");
    apply_tilted_label(4, "WEST");
    apply_tilted_label(5, "SOUTH");
    apply_tilted_label(6, "EAST");
    }
 
// Room B6
translate([(1* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap))]) {
    cube_1();
    apply_3line_label(1, "B6", "Savael");
    
    apply_tilted_label(2, "DOWN");
    apply_tilted_label(3, "NORTH");
    apply_tilted_label(4, "WEST");
    apply_tilted_label(5, "SOUTH");
    apply_tilted_label(6, "EAST");
    }
 
// Room B7
translate([(0* (cube_size - cube_overlap)), (1* (cube_size - cube_overlap)), (0* (cube_size - cube_overlap))]) {
    cube_1();
    apply_3line_label(1, "B7", "Quintus");
    
    apply_tilted_label(2, "DOWN");
    apply_tilted_label(3, "NORTH");
    apply_tilted_label(4, "WEST");
    apply_tilted_label(5, "SOUTH");
    apply_tilted_label(6, "EAST");
    }   
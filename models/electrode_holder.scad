use <threadlib/threadlib.scad>

include <./electrodes.scad>

tipL = 20;
clipL = 60-1*tipL;//80;
clipW = 8.5;
clipH = 1.5;
clipHD = 26;




cableX = 4.5;
cableY = 20;

gel_thread_specs= thread_specs("M12-ext");
P = gel_thread_specs[0];
Dsupport = gel_thread_specs[2];

//echo(Dsupport);
//echo(P);

gelBD = electrodeOD+5;
gelCD = Dsupport;
gelCHole = electrodeOD-cupD;
gelH = 12;

holderH=5;
holderD=10;
hairHD=10;

tol = 0.1;
$fn=40;

module attachment_arm(){    
    union(){
    hull(){
    cube([clipL,clipW,clipH],center=true);
        resize([clipL+1*tipL,clipW,clipH*2+2]){
        sphere(d=1);
        }  
     
    translate([clipL/2+tipL/3,0,-clipH/2]){
        resize([tipL,clipW,clipH]){
        cylinder(d=1,h=1,$fn=3);
        }//resize
    }//translate
     translate([-clipL/2-tipL/3,0,clipH/2]){
        resize([tipL,clipW,clipH]){
            rotate([0,180,0]){
            cylinder(d=1,h=1,$fn=3);
            
            }//rotate
        }//resize
    }//translate
}
}//end union
}//module



module electrode_cap(){
    difference(){
    cylinder(d=gelCD+5,h=4.3);
        translate([0,0,0]){
    tap("M12",turns=3);
        }//end translate
    }//end difference
    
    }// end module electrode_cap
    
module gel_holder(){


    difference(){
        union(){
        cylinder(d=gelBD,h=2);
        cylinder(d=gelCD,h=gelH);
        }//end union
        translate([0,0,-1]){
    cylinder(d=gelCHole,h=gelH+2);
        }//end translate
        translate([0,0,-0.1]){
        electrode_positive();
        }//end translate
        }//end difference
    translate([0,0,3.9]){
    thread("M12-ext",turns=4);
    }//end translate
  
    }// end module gel_holder

module clip_attachments(){
   difference(){
    union(){
    for ( y = [-0.5:0.5] ){
      translate([0,y*clipW+(y*0.5),0]){ 
        attachment_arm();
}//end translate
}//end for
centralBlock = 2*clipW;
translate([-(centralBlock+4)/2,-(centralBlock)/2,-clipH/2]){
cube([centralBlock+4,centralBlock,clipH]);

}//end translate
}//end union
        translate([0,0,-2*clipH]){    
        //translate([0,0,-.5]){    
        cylinder(d=10,h=4*clipH);
        //    tap("M12",turns=2);
        }//end translate
    }//end difference
}//end module clip_attachments




translate([0,0,0]){electrode_cap();}//end translate
translate([0,20,clipH/2]){clip_attachments();}//endtranslate
translate([0,-20,0]){gel_holder();}


/*
difference(){
cylinder(d=holderD,h=holderH);
translate([0,0,-tol]){
solid_electrode();
}//end translate
}//end difference

for ( i = [0:45:360-45] ){
    translate([(holderD/2-hairHD)*cos(i), (holderD/2-hairHD)*sin(i), -tol]){
    rotate([0, 0, 0]){
    
    cylinder(d = hairHD,h=holderH+2);
    }
    }
}
*/
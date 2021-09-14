use <threadlib/threadlib.scad>

tipL = 20;
clipL = 60-1*tipL;//80;
clipW = 8.5;
clipH = 1.5;
clipHD = 26;


//internal diameter of the cup
cupD = 7.5;
//border Diameter around the cup
borderD  = 4;
//the diameter of the entire electrode
electrodeOD = cupD+borderD;

//echo(electrodeOD);

//electrodeID = 5;
//hole on top of cup
electrodeOpening = 1.6;

electrodeH = 0.8;

electrodeT = 0.85;

cableT = electrodeT;
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

module electrode_positive(){
     cylinder(d=electrodeOD,h=electrodeT);
        sphere(d=cupD);
        
            translate([-cableX/2,electrodeOD/2-3,0]){
            cube([cableX,cableY,electrodeT+1]);
        }//end translate
    }//end module

module electrode_negative(){
    cylinder(d=electrodeOpening,h=electrodeH+5);
        translate([0,0,-electrodeT]){
        
            sphere(d=cupD-electrodeT);
        }//end translate
        translate([-electrodeOD/2-1,-electrodeOD/2-1,-electrodeOD+0.01]){
            cube([electrodeOD+2,electrodeOD+2 ,electrodeOD]);
            }//end translate
    }//end module
    
module electrode(){

difference(){    
    electrode_positive();
    electrode_negative();
    

    }//end difference
}//end electrode module


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




translate([0,0,0]){

electrode_cap();}

translate([0,20,clipH/2]){
    
clip_attachments();
}//end translate
translate([0,-20,0]){
//translate([0,-20,gelH]){
//        rotate([0,180,0]){
gel_holder();
//        }
}

//electrode_positive();//attachment_arm();
//clip_attachments();
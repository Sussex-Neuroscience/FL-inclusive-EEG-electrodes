use <threadlib/threadlib.scad>


clipL = 40;//80;
clipW = 40;
clipH = 2.5;
clipHD = 26;

electrodeOD = 10;
electrodeID = 5;
electrodeOpening = 2;
electrodeH = 2;
electrodeT = 2;

gel_thread_specs= thread_specs("M18-ext");
P = gel_thread_specs[0];
Dsupport = gel_thread_specs[2];

echo(Dsupport);
echo(P);
gelBD = 25;
gelCD = Dsupport;
gelCHole = gelCD-5;
gelH = 15;



tol = 0.1;
$fn=80;



module electrode(){
difference(){    
    sphere(d=electrodeOD);
    union(){
        translate([0,0,-1]){
        cylinder(d=electrodeOpening,h=electrodeOD+1);
            sphere(d=electrodeOD-electrodeT);
        }//end translate
        translate([-electrodeOD/2,-electrodeOD/2,-electrodeOD]){
            cube(electrodeOD);
            }//end translate
        }//end union
    }//end difference
}//end electrode module


module electrode_cap(){
    
        tap("M18",turns=10);
    //some some
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
        }//end difference
    translate([0,0,3.9]){
    thread("M18-ext",turns=4);
    }//end translate
    }// end module gel_holder

module clip_attachments(){
    %cube([clipL,clipW,clipH]);
    translate([0,clipL*0.5-2,0]){
        
    scale([1.5,0.5 ]){
        circle(d=clipL);
        }//end scale
    }//end translate
    
    scale([1.5,0.35 ]){
            
        circle(d=clipL);}//end scale
        
        
    translate([clipL/2,clipW/2,-gelH/2]){
        //gel_holder();

        //cylinder(d=gelCD+2*tol,h=10);
        }//end translate
    }//end module clip_attachments
//clip_attachments();
//gel_holder();
    
//translate([50,50,0])
//electrode();
    /*
    hull(){
    
    translate([-22.5,-5,0]){
    cube([20,10,10]);
    }//end translate
}//end hull
    */
    intersection(){
    resize([60,8,5]){
    sphere(10);
    }
    translate([-30,-5,0-2]){
    cube([60,10,4]);
    }//end translate
}
translate([0,7,0]){
    intersection(){
    resize([60,8,5]){
    sphere(10);
    }
    translate([-30,-5,0-2]){
    cube([60,10,4]);
    }//end translate
}
}
electrodeD = 10;
electrodeOpening = 2;
electrodeH = 2;

$fn=40;

module electrode(){
difference(){    
    sphere(d=electrodeD);
    union(){
        cylinder(d=electrodeOpening,h=electrodeD);
        translate([-electrodeD/2,-electrodeD/2,-electrodeD]){
            cube([electrodeD,electrodeD,electrodeD]);
            }//end translate
        }//end union
    }//end difference
}//end electrode module


module electrode_cap(){
    //some some
    }// end module electrode_cap
    
module gel_holder(){
    }// end module gel_holder

module clip_attachments(){
    }//end module clip_attachments


electrode();
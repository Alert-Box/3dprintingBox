include<../../parts/textLcdBezels.scad>
use<../../parts/rpiPlateCompact1.scad>



//bezel4x20X=110;
bezel4x20Y=80;

boxWallsThickness=1.5;
buttonsAreaX=30;

buttonsHoleRadius=16.5/2;
beamsThickness=3;

boxPart1Z=25;
boxPart2Z=25;
boxPart3Z=25;
screwHoles1Radius=3/2;
pillarsWidth1=5;

battBoxX=100;
battBoxY=95;
battBoxWallsThickness=1;

battBoxWallsHeight=20;
battBoxWalls2Height=30;

fixationBeamsThickness=5;
fixationBeamsHolesRadius=3/2;

pcbX=40;
pcbY=60;

pcbHolesDistFromEdge=2;

beamsThickness=2.0;
circuit1X=50;
circuit1Y=70;
circuit1ScrewsRadius=2/2;
circuit1ScrewsDistFromEdge=1;
circuit1ScrewPillarsH=5+beamsThickness;
screwHolesRadius=2/2;
padding=0.1;

nbButtons=3;
buttonDecalX=(buttonsAreaX-beamsThickness*2-1)/2;
buttonDecalY=(bezel4x20Y-beamsThickness*2-nbButtons*buttonsHoleRadius*2)/(nbButtons+1);
echo (buttonDecalY);


module fixationPillar(pillarWidth=pillarsWidth1,pillarHeight=boxPart1Z,pillarScrewRadius=screwHoles1Radius)
{
    difference()
    {
    cube([pillarWidth,pillarWidth,pillarHeight]);
        translate([pillarWidth/2,pillarWidth/2,1])
        cylinder(r=pillarScrewRadius,h=pillarHeight,$fn=12);
    } 
}

module openBasePlate(x,y,nbBeamsX=3,nbBeamsY=2)
{
	xShift=x/(nbBeamsX+1);
	for (i =[0:nbBeamsX+1])
	{
		translate([xShift*i,0,0])
			cube([beamsThickness,y,beamsThickness]);
	}


	yShift=y/(nbBeamsY+1);
	for (i =[0:nbBeamsY+1])
	{
		translate([0,yShift*i,0])
			cube([x+beamsThickness,beamsThickness,beamsThickness]);
	}
}
module motorBracketHole(h0=battBoxWallsHeight-beamsThickness,shift=beamsThickness,r0=screwHolesRadius) 
{
	translate([0,0,padding+shift]) 
	{
    	cylinder(r=r0, h0+padding, center = false,$fn=32);
	}
}

module circuit1Plate()
{

	openBasePlate(circuit1X,circuit1Y,2,2);

	translate([beamsThickness+circuit1ScrewsDistFromEdge,beamsThickness+circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([beamsThickness+circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([circuit1X-circuit1ScrewsDistFromEdge,beamsThickness+circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([circuit1X-circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}		
}

module ledDiffuser()
{
    
    diffuserCentralHoleR=7.2/2;
    diffuserCentralHoleR2=11/2;
    diffuserLedCompartmentDepth=2;
    diffuserWireChanelWidth=5.2;
    diffuserBaseX=buttonsAreaX-1-5-0.5;
    diffuserBaseY=buttonsHoleRadius*2+buttonDecalY/2-1;
    diffuserBaseThickness=3;
    diffuserButtonCylinderZ=3;
    
    translate([bezel4x20X-0.5,0,0])
{
  
        for(i = [1 : 1 : 1])
        {
            translate([buttonDecalX+1,beamsThickness+buttonDecalY*i+buttonsHoleRadius+buttonsHoleRadius*2*(i-1),0])
                cylinder(r1=buttonsHoleRadius-1,r2=buttonsHoleRadius-0.5,h=diffuserButtonCylinderZ,$fn=64);
        }
        difference()
        {
        translate([2,pillarsWidth1+beamsThickness+0.5,diffuserButtonCylinderZ])
        //#cube([buttonsAreaX-1-5,bezel4x20Y-pillarsWidth1*2-boxWallsThickness*2-1,boxWallsThickness*2]);
    cube([diffuserBaseX,diffuserBaseY,diffuserBaseThickness]);      
            translate([buttonDecalX+1,beamsThickness+buttonDecalY*1+buttonsHoleRadius+buttonsHoleRadius*2*(1-1),diffuserButtonCylinderZ])
            cylinder(r1=diffuserCentralHoleR,r2=diffuserCentralHoleR2,h=diffuserBaseThickness+0.5,$fn=32);
            
            
    translate([buttonDecalX+1-diffuserCentralHoleR2-4,beamsThickness+buttonDecalY*1+buttonsHoleRadius+buttonsHoleRadius*2*(1-1),boxWallsThickness-1])
            cylinder(r=1.05,r2=1.1,h=diffuserLedCompartmentDepth*4,$fn=32);
            
    translate([buttonDecalX+1+diffuserCentralHoleR2+4,beamsThickness+buttonDecalY*1+buttonsHoleRadius+buttonsHoleRadius*2*(1-1),boxWallsThickness-1])
            cylinder(r=1.05,r2=1.1,h=diffuserLedCompartmentDepth*4,$fn=32);
        
    translate([buttonDecalX+1-diffuserWireChanelWidth/2,beamsThickness+buttonDecalY*1+buttonsHoleRadius+buttonsHoleRadius*2*(1-1)-diffuserBaseX/2,diffuserButtonCylinderZ+diffuserButtonCylinderZ-1])    
           cube([diffuserWireChanelWidth,diffuserBaseX+2,boxWallsThickness+1]);
            //translate([buttonDecalX+1-7/2,beamsThickness+buttonDecalY*1+buttonsHoleRadius+buttonsHoleRadius*2*(1-1)-7/2,boxWallsThickness*2])
            //cube([7,7,boxWallsThickness+1]);
        }

}
}



module layersOddPillars(pillarsHeight=boxPart1Z)
{
    //pillars
translate([boxWallsThickness,boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);
translate([bezel4x20X+buttonsAreaX-pillarsWidth1-boxWallsThickness,boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);


translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);
translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness,boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);

   
translate([boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);
translate([bezel4x20X+buttonsAreaX-pillarsWidth1-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness,boxWallsThickness])    
    fixationPillar(pillarHeight=pillarsHeight);
}

module frontPanel()
{
bezel4x20(bezel4x20X,bezel4x20Y,boxWallsThickness,3/2);


translate([bezel4x20X-0.5,0,0])
{
    difference()
    {
        cube([buttonsAreaX,bezel4x20Y,boxWallsThickness]);
        for(i = [1 : 1 : nbButtons])
        {
            translate([buttonDecalX+1,beamsThickness+buttonDecalY*i+buttonsHoleRadius+buttonsHoleRadius*2*(i-1),-boxWallsThickness/2])
                cylinder(r=buttonsHoleRadius,h=boxWallsThickness*2);
        }
        
    }
}

layersOddPillars(boxPart1Z);




//beams
translate([0,0,boxWallsThickness])
    cube([bezel4x20X+buttonsAreaX-0.5,beamsThickness,beamsThickness]);
translate([0,bezel4x20Y-beamsThickness,boxWallsThickness])
    cube([bezel4x20X+buttonsAreaX-0.5,beamsThickness,beamsThickness]);

translate([0,0,boxWallsThickness])
    cube([beamsThickness,bezel4x20Y,beamsThickness]);
translate([bezel4x20X+buttonsAreaX-beamsThickness-0.5,0,boxWallsThickness])
    cube([beamsThickness,bezel4x20Y,beamsThickness]);

translate([bezel4x20X-beamsThickness+1,0,boxWallsThickness])
    cube([beamsThickness,bezel4x20Y,beamsThickness]);

//walls
translate([0,0,boxWallsThickness])
    cube([bezel4x20X+buttonsAreaX-0.5,boxWallsThickness,boxPart1Z]);
translate([0,bezel4x20Y-boxWallsThickness,boxWallsThickness])
    cube([bezel4x20X+buttonsAreaX-0.5,boxWallsThickness,boxPart1Z]);
translate([0,0,boxWallsThickness])
    cube([boxWallsThickness,bezel4x20Y,boxPart1Z]);
translate([bezel4x20X+buttonsAreaX-boxWallsThickness-0.5,0,boxWallsThickness])
    cube([boxWallsThickness,bezel4x20Y,boxPart1Z]);

    
}
    



circuitBoardHeight=20;
boxInternalX=bezel4x20X+buttonsAreaX-boxWallsThickness;

module extraLayersStructure(wallsHeight=boxPart2Z)
{
        //beams
    translate([boxWallsThickness,boxWallsThickness,0])
    cube([pillarsWidth1,bezel4x20Y-boxWallsThickness*2,boxWallsThickness]);
    
    translate([boxInternalX-pillarsWidth1,boxWallsThickness,0])
    cube([pillarsWidth1,bezel4x20Y-boxWallsThickness*2,boxWallsThickness]);
    
    translate([boxInternalX/2-pillarsWidth1,boxWallsThickness,0])
    cube([pillarsWidth1,bezel4x20Y-boxWallsThickness*2,boxWallsThickness]);
    
    translate([boxWallsThickness,boxWallsThickness,0])
    cube([boxInternalX-boxWallsThickness,pillarsWidth1,boxWallsThickness]);
    
    translate([boxWallsThickness,bezel4x20Y-boxWallsThickness-pillarsWidth1,0])
    cube([boxInternalX-boxWallsThickness,pillarsWidth1,boxWallsThickness]);
    
    //walls
    translate([0,0,0])
        cube([bezel4x20X+buttonsAreaX-0.5,boxWallsThickness,wallsHeight]);
    translate([0,bezel4x20Y-boxWallsThickness,0])
        cube([bezel4x20X+buttonsAreaX-0.5,boxWallsThickness,wallsHeight]);
    translate([0,0,0])
        cube([boxWallsThickness,bezel4x20Y,wallsHeight]);
    translate([bezel4x20X+buttonsAreaX-boxWallsThickness-0.5,0,0])
        cube([boxWallsThickness,bezel4x20Y,wallsHeight]);
}

module layersEvenPillars(pillarsHeight=boxPart2Z)
{
    //pillars, left
    translate([boxWallsThickness,boxWallsThickness+pillarsWidth1*2,0])    
    fixationPillar(pillarHeight=pillarsHeight);
    translate([boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness-pillarsWidth1*2,0])    
    fixationPillar(pillarHeight=pillarsHeight);
    
    //middle pillars
    translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness+pillarsWidth1,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
    fixationPillar(pillarHeight=pillarsHeight);
    translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness+pillarsWidth1,boxWallsThickness,0])    
    fixationPillar(pillarHeight=pillarsHeight);
    
    //pillars, right
    translate([bezel4x20X+buttonsAreaX-pillarsWidth1-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness-pillarsWidth1*2,0])    
    fixationPillar(pillarHeight=pillarsHeight);
    translate([bezel4x20X+buttonsAreaX-pillarsWidth1-boxWallsThickness,boxWallsThickness+pillarsWidth1*2,0])    
    fixationPillar(pillarHeight=pillarsHeight);
}

module secondLayerNoHoles(layerHeight=boxPart2Z)
{
    color("green")
    {
        translate([0,0,boxPart1Z+boxWallsThickness])
        {

            extraLayersStructure(wallsHeight=layerHeight);
            
            layersEvenPillars(pillarsHeight=layerHeight);
            
            //middle pillars small
            translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness+pillarsWidth1*2,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1-boxWallsThickness+pillarsWidth1*2,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);

            //pillars, right small
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            
            translate([bezel4x20X-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            translate([bezel4x20X-boxWallsThickness,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            
            translate([bezel4x20X-pillarsWidth1*3-boxWallsThickness+buttonsAreaX,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            translate([bezel4x20X+buttonsAreaX-pillarsWidth1*3-boxWallsThickness,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            
            //circuit plate
            translate([12.5,3,boxWallsThickness])
            circuit1Plate();
        }
    }
}

holes001Depth=boxWallsThickness*4;

module extraLayersMainHoles()
{
    //left holes
        translate([boxWallsThickness+pillarsWidth1/2,boxWallsThickness+pillarsWidth1/2,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        translate([boxWallsThickness+pillarsWidth1/2,bezel4x20Y-boxWallsThickness - pillarsWidth1/2,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        //left holes, under pillars
        translate([boxWallsThickness+pillarsWidth1/2,boxWallsThickness+pillarsWidth1*2.5,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        translate([boxWallsThickness+pillarsWidth1/2,bezel4x20Y-pillarsWidth1-boxWallsThickness-pillarsWidth1*1.5,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        
        //middle holes
        translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2-boxWallsThickness,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);

        translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        //middle holes, under pillars
        translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2-boxWallsThickness+pillarsWidth1,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);

        translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2-boxWallsThickness+pillarsWidth1,boxWallsThickness+pillarsWidth1/2,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
            
            
           

       
       
       //pillars, right
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1/2-boxWallsThickness,bezel4x20Y-pillarsWidth1-boxWallsThickness-pillarsWidth1*1.5,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1*2.5,-1])   
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
            
        
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1/2-boxWallsThickness,bezel4x20Y-boxWallsThickness-pillarsWidth1*0.5,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1*0.5,-1])   
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
}

module secondLayer()
{

difference()
{
    secondLayerNoHoles();
    translate([0,0,boxPart1Z+boxWallsThickness])
    {
        extraLayersMainHoles();
        
         translate([bezel4x20X-pillarsWidth1*2.5-boxWallsThickness+buttonsAreaX,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1*2.5-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
         //small pillars on the left-middle
        translate([bezel4x20X-pillarsWidth1-boxWallsThickness+pillarsWidth1/2,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X-pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
        translate([bezel4x20X-boxWallsThickness+pillarsWidth1/2,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X+pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        //middle holes, small pillars
                   translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2+pillarsWidth1-boxWallsThickness+pillarsWidth1,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);

        translate([(bezel4x20X+buttonsAreaX)/2-pillarsWidth1/2+pillarsWidth1-boxWallsThickness+pillarsWidth1,boxWallsThickness+pillarsWidth1/2,-1])
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
    }
}
}
thirdLayerSmalllPillars1Decal=10;

module thirdLayer(layerHeight=boxPart3Z)
{
    
    piSupportDecalX=26-boxWallsThickness;
    piSupportDecalY=10;
    
    translate([0,0,boxPart1Z+boxPart2Z])
    {
        difference()
        {
            union()
            {
                layersOddPillars(pillarsHeight=layerHeight-boxWallsThickness);
                extraLayersStructure(wallsHeight=layerHeight);
                translate([piSupportDecalX,0,0])
                {
                    cube([pillarsWidth1,bezel4x20Y,boxWallsThickness]);
                    translate([0,piSupportDecalY,0])
                    piSupport2(1,1,6);
                    
                    translate([58,0,0])
                        cube([pillarsWidth1,bezel4x20Y,boxWallsThickness]);
                }
                 //pillars, right small
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness-thirdLayerSmalllPillars1Decal,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
                
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness-thirdLayerSmalllPillars1Decal,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            
            
            translate([bezel4x20X-pillarsWidth1*3-boxWallsThickness+buttonsAreaX,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);
            translate([bezel4x20X+buttonsAreaX-pillarsWidth1*3-boxWallsThickness,boxWallsThickness,0])    
            fixationPillar(pillarHeight=5);

            }
            extraLayersMainHoles();
            translate([-2,piSupportDecalY-1,8])
                cube([20,60,30]);
            
            translate([piSupportDecalX+10,bezel4x20Y-8,8])
                cube([55,60,30]);
            
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness+pillarsWidth1/2-thirdLayerSmalllPillars1Decal,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X-pillarsWidth1/2-boxWallsThickness-thirdLayerSmalllPillars1Decal,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1*2-boxWallsThickness-pillarsWidth1/2,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X+buttonsAreaX-pillarsWidth1*2+pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        }
            
    }
    
}

module spacerLayer(layerHeight=6)
{
 
    
    translate([0,0,boxPart1Z+boxPart2Z])
    {
        difference()
        {
            union()
            {
                layersOddPillars(pillarsHeight=layerHeight-boxWallsThickness);
                layersEvenPillars(pillarsHeight=layerHeight);
                extraLayersStructure(wallsHeight=layerHeight);
                
                 //pillars, right small
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness-thirdLayerSmalllPillars1Decal,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=layerHeight);
                
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness-thirdLayerSmalllPillars1Decal,boxWallsThickness,0])    
            fixationPillar(pillarHeight=layerHeight);
            
            
            translate([bezel4x20X-pillarsWidth1*3-boxWallsThickness+buttonsAreaX,bezel4x20Y-pillarsWidth1-boxWallsThickness,0])    
            fixationPillar(pillarHeight=layerHeight);
            translate([bezel4x20X+buttonsAreaX-pillarsWidth1*3-boxWallsThickness,boxWallsThickness,0])    
            fixationPillar(pillarHeight=layerHeight);

            }
            extraLayersMainHoles();
            
            
            translate([bezel4x20X/2,pillarsWidth1+boxWallsThickness,-1])
                cube([20,bezel4x20Y-pillarsWidth1*2-boxWallsThickness*2,30]);
            
            
            
            translate([bezel4x20X-pillarsWidth1-boxWallsThickness+pillarsWidth1/2-thirdLayerSmalllPillars1Decal,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X-pillarsWidth1/2-boxWallsThickness-thirdLayerSmalllPillars1Decal,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
            
        translate([bezel4x20X+buttonsAreaX-pillarsWidth1*2-boxWallsThickness-pillarsWidth1/2,bezel4x20Y-pillarsWidth1/2-boxWallsThickness,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
    translate([bezel4x20X+buttonsAreaX-pillarsWidth1*2+pillarsWidth1/2-boxWallsThickness,boxWallsThickness+pillarsWidth1/2,-1])    
            cylinder(r=screwHoles1Radius,h=holes001Depth,$fn=12);
        
        }
            
    }
    
}


//frontPanel();

rotate([180,0,0])
ledDiffuser();

//secondLayer();

//thirdLayer();
//spacerLayer();






    

    
    
    

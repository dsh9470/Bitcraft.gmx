// variables

// TESTING: changing to be room_height-independent - change room_height refs to variable

var roomh = 800; // 3/4 of room for now

var starth = (roomh / 2) - floor(random(roomh / 3));
starth = (starth div 32) * 32;

if(global.sealevel == 0) global.sealevel = starth + 96;

var start_room = argument0;
var end_room = argument0 + 1600;

var alth = starth;

var dirtlevel;
var stonelevel;
var level;

//for loop generation
//for each x-grid, generate grass, then generate dirt and stone below
for(xx = start_room; xx < end_room; xx += 32)
{

    // revision: water spawn (when alth below starting height (sea level)
    /*
    for (yy = global.sealevel; yy < alth; yy += 32)
    {
        instance_create(xx, yy, obj_water);
    }
    */


    //tree spawn - only above sea level
    treespawn = floor(random(15));
    if(treespawn == 0)
        with(instance_create(xx, alth-32, obj_cactus))
        {
            canGrow = true;
        }    

    instance_create(xx, alth, obj_des_grass);

    //set max depth for dirt and stone
    //play with this to mess with dirt generation
    dirtlevel = ((roomh + floor(random(alth/2))) div 32) * 32;
    stonelevel = ((room_height) div 32) * 32;
    
    //dirt level and coal spawn
    for(yy = alth; yy < dirtlevel; yy += 32)
    {
    
        var coalspawn = floor(random(27));
        if(coalspawn == 0)
        {  
            instance_create(xx, yy + 32, obj_coal);
        }
        else
        {
            instance_create(xx, yy + 32, obj_des_dirt);
        }
        level = yy;
    }
  
  
  //stone & water level with ore spawn
  for(yy = (level + 32); yy < stonelevel; yy += 32)
  {
  
        //bedrock generation
        if(yy >= stonelevel - 32) 
        {
            instance_create(xx,yy + 32, obj_bedrock);
            break;
        }
  
        else if(yy >= alth)
        {
        
            var orespawn = floor(random(27));
            
            if(orespawn == 1 || orespawn == 2)
            {
                instance_create(xx, yy + 32, obj_coal);
            }
            
            
            if(orespawn == 0)
            {
                //if more than halfway through stone level, spawn gold. else, copper
                if(yy >= (stonelevel - ((stonelevel - level)/2)))
                {
                    instance_create(xx, yy + 32, obj_gold);
                }
                else
                {
                    instance_create(xx, yy + 32, obj_copper);   
                }
                 
            }
            else
            {
                instance_create(xx, yy + 32, obj_stone);
            }
        }
        else
        instance_create(xx, yy + 32, obj_water);
  }
  
  //vary terrain
      
  alth += choose(32, 0, -32);
 
    
}

return end_room;

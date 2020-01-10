////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Comic Crazy II
// Dwayne Hurst
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {
</ label="--------  Main theme layout  --------", help="Show or hide additional images", order=1 /> uct1="select below";
   </ label="Select listbox, wheel, vert_wheel", help="Select wheel type or listbox", options="listbox", order=4 /> enable_list_type="listbox";
   </ label="Select spinwheel art", help="The artwork to spin", options="marquee,wheel", order=5 /> orbit_art="wheel";
   </ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=6 /> transition_ms="25";  
</ label=" ", help=" ", options=" ", order=10 /> divider5="";
</ label="--------    Miscellaneous    --------", help="Miscellaneous options", order=16 /> uct6="select below";
   </ label="Enable monitor static effect", help="Show static effect when snap is null", options="Yes,No", order=18 /> enable_static="No"; 
   </ label="Random Wheel Sounds", help="Play random sounds when navigating games wheel", options="Yes,No", order=25 /> enable_random_sound="Yes";
}

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.font="badabb.ttf";

// modules
fe.load_module("fade");
fe.load_module( "animate" );
fe.load_module("scrollingtext");

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = true;

// now position and pinch surface of snap
// adjust the below values for the game video preview snap
surface_snap.set_pos(flx*0.32, fly*0.09, flw*0.52, flh*0.7);
surface_snap.skew_y = 0;
surface_snap.skew_x = 0;
surface_snap.pinch_y = 0;
surface_snap.pinch_x = 0;
surface_snap.rotation = 8.6;

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// Load background image
local b_art = fe.add_image("backgrounds/Default.png", 0, 0, flw, flh );
local b_art = fe.add_image("backgrounds/[DisplayName].png", 0, 0, flw, flh );

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// The following section sets up what type and wheel and displays the users choice
if ( my_config["enable_list_type"] == "listbox" )
{
local listbox = fe.add_listbox( flx*0.01, fly*0.025, flw*0.325, flh*0.55 );
listbox.rows = 15;
listbox.charsize = 28;
listbox.set_rgb( 0, 0, 0 );
listbox.bg_alpha = 0;
listbox.align = Align.Left;
listbox.selbg_alpha = 0;
listbox.sel_red = 225;
listbox.sel_green = 0;
listbox.sel_blue = 0;
}

// Play random sound when transitioning to next / previous game on wheel
function sound_transitions(ttype, var, ttime) 
{
	if (my_config["enable_random_sound"] == "Yes")
	{
		local random_num = floor(((rand() % 1000 ) / 1000.0) * (124 - (1 - 1)) + 1);
		local sound_name = "sounds/GS"+random_num+".mp3";
		switch(ttype) 
		{
		case Transition.EndNavigation:		
			local Wheelclick = fe.add_sound(sound_name);
			Wheelclick.playing=true;
			break;
		}
		return false;
	}
}
fe.add_transition_callback("sound_transitions")

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//word pop

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "pop/"+random_num+".png";
        }
    }
}

//word pop1
::OBJECTS <- {
  wordpop1 = fe.add_image("pop/1.png", flx*0.19, fly*0.01, flw*0.225, flh*0.275),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "scale", start = 0.01, end = 1, time = 750, tween = Tween.Back, delay = 200
}
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//word pop2
::OBJECTS <- {
  wordpop2 = fe.add_image("pop/1.png", flx*0.55, fly*0.75, flw*0.15, flh*0.2),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "scale", start = 0.01, end = 1, time = 1000, tween = Tween.Back
}
OBJECTS.wordpop2.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop2, move_transition1 ) );
PopImage1(OBJECTS.wordpop2);

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//category genre 

::OBJECTS <- {
  glogo1 = fe.add_image("glogos/[DisplayName].png", flx*0.7, fly*0.15, flw*0.3, flh*0.85),
}

local move_transition1 = {
  when = Transition.EndNavigation ,property = "x", start = flx*2.0, end = flx*0.7, time = 750, tween = Tween.Linear
}
OBJECTS.glogo1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.glogo1, move_transition1 ) );





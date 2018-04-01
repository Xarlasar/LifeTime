///@description scr_enable_physics
///@arg xvel
///@arg yvel
///@arg fric
///@arg canSet

xvel = argument0;
yvel = argument1;
fric = argument2;
canSet = argument3;

var state = "Idle";
var grav = gamemanager.grav;		
var grounded	= place_meeting(x,y+1,collider);		
var justImpacted = 0;				
if place_meeting(x,y-1, collider) { yvel = 0.5; }
if grounded and !justImpacted and canSet {	justImpacted = 1;	canSet = 0;	} else 
if grounded and justImpacted and !canSet {	justImpacted = 0;	canSet = 0;	} else	
if !grounded {	canSet = 1;	state = "Airborne"; }
if !grounded {	yvel += grav; } else { if justImpacted {	yvel = 0;	}}					
xvel = clamp(xvel, -global.termVel, global.termVel);
yvel = clamp(yvel, -global.termVel, global.termVel);
if yvel > 0 {	move_contact_solid(270, abs(yvel)); }
if yvel < 0 {	move_contact_solid(90,	abs(yvel)); }
if xvel > 0 {	move_contact_solid(180, abs(xvel)); if abs(xvel) > fric {	xvel -= fric;	} else {	xvel = 0;	}}
if xvel < 0 {	move_contact_solid(0,	abs(xvel)); if abs(xvel) > fric {	xvel += fric;	} else {	xvel = 0;	}}
return state;
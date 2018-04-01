
state = scr_physics(xvel, yvel, fric, canSet);

//INPUTS
var key_left	= keyboard_check(gamemanager.key_left);
var key_right	= keyboard_check(gamemanager.key_right);
var key_jump    = keyboard_check_pressed(gamemanager.key_jump);

var key_dash_hold		= mouse_check_button(gamemanager.key_dash);
var key_dash_release	= mouse_check_button_released(gamemanager.key_dash);

//STATEMACHINE
var xMove = (key_right - key_left) * moveSpeed;
var grounded = (state != "Airborne");

if xMove {state = "Moving";}
if key_jump {state = "Jumping";}
if key_dash_hold  { state = "Charging"; }
if key_dash_release { state = "Dash"; }


switch state {
	case "Charging":
		if canCharge {
			charge += 1;
			canCharge = 0;
			alarm[0] = cooldown;
			charge = clamp(charge, 0, 6);
		}		
	break;
	case "Dash":
		var dist = charge * 32;
		var mx = mouse_x, var my = mouse_y;
		var dir = point_direction(x,y,mx,my);
		move_contact_solid(dir, dist);			
		charge = 0;			
		
	break;
	case "Idle":
		
		
		
	break;
	case "Moving":		
		moveSpeed = walkSpeed;
	break;
	case "Jumping":
		yvel += -jumpPower * key_jump * grounded;			
	break;
}
xMove = (key_right - key_left) * moveSpeed;
if abs(xvel) >= moveSpeed {	xMove = 0;	}
xvel -= xMove;
state = scr_physics(xvel, yvel, fric, canSet);

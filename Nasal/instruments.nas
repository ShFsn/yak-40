# Some functions from:
# NASAL instruments for TU-154B
# Yurik V. Nikiforoff, yurik@megasignal.com
# Novosibirsk, Russia
# jun 2007
# Some rebuild for yak-40 by Mikhail Zuev april 2010
print("Initializing instruments system");

#########################################
## ARK-9
#########################################
var ARK9power1 = func() {
	if( getprop("yak-40/AZS/l0201" ) == 1.0 and getprop("yak-40/ARK-9/kn_mode-1" ) > 0 ) {
	setprop("instrumentation/adf[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/adf[0]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/l0201", ARK9power1, 0, 0);
 setlistener("yak-40/ARK-9/kn_mode-1", ARK9power1, 0, 0);

var ARK9power2 = func() {
	if( getprop("yak-40/AZS/r0201" ) == 1.0 and getprop("yak-40/ARK-9/kn_mode-2" ) > 0 ) {
	setprop("instrumentation/adf[1]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/adf[1]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/r0201", ARK9power2, 0, 0);
 setlistener("yak-40/ARK-9/kn_mode-2", ARK9power2, 0, 0);

# VOLUME
var ARK9volume1 = func() {
	if( getprop("instrumentation/adf[0]/serviceable" ) == 1 ) {
	setprop("instrumentation/adf[0]/volume-norm", getprop("yak-40/ARK-9/kn_volume-1" ) );
	}
	else {
	interpolate("instrumentation/adf[0]/volume-norm", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/adf[0]/serviceable", ARK9volume1, 0, 0);
 setlistener("yak-40/ARK-9/kn_volume-1", ARK9volume1, 0, 0);

# FREQUENCIES
var ARK9freq1 = func() {
	var main1orrsrv1freq = getprop("yak-40/ARK-9/sw_freq_main1-rsrv1");
	if ( main1orrsrv1freq == 1.0 ) {
		var ark1freq100 = getprop("yak-40/ARK-9/main1Freq_100");
		var ark1freq10 = getprop("yak-40/ARK-9/main1Freq_10");
		var ark1freq1 = getprop("yak-40/ARK-9/main1Freq_1");
	}
	else {
		var ark1freq100 = getprop("yak-40/ARK-9/rsrv1Freq_100");
		var ark1freq10 = getprop("yak-40/ARK-9/rsrv1Freq_10");
		var ark1freq1 = getprop("yak-40/ARK-9/rsrv1Freq_1");
	}
	var ark1freqout = ark1freq100 + ark1freq10 + ark1freq1 ;

	setprop("instrumentation/adf[0]/frequencies/selected-khz", ark1freqout);
}

 setlistener("/sim/signals/fdm-initialized", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/sw_freq_main1-rsrv1", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_100", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_10", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/main1Freq_1", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_100", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_10", ARK9freq1, 0, 0);
 setlistener("yak-40/ARK-9/rsrv1Freq_1", ARK9freq1, 0, 0);


var ARK9freq2 = func() {
	var main2orrsrv2freq = getprop("yak-40/ARK-9/sw_freq_main2-rsrv2");
	if ( main2orrsrv2freq == 1.0 ) {
		var ark2freq100 = getprop("yak-40/ARK-9/main2Freq_100");
		var ark2freq10 = getprop("yak-40/ARK-9/main2Freq_10");
		var ark2freq1 = getprop("yak-40/ARK-9/main2Freq_1");
	}
	else {
		var ark2freq100 = getprop("yak-40/ARK-9/rsrv2Freq_100");
		var ark2freq10 = getprop("yak-40/ARK-9/rsrv2Freq_10");
		var ark2freq1 = getprop("yak-40/ARK-9/rsrv2Freq_1");
	}
	var ark2freqout = ark2freq100 + ark2freq10 + ark2freq1 ;

	setprop("instrumentation/adf[1]/frequencies/selected-khz", ark2freqout);
}

 setlistener("/sim/signals/fdm-initialized", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/sw_freq_main2-rsrv2", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_100", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_10", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/main2Freq_1", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_100", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_10", ARK9freq2, 0, 0);
 setlistener("yak-40/ARK-9/rsrv2Freq_1", ARK9freq2, 0, 0);

init_instruments = func {	
  setprop("/instrumentation/airspeed-indicator/serviceable", 1);
	setprop("/instrumentation/altimeter/serviceable", 1);
	setprop("/instrumentation/inst-vertical-speed-indicator/serviceable", 1);
	setprop("/instrumentation/vertical-speed-indicator/serviceable", 1);
	setprop("yak-40/instrumentation/vph/serviceable", 1);
	setprop("yak-40/instrumentation/msrp/serviceable", 1);
	setprop("/instrumentation/ite2t_1/fail",0);
	setprop("/instrumentation/ite2t_2/fail",0);
	setprop("/instrumentation/ite2t_3/fail",0);
	setprop("yak-40/instrumentation/npp/left/zpu", 0.0);
	setprop("yak-40/instrumentation/npp/left/mode", 1);
	setprop("yak-40/instrumentation/altimeter[1]/powered", 1);
	}

setlistener("sim/signals/fdm-initialized", init_instruments);

#########################################
## Kurs MP-70
#########################################
var kurs_mp1power = func() {
	if( getprop("yak-40/AZS/l0101" ) == 1.0 ) {
	setprop("instrumentation/nav[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/nav[0]/serviceable", "false" );
	}
}
# setlistener("yak-40/AZS/l0101", kurs_mp1power, 0, 0);

# FREQUENCIES
var kurs_mp1freq = func() {
	var kurs_mp1freq1 = getprop("yak-40/Kurs-MP-70/kn_pu1-freq1");
	var kurs_mp1freq2 = getprop("yak-40/Kurs-MP-70/kn_pu1-freq2");
	var kurs_mp1freqout = kurs_mp1freq1 + kurs_mp1freq2 ;
	setprop("instrumentation/nav[0]/frequencies/selected-mhz", kurs_mp1freqout);
}
 setlistener("sim/signals/fdm-initialized", kurs_mp1freq, 0, 0);
 setlistener("yak-40/Kurs-MP-70/kn_pu1-freq1", kurs_mp1freq, 0, 0);
 setlistener("yak-40/Kurs-MP-70/kn_pu1-freq2", kurs_mp1freq, 0, 0);

# VOLUME
var kurs_mp1vol = func() {
#	if( getprop("instrumentation/comm[0]/serviceable" ) == 1 ) {
	setprop("instrumentation/nav[0]/volume-norm", getprop("yak-40/Landysh/kn_volume-1" ) );
#	}
#	else {
#	interpolate("instrumentation/comm[0]/volume-norm", 0.0, 0.5 );
#	}
}
# setlistener("instrumentation/nav[0]/serviceable", kurs_mp1vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-1", kurs_mp1vol, 0, 0);

#########################################
## Landysh
#########################################
var landysh1power = func() {
	if( getprop("yak-40/AZS/l0101" ) == 1.0 ) {
	setprop("instrumentation/comm[0]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/comm[0]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/l0101", landysh1power, 0, 0);

var landysh2power = func() {
	if( getprop("yak-40/AZS/r0101" ) == 1.0 ) {
	setprop("instrumentation/comm[1]/serviceable", "true" );
	}
	else {
	setprop("instrumentation/comm[1]/serviceable", "false" );
	}
}
 setlistener("yak-40/AZS/r0101", landysh2power, 0, 0);


# FREQUENCIES
var landysh1freq = func() {
	var landysh1freq1 = getprop("yak-40/Landysh/freq1-1");
	var landysh1freq2 = getprop("yak-40/Landysh/freq2-1");
	var landysh1freqout = landysh1freq1 + landysh1freq2 ;
	setprop("instrumentation/comm[0]/frequencies/selected-mhz", landysh1freqout);
}
 setlistener("sim/signals/fdm-initialized", landysh1freq, 0, 0);
 setlistener("yak-40/Landysh/freq1-1", landysh1freq, 0, 0);
 setlistener("yak-40/Landysh/freq2-1", landysh1freq, 0, 0);

var landysh2freq = func() {
	var landysh2freq1 = getprop("yak-40/Landysh/freq1-2");
	var landysh2freq2 = getprop("yak-40/Landysh/freq2-2");
	var landysh2freqout = landysh2freq1 + landysh2freq2 ;

	setprop("instrumentation/comm[1]/frequencies/selected-mhz", landysh2freqout);
}
 setlistener("sim/signals/fdm-initialized", landysh2freq, 0, 0);
 setlistener("yak-40/Landysh/freq1-2", landysh2freq, 0, 0);
 setlistener("yak-40/Landysh/freq2-2", landysh2freq, 0, 0);

# VOLUME
var landysh1vol = func() {
	if( getprop("instrumentation/comm[0]/serviceable" ) == 1 ) {
	setprop("instrumentation/comm[0]/volume-norm", getprop("yak-40/Landysh/kn_volume-1" ) );
	}
	else {
	interpolate("instrumentation/comm[0]/volume-norm", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/comm[0]/serviceable", landysh1vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-1", landysh1vol, 0, 0);

var landysh2vol = func() {
	if( getprop("instrumentation/comm[1]/serviceable" ) == 1 ) {
	setprop("instrumentation/comm[1]/volume-norm", getprop("yak-40/Landysh/kn_volume-2" ) );
	}
	else {
	interpolate("instrumentation/comm[1]/volume-norm", 0.0, 0.5 );
	}
}
 setlistener("instrumentation/comm[1]/serviceable", landysh2vol, 0, 0);
 setlistener("yak-40/Landysh/kn_volume-2", landysh2vol, 0, 0);

###########################
# RV-5M support
rv5m_handler = func{
settimer( rv5m_handler, 0.1 );
# Arretir:
if( getprop("yak-40/instrumentation/rv-5m/caged-flag" ) != 0 )
	{
	setprop("yak-40/instrumentation/rv-5m/warn", 0 );
	setprop("yak-40/instrumentation/rv-5m/indicated-altitude-m", 0.0 );
	return;
	}
if( getprop("yak-40/instrumentation/rv-5m/serviceable" ) != 1 ) 
	{
        setprop("yak-40/instrumentation/rv-5m/warn", 0 );
        return;
	}
# get altitude and check if device is warmed
#var alt = getprop("fdm/jsbsim/instrumentation/indicated-altitude-m");
var altf = getprop("fdm/jsbsim/position/h-agl-ft");
var hot = getprop("yak-40/instrumentation/rv-5m/hot");
var alt = altf * 0.3048;	# go to meters
if( alt == nil ) alt = 0.0;
if( hot == nil ) hot = 0.0;
if( alt < hot ) alt = hot;
interpolate("yak-40/instrumentation/rv-5m/indicated-altitude-m", alt-2, 0.1 );
# check warning
var limit = getprop("yak-40/instrumentation/rv-5m/index-m");
if( limit == nil ) return;
if( alt < limit ) 
	{
	setprop("yak-40/instrumentation/rv-5m/warn", 1 );
#	interpolate("tu154/systems/electrical/indicators/radioaltimeter-limit", 1.0, 0.1);
	}
else { 
	setprop("yak-40/instrumentation/rv-5m/warn", 0 );
#	interpolate("tu154/systems/electrical/indicators/radioaltimeter-limit", 0.0, 0.1);
	}
}

rv5m_power = func{
if( getprop( "yak-40/switches/rv-5-1" ) == 1.0 )
	{
	setprop("yak-40/instrumentation/rv-5m/hot", 5000.0 );
	setprop("yak-40/instrumentation/rv-5m/serviceable", true );
	
	}
else {
	setprop("yak-40/instrumentation/rv-5m/hot", 0 );
	setprop("yak-40/instrumentation/rv-5m/serviceable", false );
	}
}

# setlistener("yak-40/switches/rv-5-1", rv5m_power,0,0);
# setlistener("yak-40/instrumentation/rv-5m/serviceable", rv5m_power,0,0);


# rv5m_handler();
###########################

############################################################################
# IKU support
############################################################################
iku_handler = func {
settimer( iku_handler, 0.1 );

#Captain panel
# yellow needle1
var sel_yellow = getprop("yak-40/instrumentation/iku/l-mode");
if( sel_yellow == nil ) sel_yellow = 0.0;
var param_yellow = getprop("instrumentation/nav[0]/radials/reciprocal-radial-deg");
if( param_yellow == nil ) param_yellow = 0.0;
var compass = getprop("/orientation/heading-magnetic-deg");
if( compass == nil ) compass = 0.0;
if( sel_yellow == 0.0 ) # ADF
	param_yellow = getprop("instrumentation/adf[0]/indicated-bearing-deg");
else param_yellow -= compass;
if( param_yellow == nil ) param_yellow = 0.0;
setprop("yak-40/instrumentation/iku/indicated-heading-l", param_yellow );
# White needle
var sel_white = getprop("yak-40/instrumentation/iku/r-mode");
if( sel_white == nil ) sel_white = 0.0;
var param_white = getprop("instrumentation/nav[1]/radials/reciprocal-radial-deg");
if( param_white == nil ) param_white = 0.0;
if( sel_white == 0.0 ) # ADF
	param_white = getprop("instrumentation/adf[1]/indicated-bearing-deg");
else param_white -= compass;
if( param_white == nil ) param_white = 0.0;
setprop("yak-40/instrumentation/iku/indicated-heading-r", param_white );
}
 iku_handler();

# Heading (yellow index, left handle)
compass_adjust_hdg = func {
var prop = "yak-40/instrumentation/iku/heading-deg";
if( arg[0] == 1 ) prop = "yak-40/instrumentation/iku/heading-deg";

var delta = arg[1];
var heading = getprop( prop );
if( heading == nil ) return;

heading = heading + delta;
if( heading >= 360.0 ) heading = heading - 360.0;
if( 0 > heading ) heading = heading + 360.0; 
setprop( prop, heading );
# proceed delayed property for smooth digit wheel animation
prop = sprintf("%s-delayed", prop);
interpolate( prop, heading, 0.2 );
}

# "Plane" (white needle2, right handle with plane symbol)
compass_adjust_plane = func {
var prop = "yak-40/instrumentation/iku/plane-deg";
if( arg[0] == 1 ) prop = "yak-40/instrumentation/iku/plane-deg";

var delta = arg[1];
# proceed delayed property for smooth digit wheel animation
var delayed_prop = sprintf("%s-delayed", prop);
var local_prop = sprintf("%s-local", prop);

var heading = getprop( local_prop );
if( heading == nil ) return;
heading = heading + delta;
if( heading >= 360.0 ) heading = heading - 360.0;
if( 0 > heading ) heading = heading + 360.0; 

setprop( local_prop, heading );
interpolate( delayed_prop, heading, 0.2 );
# proceed white needle

  setprop( "yak-40/instrumentation/iku/plane-deg", heading );
  setprop( "yak-40/instrumentation/iku/plane-deg", heading );
}

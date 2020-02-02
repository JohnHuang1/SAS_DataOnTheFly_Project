ods graphics / maxobs=12000000 imagefmt=GIF width=786 height=590;
options                
       nodate nonumber                            
       animduration=0.1 animloop=yes noanimoverlay
       printerpath=gif animation=start;           
ods printer file="&savepath/golf.gif";                            
proc sgplot data=plotdata dattrmap=colordata;
	by timestamp;
	polygon x=long y=lat id=id_c / group=statecode nofill
		outline name="map";
	scatter x=longitude y=latitude /
		group=tailnumber
		markerattrs=(symbol=circlefilled size=5)
		attrid=id
		name="loc";
	keylegend "map" / exclude=(" ");
	xaxis display=none;
	yaxis display=none;
run;

ods html select all;
ods html close;
options printerpath=gif animation=stop;
ods printer close;

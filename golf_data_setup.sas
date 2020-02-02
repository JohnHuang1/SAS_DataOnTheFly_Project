data golf;
	infile "yourpath/golf_team_data.csv" dlm=',' dsd missover;
	input id $ address  registration $ tailnumber $ signallevel squawk latitude longitude altitude diffFromBaroAlt track groundspeed verticalvelocity _timestamp :$40.;
	_timestamp = substr(_timestamp, 1, length(_timestamp)-10);
	timestamp = round(input(_timestamp, ANYDTDTM23.), 1);
	format timestamp DATETIME.;
/* 	if id = 'golf'; This was needed with the full raw data */
	keep latitude longitude timestamp address tailnumber;
run;

proc sort data=golf nodupkey;
	by timestamp address;
run;

data golf timestamps(keep=timestamp) colordata(keep=tailnumber rename=(tailnumber = value));
	set golf;
/* 	if address in (10538941, 11318471); */
/* 	if timestamp < input("16NOV18:16:00:00", ANYDTDTM23.); */
run;

proc sort data=colordata nodupkey;
	by value;
run;

proc sort data=timestamps nodupkey;
	by timestamp;
run;

data colordata;
	set colordata;
	length markercolor $8.;
	id = 'id';
	markercolor = "CX";
	markercolor = cats(markercolor, 
			put(rand("Integer", 0, 255), hex2.),
			put(rand("Integer", 0, 255), hex2.), 
			put(rand("Integer", 0, 255), hex2.));
run;

data map_data;
	 length id_c $ 32;
	 set mapsgfk.us_states;
	 if StateCode in ("NC", "VA");
	
	 id_c = catx("_", id, segment);
	 keep long lat x y resolution density statecode id_c;
run;

proc sql noprint;
	create table map_time_data as
	select * from timestamps cross join map_data;
run;

data plotdata;
	set golf map_time_data;
run;

proc sort data=plotdata nodup;
	by timestamp;
run;
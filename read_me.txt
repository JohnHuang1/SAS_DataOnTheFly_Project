This program was used to parse a raw data set of information recieved from ariel vehicles such as planes and helicopters.
My team then decided to create an animated map of the planes, similar to the one we saw as a demonstration when we first
gathered the data at a field trip to an RDU airport. 

First, data is read from the golf_team_data.csv file by golf_data_setup.sas.
Then, the datasets created by golf_data_setup.sas is used by golf_data_map.sas 
  to create a gif of the locations of the planes on a map of North Carolina.

The original dataset was too large to put into github so I sorted it to only use the "Golf" team's data which is something 
golf_data_setup.sas originally did anyway.

golf_10sec_interval.gif is the gif outputed by the program. the 1 second interval gif was too large to put into github as well.

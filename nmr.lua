--function create_scrollview(main_window_main_frame,curr_project, curr_type, filter_pattern)
--function create_filter_controls(main_window_main_frame0)
--function date_stamp() 	 
--function extract_attributes_named(whatis)
--function AttributeEditor(record_OID)  
--function create_current_status_infolines(main_window_main_frame)
--function create_body_AttrEdit(at_main_window_main_frame1,at_numb_of_attr1,at_main_szx,at_main_szy,at_entry_szy )
--function versify_any_name(strinp) 
--function Improve_name(strinp) 	 

--function DuplicateEntry(record_OID)
--function RemoveEntry(record_OID)
--function CreateEntry(name, type)
--function ExportEntry(record_OID)
--function ImportEntry(record_OID)
--function ContentEditor(record_type) (in file scroll_view) 
--function calc_power_set(curren_pulse90,reference_shape_constant,calibration_pulse90,calibration_power_db) 	 
--function execute_by_type_name(curr_type, record_name)
--function retrive_by_type_name(curr_type, record_name) --return text of entry
--function retriveOID_by_type_name(curr_type, record_name)  --return record OID
--function get_nmr_directory()
--function get_out_macro() --returns name for output macro for TopSpin 
--function get_cur_spectrometer()
--function get_cur_browser()
--function get_cur_sample()
--function get_cur_macro()
--function get_cur_help_URL()
--function add_string_to_body_of_currentsettings(strng)
--function StartPage()   
--function find_pattern(search_text, search_pattern) --retuns value in ["key"]="value"
--function CreateDomXML(items4export) --Bundles selected items and subitems into DomDocument
--function createRecordsFromDom(dom) --returns number of created records
--function open_in_browser(xmlfile) --filetype="file:///" or "http://"
--function CreatePHPBB3text(items4DomXML)
--function parseRecordsFromPHPBB3(pastedtxt)
--function find_text_between_tags(search_text, tag1,tag2) --retuns text between tags next to each other, and outside text
--function insert_to_spectrometer_after(variable, inserttxt)
--function ExportMacro(exp_environment, exp_environment_afterGetprosol)
--function ExportMacroSSR(exp_vars,lns, numb)
--function text_between_onesymboltags(search_text, pattern) --pattern: %bxy, e.g. %b()
--function remove_bruker_comments(search_text) --pattern: "%b;\n"
--function To_Spinach() -- 
--function Predict_SN()
--function BufferGetPpm( buffer, index )
--function Draw1Dspectrum(t.SpectrumName)
--function Multiple1Doverlay(selected_OIDs)
--function RMSDinPpmRange(buffer, ppmStart, ppmEnd)
--function MeanInPpmRange(buffer, ppmStart, ppmEnd) --
--function CreateCurrentSettingsAndAllComponents()

number_of_opened_AttributeEditors=0 -- this is used to tail multiple started AEs
number_of_opened_ContentManagers=0 -- this is used to tail multiple started CMs

keywords = {
[1]="1D",
[2]="2D",
[3]="3D",
[4]="15N",
[5]="13C",
[6]="calibration",
[7]="relaxation",
[8]="tocsy",
[9]="noesy",
[10]="hsqc",
[11]="hmqc",
[12]="NOE",
[13]="diffusion",
[14]="Spinach",
[15]="Pervushin",
[16]="st2-pt"
}
-- ICONS
	xpmScript = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c grey"
"g c black"
"o c yellow"
". c None"
"g.............gg"
"gcg.........g.g."
"gccg......g...g."
"g...cg...go...g."
"g....cg.goo...g."
"g....ccgooo...g."
"g....ccgoo....g."
"g....ccgoo....g."
"g....ccgoo....g."
"g....ccgoo....g."
"g...cccgoo....g."
"..gccccgoo..g..."
"...ggccgoog....."
".....gcgog......"
"......ggg......."
".......g........"
]]
iconScript = dlg.createIcon( xpmScript )
	xpmScriptRed = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c grey"
"g c black"
"o c red"
". c None"
"g.............gg"
"gcg.........g.g."
"gccg......g...g."
"g...cg...go...g."
"g....cg.goo...g."
"g....ccgooo...g."
"g....ccgoo....g."
"g....ccgoo....g."
"g....ccgoo....g."
"g....ccgoo....g."
"g...cccgoo....g."
"..gccccgoo..g..."
"...ggccgoog....."
".....gcgog......"
"......ggg......."
".......g........"
]]
iconScriptRed = dlg.createIcon( xpmScriptRed )

	xpmWave = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c magenta"
"g c black"
"o c blue"
". c None"
"................"
".......o........"
"......ooo......."
".....ooooo......"
".....ooooo......"
"....ooooooo....."
"....ooooooo....."
"...oooooooo....."
"...oooooooo....."
"...oooooooo....o"
"ooo........ooooo"
"ooo........ooooo"
"oo..........oooo"
"o...........ooo."
"o............o.."
"................"
]]
iconWave = dlg.createIcon( xpmWave )

	xpmWaveRed = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c magenta"
"g c black"
"o c red"
". c None"
"................"
".......o........"
"......ooo......."
".....ooooo......"
".....ooooo......"
"....ooooooo....."
"....ooooooo....."
"...oooooooo....."
"...oooooooo....."
"...oooooooo....o"
"ooo........ooooo"
"ooo........ooooo"
"oo..........oooo"
"o...........ooo."
"o............o.."
"................"
]]
iconWaveRed = dlg.createIcon( xpmWaveRed )


	xpmSample = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c green"
"g c black"
"o c blue"
". c None"
"oooooooooooooooo"
"oogoooooooooogoo"
"oogoooooooooogoo"
"..g..........g.."
"..g..........g.."
"..g..........g.."
"..g..........g.."
"..g..........g.."
"..gccccccccccg.."
"..gccccccccccg.."
"..gccccccccccg.."
"..gccccccccccg.."
"..gccccccccccg.."
"...gccccccccg..."
"....gggggggg...."
"................"
]]
iconSample = dlg.createIcon( xpmSample )

	xpmSpec = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c magenta"
"g c black"
"o c blue"
". c None"
"o..............."
"o..............."
"o..............."
"oo.............."
"oo.............."
"ooo............."
"oooo.......oo..."
"ooooo.....oooo.."
"oooooooooooooooo"
"oooooooo........"
"oooooo.........."
"oooo............"
"oo.............."
"o..............."
"o..............."
"o..............."
]]
iconSpec = dlg.createIcon( xpmSpec )

xpmCPD = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c green"
"g c grey"
"o c blue"
". c None"
"..gggg.........."
".g.....g........"
"gg.....gg......."
"gg.....gg......."
"gg.............."
"gg..cccggccc...."
"gg..cc.gg..cc..."
".g..cc.g...cc..."
"..gggg.oooooo..."
"....cc.oo..ccoo."
"....cc.oocc..oo."
"....cc.oo....oo."
"....cc.oo....oo."
".......oo....oo."
".......oo....o.."
".......oooooo..."
]]
iconCPD = dlg.createIcon( xpmCPD )

	xpmCPDRed = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"r c red"
"c c green"
"g c grey"
"o c blue"
". c None"
"..gggg.........."
".g.....g........"
"gg.....gg......."
"gg.....gg......."
"gg.............."
"gg..cccggccc...."
"gg..rrrrrrrcc..."
".g..rrrrrrrcc..."
"..ggrrrrrrroo..."
"....rrrrrrrccoo."
"....rrrrrrr..oo."
"....rrrrrrr..oo."
"....cc.oo....oo."
".......oo....oo."
".......oo....o.."
".......oooooo..."
]]
iconCPDRed = dlg.createIcon( xpmCPDRed )


xpmPP = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c #c0c000"
"g c black"
"o c blue"
". c None"
"................"
"oooooooooo......"
"oo........oo...."
"oo........oo...."
"oo........oo...."
"oo........oo...."
"oo..ggggggggg..."
"oo..gg....oo.g.."
"ooooggoooo...gg."
"oo..gg.......gg."
"oo..gg.......gg."
"oo..gg.......gg."
"oo..gggggggggg.."
"oo..gg.........."
"....gg.........."
"....gg.........."
]]

iconPP = dlg.createIcon( xpmPP )

	xpmPPRed = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c #c0c000"
"g c red"
"o c blue"
". c None"
"................"
"oooooooooo......"
"oo........oo...."
"oo........oo...."
"oo........oo...."
"oo........oo...."
"oo..ggggggggg..."
"oo..gg....oo.g.."
"ooooggoooo...gg."
"oo..gg.......gg."
"oo..gg.......gg."
"oo..gg.......gg."
"oo..gggggggggg.."
"oo..gg.........."
"....gg.........."
"....gg.........."
]]

iconPPRed = dlg.createIcon( xpmPPRed )


xpmBook = [[/* XPM */
"16 16 7 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c #c0c000"
"a c #ffffc0"
". c None"
"................"
".........#......"
"......#.#a##...."
".....#b#bbba##.."
"....#b#bbbabbb#."
"...#b#bba##bb#.."
"..#b#abb#bb##..."
".#a#aab#bbbab##."
"#a#aaa#bcbbbbbb#"
"#ccdc#bcbbcbbb#."
".##c#bcbbcabb#.."
"...#acbacbbbe..."
"..#aaaacaba#...."
"...##aaaaa#....."
".....##aa#......"
".......##......."
]]

iconBook = dlg.createIcon( xpmBook )

	xpmBookRed = [[/* XPM */
"16 16 8 1"
"# c #000000"
"b c #ffffff"
"e c #000000"
"d c #404000"
"c c #c0c000"
"a c #ffffc0"
"r c red"
". c None"
"................"
".........#......"
"......#.#a##...."
".....#b#bbba##.."
"....#b#bbbabbb#."
"...#b#bba##bb#.."
"..#b#abb#bb##..."
".#a#aab#brbbb##."
"#a#aaa#bcrrbbbb#"
"#ccdc#bcrrrrbb#."
".##c#bcrrrrbb#.."
"...#acrrrrbbe..."
"..#aaaarrba#...."
"...##aaaaa#....."
".....##aa#......"
".......##......."
]]

iconBookRed = dlg.createIcon( xpmBookRed )



object_attributes ={
["Current Settings"]={
["attr0"]="Type",
["attr1"]="Spectrometer",
["attr2"]="Sample",
["attr3"]="Macro",
["attr4"]="Output TopSpin macro",
["attr5"]="Current Directory",
["attr6"]="Browser",
["attr7"]="o1",
["attr8"]="pl1",
["attr9"]="p1",
["attr10"]="Help URL",
["attr11"]="SR",
["linked as"]="none",
["location"]="tmp",  -- location of the resource
["icon"]=iconBook,
["icon_alert"]=iconBookRed,
["attr99"]="Body"
},
["Macro"]={
["attr0"]="Type",
["attr1"]="Macro Name",
["attr2"]="Author(s)",
["attr3"]="Datum",
["attr4"]="Dimension",
["attr5"]="Group",
["attr6"]="Ref Sample",
["attr7"]="Type (CARA)",
["attr8"]="1D Spectrum",
["attr9"]="URL reference",
["linked as"]="macro",
["location"]="mac",  -- location of the resource
["icon"]=iconBook,
["icon_alert"]=iconBookRed,
["attr99"]="Body"
},
["Pulse Program"]={
["attr0"]="Type",
["attr1"]="PP Name",
["attr2"]="Author(s)",
["attr3"]="Datum",
["attr4"]="Dimension",
["attr5"]="Group",
["attr6"]="Subgroup",
["attr7"]="Memo",
["attr8"]="URL reference",
["location"]="pp",  -- location of the resource
["linked as"]="pulprog",
["icon"]=iconPP,
["icon_alert"]=iconPPRed,
["attr99"]="Body"
},
["Wave Form"]={
["attr0"]="Type",
["attr1"]="Wave Name",
["attr2"]="Author(s)",
["attr3"]="Group",
["attr4"]="Datum",
["attr5"]="Memo",
["attr6"]="URL reference",
["location"]="wave",  -- location of the resource
["linked as"]="spnam",
["icon"]=iconWave,
["icon_alert"]=iconWaveRed,
["attr99"]="Body"
},
["Composite Pulse Decoupling"]={
["attr0"]="Type",
["attr1"]="CPD Name",
["attr2"]="Author(s)",
["attr3"]="Group",
["attr4"]="Datum",
["attr5"]="Memo",
["attr6"]="URL reference",
["linked as"]="cpdprg",
["location"]="cpd",  -- location of the resource
["icon"]=iconCPD,
["icon_alert"]=iconCPDRed,
["attr99"]="Body"
},
["Script"]={
["attr0"]="Type",
["attr1"]="Script Name",
["attr2"]="Author(s)",
["attr3"]="Datum",
["attr4"]="b_max",
["attr5"]="b_max_relax",
["attr6"]="Rpp",
["linked as"]="script",
["location"]="script",  -- location of the resource
["icon"]=iconScript,
["icon_alert"]=iconScriptRed,
["attr7"]="Rcs_1",
["attr8"]="Rcs_2",
["attr99"]="Body"
},
["Sample"]={
["attr0"]="Type",
["attr1"]="Sample Name",
["attr2"]="Author(s)",
["attr3"]="Datum",
["attr4"]="Labeling",
["attr5"]="Tau_C (ns)",
["attr6"]="Group",
["attr7"]="1D Spectrum",
["attr8"]="URL reference",
["linked as"]="sample",
["location"]="sample",  -- location of the resource
["icon"]=iconSample,
["icon_alert"]=iconSample,
["attr99"]="Body" -- sample specific NMR settings
},
["Spectrometer"]={
["attr0"]="Type",
["attr1"]="Spec Name",
["attr2"]="Location",
["attr3"]="Contact Person",
["attr4"]="Datum",
["attr5"]="Spec Type",
["attr6"]="Memo",
["attr7"]="URL reference",
["linked as"]="spectrometer",
["location"]="spectrometer",  -- location of the resource
["icon"]=iconSpec,
["icon_alert"]=iconSpec,
["attr99"]="Body" -- Spectrometer's settings
}
}

--USAGE
--print(object_attributes["Spectrometer"].attr1)

--for key, value in pairs( object_attributes ) do
--print(key)
--for key1, value1 in pairs( value ) do
--print(key1.." = "..value1)
--end

--end

--for key, value in pairs( object_attributes["Spectrometer"] ) do
--print(key.." = "..value)
--end

list_of_components_of_experiment ={
[4]="Script",
[2]="Composite Pulse Decoupling",
[3]="Wave Form",
[1]="Pulse Program"
}




-- Functions SECTION
main_display_window_scrollview={}
main_window_main_frame_scrollview={}
central_display_widget_scrollview={}
main_window_menu_bar_scrollview={}
main_file_menu_button_scrollview={}
main_window_file_menu_scrollview={}
filter_q={}
main_file_menu_button_cm={}
main_file_menu_button_1d={}
InternetBrowser ="start iexplore.exe"
now="selected" -- to define spectrometer[now]

--these are defined globally to avoid garbage collection induced crash

function ContentEditor(record_type)

local project_name=cara:getProject("NMRgenerator"):getName()




 local entry_szx=150
 local entry_szy=20
 local bar_w= 40
 local push_button_w= 100
 local main_szx=1100 --the rest defined dynamically
 local main_szy=800
 local max_w=0
 local max_h=0
 
local steps_to_tail=20
number_of_opened_ContentManagers=number_of_opened_ContentManagers+1



 main_display_window_scrollview[number_of_opened_ContentManagers]=gui.createWidget();    --this is the highest level window
	--main_display_window_scrollview[number_of_opened_ContentManagers]:showFullScreen();
	--max_w,max_h=main_display_window_scrollview[number_of_opened_ContentManagers]:getSize();
	--main_szx=max_w-20.;
	--main_szy=max_h-80.;
	
	main_display_window_scrollview[number_of_opened_ContentManagers]:showNormal();
	main_display_window_scrollview[number_of_opened_ContentManagers]:setBgColor("light grey");
	main_display_window_scrollview[number_of_opened_ContentManagers]:setCaption("Content manager:    "..record_type.."          ");
	main_display_window_scrollview[number_of_opened_ContentManagers]:resize(main_szx,main_szy);
	


main_display_window_scrollview[number_of_opened_ContentManagers]:move(20+number_of_opened_ContentManagers*steps_to_tail,180+number_of_opened_ContentManagers*steps_to_tail);

main_display_window_scrollview[number_of_opened_ContentManagers]:getData().m_szx=main_szx;
	main_display_window_scrollview[number_of_opened_ContentManagers]:getData().m_szy=main_szy;
	
	main_display_window_scrollview[number_of_opened_ContentManagers]:setCallback(gui.event.Closing,
		function(self)
			--number_of_opened_ContentManagers=number_of_opened_ContentManagers-1

			print("Closing Manager");
					end);
	main_display_window_scrollview[number_of_opened_ContentManagers]:setCallback(gui.event.Resized,
		function(self,w,h,old_w,old_h)
			--print("resized from: "..old_w.."  "..old_h.." to: "..w.." "..h);
			self:getData().m_szx,self:getData().m_szy=w,h;
			self:getData().frame:resize(w,h);
			self:getData().scroll:resize(w-2,h-25);
			self:getData().scroll:show();

		end);
		
 main_window_main_frame_scrollview[number_of_opened_ContentManagers]=gui.createFrame(main_display_window_scrollview[number_of_opened_ContentManagers]);
main_display_window_scrollview[number_of_opened_ContentManagers]:getData().frame=main_window_main_frame_scrollview[number_of_opened_ContentManagers];

	
 central_display_widget_scrollview[number_of_opened_ContentManagers]=gui.createWidget(main_window_main_frame_scrollview[number_of_opened_ContentManagers]);
	main_window_main_frame_scrollview[number_of_opened_ContentManagers]:resize(main_szx,main_szy);
	main_window_main_frame_scrollview[number_of_opened_ContentManagers]:show();

 main_window_menu_bar_scrollview[number_of_opened_ContentManagers]=gui.createWidget(main_display_window_scrollview[number_of_opened_ContentManagers]);
	main_window_menu_bar_scrollview[number_of_opened_ContentManagers]:move(0,0);
    main_window_menu_bar_scrollview[number_of_opened_ContentManagers]:resize(push_button_w*5,bar_w);
	main_window_menu_bar_scrollview[number_of_opened_ContentManagers]:setBgColor("grey");
	main_window_menu_bar_scrollview[number_of_opened_ContentManagers]:show();



--BUTTON show all
	main_file_menu_button_cm[number_of_opened_ContentManagers]=gui.createPushButton(main_window_menu_bar_scrollview[number_of_opened_ContentManagers]);
	main_file_menu_button_cm[number_of_opened_ContentManagers]:resize(push_button_w,bar_w-4);
	main_file_menu_button_cm[number_of_opened_ContentManagers]:move(push_button_w+298,2);
	main_file_menu_button_cm[number_of_opened_ContentManagers]:setBgColor("magenta");
	main_file_menu_button_cm[number_of_opened_ContentManagers]:setText("Show all");
	main_file_menu_button_cm[number_of_opened_ContentManagers]:show();
	main_file_menu_button_cm[number_of_opened_ContentManagers]:setCallback(gui.event.Clicked,
		function(self)
			local x,y
			if(self:getData().fltrq:getData().scroll) then 
			x,y= self:getData().fltrq:getData().scroll:getSize(); 
			self:getData().fltrq:getData().scroll:destroy(); end
			

			self:getData().fltrq:getData().scroll,self:getData().fltrq:getData().items,self:getData().fltrq:getData().subitems,self:getData().fltrq:getData().subitems_OID,self:getData().fltrq:getData().subitems_name,self:getData().fltrq:getData().subitems_type=create_scrollview(self:getData().fltrq:getData().mwmf,self:getData().fltrq:getData().cp, self:getData().fltrq:getData().ct,"")
			self:getData().fltrq:getData().scroll:resize(x,y);
			self:getData().fltrq:getData().mdw:getData().scroll=self:getData().fltrq:getData().scroll

					end);
--END BUTTON SHOW ALL

--BUTTON Overlay 1D
	main_file_menu_button_1d[number_of_opened_ContentManagers]=gui.createPushButton(main_window_menu_bar_scrollview[number_of_opened_ContentManagers]);
	main_file_menu_button_1d[number_of_opened_ContentManagers]:resize(push_button_w,bar_w-4);
	main_file_menu_button_1d[number_of_opened_ContentManagers]:move(push_button_w*0+298-4,2);
	main_file_menu_button_1d[number_of_opened_ContentManagers]:setBgColor("yellow");
	main_file_menu_button_1d[number_of_opened_ContentManagers]:setText("Overlay 1D");
	main_file_menu_button_1d[number_of_opened_ContentManagers]:show();
	main_file_menu_button_1d[number_of_opened_ContentManagers]:setCallback(gui.event.Clicked,
		function(self)
local items_2_draw={}

for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
	if(value:isSelected()) then
	--print("Item OID to draw: "..key) --this returns record's OID
	items_2_draw[key]=key
	--get associated Ref Sample attr1, which is sample name
	local sampleName=cara:getRecord(key):getAttr("Ref Sample"); --
		if(sampleName) then
		print("Ref Sample name: "..sampleName)
		local oid_sample= retriveOID_by_type_name("Sample", sampleName) --
			if(oid_sample) then
				items_2_draw[oid_sample]=oid_sample
			end--if(oid_sample)
		end--if(sampleName) th
	
	end --if(value:isSelected())
end --for key,value in pa
Multiple1Doverlay(items_2_draw)
					end);
--END BUTTON Show 1D



	main_file_menu_button_scrollview[number_of_opened_ContentManagers]=gui.createPushButton(main_window_menu_bar_scrollview[number_of_opened_ContentManagers]);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:resize(push_button_w,bar_w-4);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:move(2,2);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:setBgColor("magenta");
--	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:setFlat(true);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:setText("File");
--	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:setFont(base_font,base_font_size,0,0);
	main_window_file_menu_scrollview[number_of_opened_ContentManagers]=gui.createPopupMenu(main_display_window_scrollview[number_of_opened_ContentManagers]);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:setPopup(main_window_file_menu_scrollview[number_of_opened_ContentManagers]);
	main_file_menu_button_scrollview[number_of_opened_ContentManagers]:show();

	main_window_file_menu_scrollview[number_of_opened_ContentManagers]:setCallback(gui.event.Showing,
		function(self,menu_id)
			self:clear();
				local nmrdir=get_nmr_directory()
				self:insertItem("Show all",1,1);
				self:setWhatsThis(1,"Update shown list of items after the Repository is modified");
				self:insertItem("Select all",2,2);
				self:insertItem("Unselect all",3,3);
					self:insertSeparator();
				self:insertItem("Import selected components from: "..nmrdir,5,5);
				self:insertItem("Export selected components to: "..nmrdir,6,6);
					self:insertSeparator();
				self:insertItem("Import selected components from XML",8,8);
				self:insertItem("Export selected components to XML",9,9);
					self:insertSeparator();
				self:insertItem("Create PP, WAVE,CPD, MAC, SCRIPT, directories",11,11);
					self:insertSeparator();
				self:insertItem("Info",100,100);
				self:setWhatsThis(100,"URL to Wiki-like information server at www.trosy.com");
		end);
	
	
	main_window_file_menu_scrollview[number_of_opened_ContentManagers]:setCallback(gui.event.Activated,
		function(self,menu_id)
			if(menu_id==100)then
				print("So far none")
			end --if(menu_id==100
			
			if(menu_id==1)then
				local x,y
			if(self:getData().fltrq:getData().scroll) then 
			x,y= self:getData().fltrq:getData().scroll:getSize(); 
			self:getData().fltrq:getData().scroll:destroy(); end
			

self:getData().fltrq:getData().scroll,self:getData().fltrq:getData().items,self:getData().fltrq:getData().subitems,self:getData().fltrq:getData().subitems_OID,self:getData().fltrq:getData().subitems_name,self:getData().fltrq:getData().subitems_type=create_scrollview(self:getData().fltrq:getData().mwmf,self:getData().fltrq:getData().cp, self:getData().fltrq:getData().ct,"")
			self:getData().fltrq:getData().scroll:resize(x,y);
			self:getData().fltrq:getData().mdw:getData().scroll=self:getData().fltrq:getData().scroll
			end --if(menu_id==1

			if(menu_id==2)then self:getData().fltrq:getData().scroll:selectAll(true) end
			if(menu_id==3)then self:getData().fltrq:getData().scroll:selectAll(false) end
  
--//////////////5
			if(menu_id==5)then --import
--ITEMS
local items_4_import={}
local subitems_4_import_OID={}  --present in reposit
local subitems_4_import_name={} --absent in reposit
local subitems_4_import_type={} --absent in reposit

for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
	if(value:isSelected()) then
	--print("Item OID to export: "..key) --this returns record's OID
	items_4_import[key]=key
	end --if(value:isSelected())
end --for key,value in pa

--SUBITEMS
for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
		for m = 0, 1000 do
			if(self:getData().fltrq:getData().subitems[m+key*1000]) then 
			if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected()) then 
				if(self:getData().fltrq:getData().subitems_OID[m+key*1000]) then 
				subitems_4_import_OID[m+key*1000]=self:getData().fltrq:getData().subitems_OID[m+key*1000]
				else
--print("name1 "..self:getData().fltrq:getData().subitems_name[m+key*1000])				
--print("type2 "..self:getData().fltrq:getData().subitems_type[m+key*1000])				

subitems_4_import_name[self:getData().fltrq:getData().subitems_name[m+key*1000]]=self:getData().fltrq:getData().subitems_name[m+key*1000]
subitems_4_import_type[self:getData().fltrq:getData().subitems_name[m+key*1000]]=self:getData().fltrq:getData().subitems_type[m+key*1000]

--print(" SubItem name to import: "..subitems_4_import_name[self:getData().fltrq:getData().subitems_name[m+key*1000]]) 
--print(" SubItem type to import: "..subitems_4_import_type[self:getData().fltrq:getData().subitems_name[m+key*1000]]) --this returns record's OID


				end --if(self:getData().fltrq:getData().subitems_OID[m+key*1000]) then
			end --if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected)
			end --if(self:getData().fltrq:getData().subitems_OID[m
		end --for m = 0, 1000 do
end --for key,value in pairs(self:getD

for key,value in pairs(items_4_import) do
print("Item OID to import: "..key) --this returns record's OID
ImportEntry(key)
end

for key,value in pairs(subitems_4_import_OID) do
--print(key.." SubItem OID to import: "..subitems_4_import_OID[key]) --this returns record's OID
ImportEntry(subitems_4_import_OID[key])
end

for key,value in pairs(subitems_4_import_name) do
print("SubItem name to import: "..subitems_4_import_name[key]) 
print("SubItem type to import: "..subitems_4_import_type[key]) --this returns record's OID
CreateImportEntry(subitems_4_import_name[key],subitems_4_import_type[key])
end


answ=dlg.getSymbol("Results","Content imported","continue");
			end --if(menu_id==5

--
			if(menu_id==6)then --export
--ITEMS
local items_4_export={}
local subitems_4_export={}

for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
	if(value:isSelected()) then
	--print("Item OID to export: "..key) --this returns record's OID
	items_4_export[key]=key
	end --if(value:isSelected())
end --for key,value in pa

--SUBITEMS
for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
		for m = 0, 1000 do
			if(self:getData().fltrq:getData().subitems[m+key*1000]) then 
			if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected()) then 
			if(self:getData().fltrq:getData().subitems_OID[m+key*1000]) then 
			--print("Subitem OID to export: "..self:getData().fltrq:getData().subitems_OID[m+key*1000])
			

subitems_4_export[self:getData().fltrq:getData().subitems_OID[m+key*1000]]=self:getData().fltrq:getData().subitems_OID[m+key*1000]
			end --if(self:getData().fltrq:getData().subitems[
			end --if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected)
			end --if(self:getData().fltrq:getData().subitems_OID[m
		end --for m = 0, 1000 do
end --for key,value in pairs(self:getD

for key,value in pairs(items_4_export) do
--print("Item OID to export: "..key) --this returns record's OID
ExportEntry(key)
end
for key,value in pairs(subitems_4_export) do
--print("SubItem OID to export: "..key) --this returns record's OID
ExportEntry(key)
end
answ=dlg.getSymbol("Results","Content exported","continue");
			end --if(menu_id==6
--IIIIIIIIIIIIIIIIIIIIIIIIII
			if(menu_id==8)then --import DomDocument
--ITEMS

			--dlg.setCurrentDir(get_nmr_directory()) 
			local FileIn = dlg.getOpenFileName( "Open XML file", "*.xml" )
			local accumulator=""
			for line in io.lines(FileIn) do
				if(line) then accumulator=accumulator..line.."\n" end
			end
add_string_to_body_of_currentsettings(accumulator)
--parseRecordsFromPHPBB3(accumulator)
--add_string_to_body_of_currentsettings("Paste PHPBB3 formatted text here and\ncreate records from File menu\n")
show_currentsettings() 
			end --if(menu_id==8

--IIIIIIIIIIIIIIIIIIIIII


--EEEEEEEEEEEEEEEEEEEEEE
			if(menu_id==9)then --export DomDocument
--ITEMS

local items_4_export={}
local subitems_4_export={}
local items4Dom={}

for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
	if(value:isSelected()) then
	--print("Item OID for DomDocument: "..key) --this returns record's OID
	items_4_export[key]=key
	end --if(value:isSelected())
end --for key,value in pa

--SUBITEMS
for key,value in pairs(self:getData().fltrq:getData().items) do --loop over all items
		for m = 0, 1000 do
			if(self:getData().fltrq:getData().subitems[m+key*1000]) then 
			if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected()) then 
			if(self:getData().fltrq:getData().subitems_OID[m+key*1000]) then 
			--print("Subitem OID for DomDocument: "..self:getData().fltrq:getData().subitems_OID[m+key*1000])
	subitems_4_export[self:getData().fltrq:getData().subitems_OID[m+key*1000]]=self:getData().fltrq:getData().subitems_OID[m+key*1000]
			end --if(self:getData().fltrq:getData().subitems[
			end --if(self:getData().fltrq:getData().subitems[m+key*1000]:isSelected)
			end --if(self:getData().fltrq:getData().subitems_OID[m
		end --for m = 0, 1000 do
end --for key,value in pairs(self:getD

for key,value in pairs(items_4_export) do
items4Dom[key]=key
end
for key,value in pairs(subitems_4_export) do
items4Dom[key]=key
end
--local dom=CreateDomXML(items4Dom) -- Use saveToFile to output
local domacc=CreatePHPBB3text(items4Dom) -- Use add_string_to_body_of_currentsettings(domacc)

if(dom) then
	local FileOut = dlg.getSaveFileName( "Select DomXML file", "*.xml" )
	if(FileOut) then
	dom:saveToFile(FileOut)
	answ=dlg.getSymbol("DomDocument:","XML saved","open XML in browser","continue");
		if(answ=="open XML in browser") then
		open_in_browser("file:///"..FileOut) --filetype="file:///"
		end
	end--if(FileOut)
	

end --if(dom) 

if(domacc) then
	local FileOut = dlg.getSaveFileName( "Output XML file", "*.xml" )
	if(FileOut) then
			local	outfile = io.output( FileOut)
			outfile:write(domacc) 
			outfile:close()
			print("Exported as XML file: "..FileOut)				 	
	answ=dlg.getSymbol("DomDocument:","XML saved","open XML in browser","continue");
		if(answ=="open XML in browser") then
		open_in_browser("file:///"..FileOut) 
		end
	end--if(FileOut)

--add_string_to_body_of_currentsettings(domacc)
--show_currentsettings() 

end --if(domacc)

			end --if(menu_id==6

--EEEEEEEEEEEEEEEEEEEEEE



 			if(menu_id==11)then
                --nmrgen_current_directory=dlg.getCurrentDir()
				local tmpp=get_nmr_directory()
				--local nmrgen_current_directory
				--answ=dlg.getSymbol("Where to create directory structure?","Select location:",tmpp,spectrometer[now].home_topspin)
				--if(answ) then nmrgen_current_directory=answ end
				local commnd="mkdir ".."\""..tmpp.."/pp".."\""
				local ret=os.execute(commnd)
				--print(commnd.." sent with the return code: "..ret)
				print(commnd)
				
				commnd="mkdir ".."\""..tmpp.."/mac".."\""; os.execute(commnd); print(commnd);
				commnd="mkdir ".."\""..tmpp.."/cpd".."\""; os.execute(commnd); print(commnd);
				commnd="mkdir ".."\""..tmpp.."/wave".."\""; os.execute(commnd); print(commnd);
				commnd="mkdir ".."\""..tmpp.."/script".."\""; os.execute(commnd); print(commnd);
			end    --if(menu_id==6
		end);  --main window



local curr_project=project_name 
local curr_type=record_type 
--local curr_type="Pulse Program"

--create_current_status_infolines(curr_project)  
local nmr_repository_scrollview1,itemlist,subitemlist,subitemlist_OID,subitemlist_name,subitemlist_type=create_scrollview(main_window_main_frame_scrollview[number_of_opened_ContentManagers], curr_project, curr_type,"")
local x,y=main_display_window_scrollview[number_of_opened_ContentManagers]:getSize();
--print("frame: x,y: "..x.." and "..y)
--nmr_repository_scrollview1:resize(x-2,y-70);
nmr_repository_scrollview1:resize(x-2,y-25);
nmr_repository_scrollview1:show();


-- x,y=nmr_repository_scrollview1:getSize();
--print("scroll: x,y: "..x.." and "..y)
main_display_window_scrollview[number_of_opened_ContentManagers]:getData().scroll=nmr_repository_scrollview1;

--local x,y= nmr_repository_scrollview1:getSize()
--print("size: "..x.." and "..y)





-- FILTER Controls
filter_q[number_of_opened_ContentManagers]=create_filter_controls(main_window_main_frame_scrollview[number_of_opened_ContentManagers]);
filter_q[number_of_opened_ContentManagers]:getData().scroll=nmr_repository_scrollview1;
filter_q[number_of_opened_ContentManagers]:getData().mdw=main_display_window_scrollview[number_of_opened_ContentManagers];
filter_q[number_of_opened_ContentManagers]:getData().mwmf=main_window_main_frame_scrollview[number_of_opened_ContentManagers];
filter_q[number_of_opened_ContentManagers]:getData().items=itemlist;
filter_q[number_of_opened_ContentManagers]:getData().subitems=subitemlist;
filter_q[number_of_opened_ContentManagers]:getData().subitems_OID=subitemlist_OID;
filter_q[number_of_opened_ContentManagers]:getData().subitems_name=subitemlist_name;
filter_q[number_of_opened_ContentManagers]:getData().subitems_type=subitemlist_type;
filter_q[number_of_opened_ContentManagers]:getData().cp=curr_project;
filter_q[number_of_opened_ContentManagers]:getData().ct=curr_type;
main_window_file_menu_scrollview[number_of_opened_ContentManagers]:getData().fltrq=filter_q[number_of_opened_ContentManagers];
main_file_menu_button_cm[number_of_opened_ContentManagers]:getData().fltrq=filter_q[number_of_opened_ContentManagers];
main_file_menu_button_1d[number_of_opened_ContentManagers]:getData().fltrq=filter_q[number_of_opened_ContentManagers];
--main_file_menu_button_scrollview[number_of_opened_ContentManagers]Calc:getData().fltrq=filter_q[number_of_opened_ContentManagers];

	filter_q[number_of_opened_ContentManagers]:setCallback(gui.event.Activated,
		function(self,menu_id)
		local x,y
			print("Activated: "..filter_q[number_of_opened_ContentManagers]:getCurrentText()); --here when enter or selector
			if(self:getData().scroll) then x,y= self:getData().scroll:getSize(); self:getData().scroll:destroy(); end
			

self:getData().scroll,self:getData().items,self:getData().subitems,self:getData().subitems_OID=create_scrollview(self:getData().mwmf,self:getData().cp, self:getData().ct,self:getCurrentText())
			self:getData().scroll:resize(x,y);
			self:getData().mdw:getData().scroll=self:getData().scroll
			end);

	filter_q[number_of_opened_ContentManagers]:setCallback(gui.event.Changed,
		function(self,menu_id)
			print("Changed: "..filter_q[number_of_opened_ContentManagers]:getCurrentText()); --here when typed
		end);


-- END filter 

end --function ContentEditor(record_type)

-- ####################### SCROLL VIEW FUNCTION
function create_scrollview(main_window_main_frame_screatescroll, curr_project, curr_type, filter_pattern)
local columns={};
--print("received filter: "..filter_pattern)
--local curr_type="Script"
--local curr_type="Wave Form"
--local curr_type="Sample"
--local curr_type="Composite Pulse Decoupling"
--local curr_type="Pulse Program"
--local curr_type="Macro"
--local curr_type="Spectrometer"
--local curr_project="Test"

local numb_of_attr=20
local attributes=object_attributes[curr_type]

--print("size: "..main_szx.." and "..main_szy)
local	nmr_repository_scrollview_screatescroll=gui.createListView(main_window_main_frame_screatescroll);
  --nmr_repository_scrollview_screatescroll:resize(main_szx,main_szy);
	nmr_repository_scrollview_screatescroll:move(2,45);

-- BUILD Column titles		
	for i = 1, 20 do
	if(object_attributes[curr_type]["attr"..i]) then 

	columns[i]=nmr_repository_scrollview_screatescroll:addColumn(object_attributes[curr_type]["attr"..i]);

	end
	end
	
	nmr_repository_scrollview_screatescroll:setBgColor("magenta");    --yellow
	nmr_repository_scrollview_screatescroll:setRootDecorated(true); 
	nmr_repository_scrollview_screatescroll:setSortIndicated(true);
	nmr_repository_scrollview_screatescroll:setMultiSelection(true);
	nmr_repository_scrollview_screatescroll:setAllColsMarked(true);
	nmr_repository_scrollview_screatescroll:sort();
	nmr_repository_scrollview_screatescroll:show();

local itemlist={}
local subitemlist ={}
local subitemlist_OID ={} -- to store record OID for subitems (not all of them have OID)
local subitemlist_name ={} -- to store record name for subitems ( all of them have name)
local subitemlist_type ={} -- to store record name for subitems ( all of them have name)
local set_is_complete="NO"


local p = cara:getProject( "NMRgenerator" )
local r = p:getAttr(curr_type)
local values_screatescroll_before_filter = r:getAttrs()


-- FILTER
local values_screatescroll={}
for key,value in pairs(values_screatescroll_before_filter) do --loop over all macroses
	for i = 1, 20 do --loop over attributes 
		if(object_attributes[curr_type]["attr"..i]) then
		if(value:getAttr(object_attributes[curr_type]["attr"..i])) then
			for k in string.gfind(value:getAttr(object_attributes[curr_type]["attr"..i]), filter_pattern) do
			values_screatescroll[key]=values_screatescroll_before_filter[key]
			end
		end
		end
	end
end
-- END FILTER


for key,value in pairs(values_screatescroll) do --loop over all macroses
--print(key) --key is a number of record, therefore the record is accessible by this number

itemlist[key]=nmr_repository_scrollview_screatescroll:createItem();
itemlist[key]:setIcon(columns[1],object_attributes[curr_type]["icon"]);

local bodytext=value:getAttr(object_attributes[curr_type]["attr99"])


for i = 1, 20 do --loop over attributes 
if(object_attributes[curr_type]["attr"..i]) then

--print(object_attributes[curr_type]["attr"..i])	
--print(value:getAttr(object_attributes[curr_type]["attr"..i]))
if(value:getAttr(object_attributes[curr_type]["attr"..i])) then
itemlist[key]:setText(columns[i],value:getAttr(object_attributes[curr_type]["attr"..i]));
else
itemlist[key]:setText(columns[i],"---");
end

end --if(object_attributes[c
end --for i
if(curr_type=="Macro") then 
--if(curr_type==curr_type) then 
--Execute macro (or anything else) to get dependencies and build subitems
--print(value:getAttr(object_attributes[curr_type]["attr99"]))
				--local chunk,errmsg=loadstring (bodytext);
				--print(bodytext)
				--if(chunk) then
				--print("Record: "..key.." loaded for execution")
				--assert(loadstring(bodytext))()
				--assert(loadstring (bodytext))
				--print("Executed")
				--else
				--print("Error in compilation: "..errmsg)
				--answ=dlg.getSymbol("Error: "..value:getAttr(object_attributes[curr_type]["attr1"]),errmsg,"continue")
				--end
				
				--exp_environment={
				--["pulprog"]="aaaa",
				--["spnam1"]="bbbb"
				--}
				--print("Value on pattern = "..find_pattern(bodytext, "pulprog"))
				--find_pattern(bodytext, "pulprog")
-- Loop over defined components
local comp_indx=1
		for k = 1, 4 do
			values_screatescroll11 = cara:getProject("NMRgenerator"):getAttr(list_of_components_of_experiment[k]):getAttrs()
						--for key11,value11 in pairs(values_screatescroll11) do --loop over all CPDs
						--print("What we have: "..value11:getAttr(object_attributes["Composite Pulse Decoupling"]["attr1"]))
						--end

				--build subitems detected in body
				local name_found=find_pattern(bodytext,object_attributes[list_of_components_of_experiment[k]]["linked as"])
					if(name_found) then 
					subitemlist[comp_indx+key*1000]=itemlist[key]:createItem();
					subitemlist[comp_indx+key*1000]:setText(columns[1],name_found);
					subitemlist_name[comp_indx+key*1000]=name_found;
					subitemlist_type[comp_indx+key*1000]=list_of_components_of_experiment[k];
					subitemlist[comp_indx+key*1000]:setIcon(columns[1],object_attributes[list_of_components_of_experiment[k]]["icon_alert"]);
				--find subitems which are in repository and are Pulprogs 
						for key11,value11 in pairs(values_screatescroll11) do --loop over pulprog stored components
							if(name_found==value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr1"])) then set_is_complete="YES"
							subitemlist[comp_indx+key*1000]:setIcon(columns[1],object_attributes[list_of_components_of_experiment[k]]["icon"]);
								if(value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr2"])) then 
								subitemlist[comp_indx+key*1000]:setText(columns[2],value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr2"]));
								end
								if(value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr3"])) then 
								subitemlist[comp_indx+key*1000]:setText(columns[3],value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr3"]));
								end
							subitemlist_OID[comp_indx+key*1000]=key11; 
							end --if(value11
						end --for key11,value11
						comp_indx=comp_indx+1;  --finished with subitem pulprog
					end --if(name_found)
				--build subitems which are in repository and not Pulprogs (so that index i should be added)
				for i = 1, 32 do --loop over CPDs (in Bruker there are only 32 cpds)
					name_found=find_pattern(bodytext,object_attributes[list_of_components_of_experiment[k]]["linked as"]..i)
					if(name_found) then 
					subitemlist[comp_indx+key*1000]=itemlist[key]:createItem();
					subitemlist[comp_indx+key*1000]:setText(columns[1],name_found);
					subitemlist_name[comp_indx+key*1000]=name_found;
					subitemlist_type[comp_indx+key*1000]=list_of_components_of_experiment[k];
					subitemlist[comp_indx+key*1000]:setIcon(columns[1],object_attributes[list_of_components_of_experiment[k]]["icon_alert"]);
						for key11,value11 in pairs(values_screatescroll11) do --loop over not pulprog stored components
							if(name_found==value11:getAttr(object_attributes[list_of_components_of_experiment[k]]["attr1"])) then set_is_complete="YES"
							--print("Key11: "..key11) -- key11 is the number of record 
							subitemlist_OID[comp_indx+key*1000]=key11; 
							subitemlist[comp_indx+key*1000]:setIcon(columns[1],object_attributes[list_of_components_of_experiment[k]]["icon"]);
							end --if(value11
						end --for key11,value11
						comp_indx=comp_indx+1;  --finished with subitems not pulprog
					end --if(name_found)
				end --for i = 1, 32

--set red icon
for m = 0, 1000 do
	if(subitemlist_name[m+key*1000]) then 
		if(subitemlist_OID[m+key*1000]==nil) then 
			itemlist[key]:setIcon(columns[1],object_attributes[curr_type]["icon_alert"]);
		end --if(subitemlist_OID[m+key*1000])
	end --if(subitemlist_name[m+key*1000])
end --for m = 0, 1000 do
--END set red icon

-- Loop over defined components END
		end--for k = 1, 4 do

end --if(curr_type=="Macro") then 

end --key,value in pairs(values_screatescroll) do  --loop of all macroses

--for key21,value21 in pairs(subitemlist_OID) do
--print("Keys of subitems:" ..key21)  --keys to sunitem list, with existing componenets in repository
--print(" subOIDs: "..subitemlist_OID[key21]) --OID of records
--end

nmr_repository_scrollview_screatescroll:getData().cp=curr_project
nmr_repository_scrollview_screatescroll:getData().ct=curr_type
nmr_repository_scrollview_screatescroll:getData().item=itemlist
nmr_repository_scrollview_screatescroll:getData().subitem=subitemlist
nmr_repository_scrollview_screatescroll:getData().subitem_OID=subitemlist_OID
nmr_repository_scrollview_screatescroll:getData().subitem_name=subitemlist_name
nmr_repository_scrollview_screatescroll:getData().subitem_type=subitemlist_type
nmr_repository_scrollview_screatescroll:getData().main_w_main_f=main_window_main_frame_screatescroll


nmr_repository_scrollview_screatescroll:setCallback(gui.event.DblClicked,
		function(self,item_id,x1,y1,clmn)
			print("Double Click detected: open entry\n")
					local selected_OID=nil;
			if(item_id) then
			self:clearSelection();
			item_id:setSelected();
			end
			-- for selected items
			local p = cara:getProject(self:getData().cp)
			local r = p:getAttr(self:getData().ct)
			values_screatescroll = r:getAttrs()
			for key,value in pairs(values_screatescroll) do --loop over all Items 
			if(self:getData().item[key]) then
				if(self:getData().item[key]:isSelected()) then
				selected_OID=key;
				end --if(self:getData().item[key]:is
			end --if(self:getDat
			end --for key, value
			
			-- for selected subitems
			for key21,value21 in pairs(self:getData().subitem_OID) do
			if(self:getData().subitem[key21]) then
				if(self:getData().subitem[key21]:isSelected()) then
				selected_OID=self:getData().subitem_OID[key21];
				end --if(self:getData().item[key]:is
			end --if(self:getDat

			end --if(item_id)
							if(selected_OID) then
							local curr_record=cara:getRecord(selected_OID)
							if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency(1) in dataset","No record with OID "..selected_OID,"continue","get all record OID")
							return
							end

							local curr_type=curr_record:getAttr("Type")
							if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency(1) in dataset","Attribute 'Type' is not setup in record "..selected_OID,"continue");
							return
							end
							local bodytxt=curr_record:getAttr(object_attributes[curr_type]["attr1"])
							
					values33 = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key33,value33 in pairs(values33) do 
					value33:setAttr(curr_type,bodytxt)
					end
					create_current_status_infolines(main_window_main_frame_startpage);
					AttributeEditor(selected_OID)
							end --if(selected_OID)
		end); --function(self,item_id,x1,y1,clmn)


nmr_repository_scrollview_screatescroll:setCallback(gui.event.RightPressed,
		function(self,item_id,x1,y1,clmn)
		local selected_OID=nil;
			print("Right Pressed detected: column: "..clmn)
			if(item_id) then
			self:clearSelection();
			item_id:setSelected();
			end
			-- for selected items
			local p = cara:getProject(self:getData().cp)
			local r = p:getAttr(self:getData().ct)
			values_screatescroll = r:getAttrs()
			for key,value in pairs(values_screatescroll) do --loop over all Items 
			if(self:getData().item[key]) then
				if(self:getData().item[key]:isSelected()) then
				selected_OID=key;
				end --if(self:getData().item[key]:is
			end --if(self:getDat
			end --for key, value
			
			-- for selected subitems
			for key21,value21 in pairs(self:getData().subitem_OID) do
--print("Keys of subitems:" ..key21)  --keys to sunitem list, with existing componenets in repository
--print(" subOIDs: "..subitemlist_OID[key21]) --OID of records
			if(self:getData().subitem[key21]) then
				if(self:getData().subitem[key21]:isSelected()) then
				selected_OID=self:getData().subitem_OID[key21];
				end --if(self:getData().item[key]:is
			end --if(self:getDat

			end

			
				if(selected_OID) then
				print("Run popUp menue for record: "..selected_OID)
--					local scrollview_popup_menu=gui.createPopupMenu(main_display_window ); --mdw works as well
					local scrollview_popup_menu=gui.createPopupMenu(self:getData().main_w_main_f);
						scrollview_popup_menu:insertItem("Open ",1,1);
						scrollview_popup_menu:setWhatsThis(1,"Openining of the entry in Attribute Editor");
						scrollview_popup_menu:insertItem("Duplicate ",2,2);
						scrollview_popup_menu:insertItem("Delete ",3,3);
						--scrollview_popup_menu:setAccel(7,"Ctrl+O");
						scrollview_popup_menu:insertSeparator();
						scrollview_popup_menu:insertItem("Import from file",5,5);
						scrollview_popup_menu:insertItem("Export as file",6,6);
						scrollview_popup_menu:insertSeparator();
						scrollview_popup_menu:insertItem("Associate 1D spectrum",7,7);
						scrollview_popup_menu:insertItem("Show and Text 1D",8,8);
						scrollview_popup_menu:insertItem("Associate sample",9,9);
						scrollview_popup_menu:popup(x1,y1);
						--AttributeEditor(key)
						
							scrollview_popup_menu:setCallback(gui.event.Activated,
							function(self,menu_id)
								if(menu_id==1)then
								AttributeEditor(selected_OID)				 
								end    --if(menu_id==1
								
								if(menu_id==2)then
								DuplicateEntry(selected_OID)				 
								end    --if(menu_id==2
								
								if(menu_id==3)then
								RemoveEntry(selected_OID)				 
								end    --if(menu_id==3
								
								if(menu_id==5)then
									--if(nmrgen_current_directory) then dlg.setCurrentDir(nmrgen_current_directory) end
									local FileIn = dlg.getOpenFileName( "Select file", "*.*" )
									local accumulator=""
										for line in io.lines(FileIn) do
										if(line) then accumulator=accumulator..line.."\n" end
										end
									cara:getRecord(selected_OID):setAttr("Body",accumulator);
									answ=dlg.getSymbol("Imported file: ",FileIn,"continue")				 

								--local body=cara:getRecord(selected_OID):getAttr("Body")				 
								end    --if(menu_id==5
								
								if(menu_id==6)then
									--if(nmrgen_current_directory) then dlg.setCurrentDir(nmrgen_current_directory) end
									local FileOut = dlg.getSaveFileName( "Select output file", "*.*" )
									if(FileOut) then
										outfile = io.output( FileOut)
										outfile:write(cara:getRecord(selected_OID):getAttr("Body")) 
										outfile:close()
										answ=dlg.getSymbol("Exported as file: ",FileOut,"continue")	
									end --if(outfile) 
								end    --if(menu_id==6
								
								if(menu_id==7)then
								local t={};
								t.P = cara:getProject( "NMRgenerator" )
								local SpectrumNames = {}
								local SpectrumIds = {}
								i = 0
									for id,spectrum in pairs( t.P:getSpectra() ) do
										if spectrum:getDimCount() == 1 then
										-- spectrum is a 1D
										i = i + 1
										SpectrumIds[ i ] = spectrum:getId()
										--SpectrumNames[ i ] = spectrum:getId()..":"..spectrum:getName()
										SpectrumNames[ i ] = spectrum:getName()
										end --if
									end --for id,s
								t.SpectrumName = dlg.getSymbol( "Select Spectrum","", unpack( SpectrumNames ) )
								for i = 1,table.getn( SpectrumNames ) do
									if SpectrumNames[ i ] == t.SpectrumName then
									t.Spectrum = t.P:getSpectrum( SpectrumIds[ i ] )
									print("Selected spectrum ID "..SpectrumIds[ i ].. " named: "..SpectrumNames[ i ])
									cara:getRecord(selected_OID):setAttr("1D Spectrum",t.SpectrumName);
									end --if SpectrumN
								end-- for i = 1,table
								-- DRAW spectrum
								Draw1Dspectrum(t.SpectrumName)
								--local t23 = dlg.getSymbol("Stop","select YES or NO", "YES" ,"NO" )				 
								end    --if(menu_id==7

								if(menu_id==8)then
									local t={};
									t.P = cara:getProject( "NMRgenerator" )
									t.SpectrumName=cara:getRecord(selected_OID):getAttr("1D Spectrum");
									Draw1Dspectrum(t.SpectrumName)
								end --if(menu_id==8)
								
								if(menu_id==9)then
								local t={};
								t.P = cara:getProject( "NMRgenerator" )
								t.r = t.P:getAttr("Sample")
								local values_screatescroll = t.r:getAttrs()	
								local SampleNames = {}
								local SampleIds = {}
								i=0
									if(object_attributes["Sample"]["attr"..1]) then --["attr1"]="Sample Name"
										for key,value in pairs(values_screatescroll) do --loop over all macroses
										i=i+1
											--print(key) --key is a number of record, therefore the record is accessible by this number
											local samplename=value:getAttr(object_attributes["Sample"]["attr1"])
											--print(samplename)
											SampleNames[i]=samplename
											SampleIds[i]=key
										end --for
									end--if


								t.SampleName = dlg.getSymbol( "Select Sample","", unpack( SampleNames ) ) 
								for i = 1,table.getn( SampleNames ) do
									if SampleNames[ i ] == t.SampleName then
									--t.Spectrum = t.P:getSpectrum( SpectrumIds[ i ] )
									print("Selected Sample ID "..SampleIds[ i ].. " named: "..SampleNames[ i ])
									cara:getRecord(selected_OID):setAttr("Ref Sample",t.SampleName);
									end --if SpectrumN
								end-- for i = 1,table
								
								--local t23 = dlg.getSymbol("Stop","select YES or NO", "YES" ,"NO" )												
								
								end    --if(menu_id==9




							end);
				else --if(selected_OID)
					local selected_name=nil
					local selected_type=nil
					for key21,value21 in pairs(self:getData().subitem) do
					if(self:getData().subitem[key21]:isSelected()) then
					selected_name=self:getData().subitem_name[key21];
					selected_type=self:getData().subitem_type[key21];
					end --if(self:getData().subitem[key21]:isSelected()) 
					end --key21,value21 in pairs(self:g
						if(selected_name) then --if clicked outside of list
					print("selected: "..selected_name.."  type: "..selected_type) 
					
--*******************************
					local scrollview_popup_menu=gui.createPopupMenu(self:getData().main_w_main_f);
						scrollview_popup_menu:insertItem("Import content",1,1);
						scrollview_popup_menu:setWhatsThis(1,"Create and open the entry in Attribute Editor");
						scrollview_popup_menu:insertSeparator();
						scrollview_popup_menu:insertItem("Info ",3,3);
						scrollview_popup_menu:setWhatsThis(3,"Print useful information");
						scrollview_popup_menu:popup(x1,y1);
						
							scrollview_popup_menu:setCallback(gui.event.Activated,
							function(self,menu_id)
								if(menu_id==1)then
								CreateEntry(selected_name,selected_type);				 
								end    --if(menu_id==1
								if(menu_id==3)then
								print(selected_name.." of type "..selected_type.." -not in repository!");
answ=dlg.getSymbol("Not (yet) in repository!","Data type: "..selected_type..", name: "..selected_name,"continue","add to repository")					
if(answ=="add to repository") then CreateEntry(selected_name,selected_type) end
								end    --if(menu_id==1
							end);
--********************************
						end --if(selected_name) then
				end --if(selected_OID)		
		end);


return nmr_repository_scrollview_screatescroll,itemlist,subitemlist,subitemlist_OID,subitemlist_name,subitemlist_type;
end --function create_scroll

function CreateDomXML(items4DomXML)
local dom = nil
local dom_elements={}
local dom_elements1={}


if(items4DomXML) then 
dom = xml.parseDocument("<NMRitems>Components of NMR experiment</NMRitems>")

for key,value in pairs(items4DomXML) do

local curr_record=cara:getRecord(key)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..key,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..key,"continue");
return
end

print("Item OID for DomDocument: "..key) --this returns record's OID
dom_elements[key]=dom:getDocumentElement():createElement("record")
dom_elements[key]:setAttribute("oid"," "..key)


for key1,value1 in pairs(curr_record:getAttrs()) do
--print("KEYY "..key1.." value: "..value1)
dom_elements1[key.."a"..key1]=dom_elements[key]:createElement("attr")
dom_elements1[key.."a"..key1]:setAttribute("name",key1)
dom_elements1[key.."a"..key1]:setAttribute("type","String")
dom_elements1[key.."a"..key1]:createText(value1)
end --for key1,value1 in pairs(curr_record:getAttrs())


end --for key,value in pairs(items4DomXML)


end--if(items4DomXML)
return dom
end --function CreateDomXML(items4export,subitems4export)

function createRecordsFromDom(dom) --returns number of created records
local nr=0
if(dom:getDocumentElement():getName()=="NMRitems") then
print("XML tag name is OK")
--records OID level
--local record=dom:getDocumentElement():getFirstChild():getNextSibling()
--local recordOID=record:getAttribute(oid)
--print("record OID: "..recordOID)
childlist=dom:getDocumentElement():getFirstChild():getChildren()
for key,value in pairs(childlist) do
--print(key.."  = "..value)
--print(key)
print(value)
--print(value:isText())
end


else
answ=dlg.getSymbol("XML:","Not named as NMRitems but:"..dom:getDocumentElement():getName(),"continue")
end
return nr
end --function createRecordsFromDom(dom)

function CreatePHPBB3text(items4DomXML)
local dom = nil
local dom_elements={}
local dom_elements1={}

local accumulator="[nmritems]"
local tmpt=""
if(items4DomXML) then 

for key,value in pairs(items4DomXML) do

local curr_record=cara:getRecord(key)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..key,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..key,"continue");
return
end

print("Item OID for DomDocument: "..key) --this returns record's OID
--dom_elements[key]=dom:getDocumentElement():createElement("record")
--dom_elements[key]:setAttribute("oid"," "..key)
accumulator=accumulator.." [nmrrecord]"
for i = 0, 200 do  
	if(object_attributes[curr_type]["attr"..i]) then
	local key1=object_attributes[curr_type]["attr"..i]
	local value1=curr_record:getAttr(object_attributes[curr_type]["attr"..i])
		if(value1) then
		accumulator=accumulator.."[nmrattr]"..key1
		tmpt="[nmrother]"..value1.."[\/nmrother]"
		if(string.find(key1,"Name")) then tmpt="[nmrname]"..value1.."[\/nmrname]" end
		if(string.find(key1,"Author")) then tmpt="[nmrauthor]"..value1.."[\/nmrauthor]" end
		if(string.find(key1,"URL")) then tmpt="[nmrurl]"..value1.."[\/nmrurl]" end
		if(string.find(key1,"Type")) then tmpt="[nmrtype]"..value1.."[\/nmrtype]" end
		if(string.find(key1,"Body")) then tmpt="[nmrcode]"..value1.."[\/nmrcode]" end
		accumulator=accumulator..tmpt
		accumulator=accumulator.."[\/nmrattr]"
		end --if(value1)
	end --if(object_attributes[
end --for i = 0,200

--for key1,value1 in pairs(curr_record:getAttrs()) do
--print("KEYY "..key1.." value: "..value1)
--accumulator=accumulator.."[nmrattr]"..key1
--tmpt="[nmrother]"..value1.."[\/nmrother]"
--if(string.find(key1,"Name")) then tmpt="[nmrname]"..value1.."[\/nmrname]" end
--if(string.find(key1,"Author")) then tmpt="[nmrauthor]"..value1.."[\/nmrauthor]" end
--if(string.find(key1,"URL")) then tmpt="[nmrurl]"..value1.."[\/nmrurl]" end
--if(string.find(key1,"Type")) then tmpt="[nmrtype]"..value1.."[\/nmrtype]" end
--if(string.find(key1,"Body")) then tmpt="[nmrcode]"..value1.."[\/nmrcode]" end
--accumulator=accumulator..tmpt
--accumulator=accumulator.."[\/nmrattr]"
--end --for key1,value1 in pairs(curr_record:getAttrs())



accumulator=accumulator.."[\/nmrrecord]"
end --for key,value in pairs(items4DomXML)
end--if(items4DomXML)

accumulator=accumulator.."[\/nmritems]"
return accumulator
end --function 

function createRecordsFromPHPBB3(formatted_text) --returns number of created records
local nr=0
if(dom:getDocumentElement():getName()=="NMRitems") then
print("XML tag name is OK")
--records OID level
--local record=dom:getDocumentElement():getFirstChild():getNextSibling()
--local recordOID=record:getAttribute(oid)
--print("record OID: "..recordOID)
childlist=dom:getDocumentElement():getFirstChild():getChildren()
for key,value in pairs(childlist) do
--print(key.."  = "..value)
--print(key)
print(value)
--print(value:isText())
end


else
answ=dlg.getSymbol("XML:","Not named as NMRitems but:"..dom:getDocumentElement():getName(),"continue")
end
return nr
end --function createRecordsFromDom(dom)

function create_current_status_infolines(main_window_main_frame)
-- Labels for current spectrometer, sample, working directory
   
 	 Current_settings_label={};
	 Current_settings={};
	local i=1
	local entry_szx=150
	local entry_szy=30
	local curr_type="Current Settings"
	
	Current_settings_label_top1=gui.createLabel(main_window_main_frame);
	Current_settings_label_top1:resize(entry_szx,entry_szy);
	Current_settings_label_top1:move(200,10);
	Current_settings_label_top1:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_top1:setText("Current settings"); --Name
	Current_settings_label_top1:setFont("Areal",14,0,0);
	Current_settings_label_top1:show();

	Current_settings_label_top2=gui.createLabel(main_window_main_frame);
	Current_settings_label_top2:resize(entry_szx,entry_szy);
	Current_settings_label_top2:move(540,10);
	Current_settings_label_top2:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_top2:setText("1H Calibration"); --Name
	Current_settings_label_top2:setFont("Areal",14,0,0);
	Current_settings_label_top2:show();

	

-- BUILD ITEMs	
--ESSENTIALS
-- ITEM o1
	Current_settings_label_essen1=gui.createLabel(main_window_main_frame);
	Current_settings_label_essen1:resize(entry_szx,entry_szy);
	Current_settings_label_essen1:move(540,58);
	Current_settings_label_essen1:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_essen1:setFont("Areal",13,0,0);
	Current_settings_label_essen1:setText("1H offset (o1, Hz):"); --Name
	Current_settings_label_essen1:show();
i=7;


if(cara:getProject( "NMRgenerator" ):getAttr("Current Settings")==nil) then
print("Creating Current Settings and all Components")
CreateCurrentSettingsAndAllComponents()
end

values = cara:getProject( "NMRgenerator" ):getAttr("Current Settings"):getAttrs()
--two level access
--for key,value in pairs(values) do
--values1=value:getAttrs()
--	for key,value1 in pairs(values1) do
--	print("key = "..key.." value1= "..value1)
--	end
--end




for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*1,entry_szy);
	Current_settings[i]:move(690, 54+38*0);
	execute_by_type_name("Spectrometer", get_cur_spectrometer())
	Current_settings[i]:addItem(" "..spectrometer[now].proton_carrier_298k); 
	if(attr_text) then Current_settings[i]:addItem(attr_text); end --if(attr_text)
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM o1
-- ITEM pl1
	Current_settings_label_essen2=gui.createLabel(main_window_main_frame);
	Current_settings_label_essen2:resize(entry_szx,entry_szy);
	Current_settings_label_essen2:move(540,58+38*1);
	Current_settings_label_essen2:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_essen2:setFont("Areal",13,0,0);
	Current_settings_label_essen2:setText("1H power (pl1, dB):"); --Name
	Current_settings_label_essen2:show();

i=8;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*1,entry_szy);
	Current_settings[i]:move(690, 54+38*1);
	execute_by_type_name("Spectrometer", get_cur_spectrometer())
	Current_settings[i]:addItem(" "..spectrometer[now].calibration_power_db_f1);
	if(attr_text) then Current_settings[i]:addItem(attr_text); end --if(attr_text)
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM pl1
-- ITEM p1
	Current_settings_label_essen3=gui.createLabel(main_window_main_frame);
	Current_settings_label_essen3:resize(entry_szx,entry_szy);
	Current_settings_label_essen3:move(540,58+38*2);
	Current_settings_label_essen3:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_essen3:setFont("Areal",13,0,0);
	Current_settings_label_essen3:setText("90 pulse (p1, mks):"); --Name
	Current_settings_label_essen3:show();
i=9;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*1,entry_szy);
	Current_settings[i]:move(690, 54+38*2);
	execute_by_type_name("Spectrometer", get_cur_spectrometer())
	Current_settings[i]:addItem(" "..spectrometer[now].calibration_pulse90_f1);
	if(attr_text) then Current_settings[i]:addItem(attr_text); end --if(attr_text)
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM pl1

i=11;
-- ITEM SR
	Current_settings_label_essen4=gui.createLabel(main_window_main_frame);
	Current_settings_label_essen4:resize(entry_szx,entry_szy);
	Current_settings_label_essen4:move(540,58+38*3);
	Current_settings_label_essen4:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Current_settings_label_essen4:setFont("Areal",13,0,0);
	Current_settings_label_essen4:setText("1H SR (sr, Hz):"); --Name
	Current_settings_label_essen4:show();

values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*1,entry_szy);
	Current_settings[i]:move(690, 54+38*3);
	execute_by_type_name("Sample", get_cur_sample())
	if(spectrometer[now].SR) then
		Current_settings[i]:addItem(" "..spectrometer[now].SR)
	else
		spectrometer[now].SR=0.0;
		Current_settings[i]:addItem(" "..spectrometer[now].SR)
	end
	if(attr_text) then Current_settings[i]:addItem(attr_text); end --if(attr_text)
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM SR


--END ESSENTIALS


--ITEM SPECTROMETER
i=1;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54);
		if(attr_text) then
			Current_settings[i]:addItem(attr_text); 
			execute_by_type_name(dynamic_type, attr_text)
			if(spectrometer[now].home_topspin) then
			values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
				for key,value in pairs(values) do 
				--print("AAA: "..spectrometer[now].home_topspin)
				value:setAttr(object_attributes["Current Settings"]["attr5"],spectrometer[now].home_topspin)
				--print("BBB: "..get_nmr_directory())
				end
			end --if(spectrometer[now].home_topspin)
		else --if(attr_text)
			Current_settings[i]:addItem("---")
		end --if(attr_text)
	for key,value in pairs(extract_attributes_named(object_attributes[dynamic_type]["attr1"])) do 
	Current_settings[i]:addItem(value);
	end
	Current_settings[i]:show();
--END ITEM SPECTROMETER
--ITEM Sample
i=2;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54+38);
		if(attr_text) then
			Current_settings[i]:addItem(attr_text); 
		else --if(attr_text)
			Current_settings[i]:addItem("---")
		end --if(attr_text)
	for key,value in pairs(extract_attributes_named(object_attributes[dynamic_type]["attr1"])) do 
	Current_settings[i]:addItem(value);
	end
	Current_settings[i]:show();
--END ITEM Sample
--ITEM Experiment
i=3;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54+38*2);
		if(attr_text) then
			Current_settings[i]:addItem(attr_text); 
		else --if(attr_text)
			Current_settings[i]:addItem("---")
		end --if(attr_text)
	for key,value in pairs(extract_attributes_named(object_attributes[dynamic_type]["attr1"])) do 
	Current_settings[i]:addItem(value);
	end
	Current_settings[i]:show();
--END ITEM Experiment
--ITEM macro name
i=4;
values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do attr_text=value:getAttr(object_attributes[curr_type]["attr"..i]) end
local dynamic_type=object_attributes[curr_type]["attr"..i]
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54+38*3);
		if(attr_text) then
			Current_settings[i]:addItem(attr_text); 
		else --if(attr_text)
			Current_settings[i]:addItem("---")
		end --if(attr_text)
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM macro name
--ITEM dir
i=5;
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54+38*4);
	Current_settings[i]:addItem(get_nmr_directory()); 
	Current_settings[i]:addItem(dlg.getCurrentDir()); 
	Current_settings[i]:setEditable(true)
	Current_settings[i]:show();
--END ITEM dir
--ITEM browser
i=6;
	Current_settings[i]=gui.createComboBox(main_window_main_frame);
	Current_settings[i]:resize(entry_szx*2.4,entry_szy);
	Current_settings[i]:move(130, 54+38*5.5);
	Current_settings[i]:addItem(get_cur_browser()); 
	Current_settings[i]:addItem("start firefox.exe"); 

	Current_settings[i]:show();
--END ITEM browser


Current_settings[1]:getData().cs4=Current_settings[5]
Current_settings[1]:getData().cs7=Current_settings[7] --o1
Current_settings[1]:getData().cs8=Current_settings[8] --o1
Current_settings[1]:getData().cs9=Current_settings[9] --o1

Current_settings[1]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr1"],self:getCurrentText())
					end
					execute_by_type_name(object_attributes["Current Settings"]["attr1"], self:getCurrentText()) 
					self:getData().cs7:clear()
					self:getData().cs7:addItem(" "..spectrometer[now].proton_carrier_298k)
					self:getData().cs8:clear()
					self:getData().cs8:addItem(" "..spectrometer[now].calibration_power_db_f1)
					self:getData().cs9:clear()
					self:getData().cs9:addItem(" "..spectrometer[now].calibration_pulse90_f1)
						local save_setdir=self:getData().cs4:getCurrentText()
						self:getData().cs4:clear()
						local cdir=dlg.getCurrentDir()
						if(save_setdir==cdir) then 
						self:getData().cs4:addItem(save_setdir) 
						self:getData().cs4:addItem(spectrometer[now].home_topspin)
						else	
						self:getData().cs4:addItem(spectrometer[now].home_topspin)
						self:getData().cs4:addItem(cdir) 
						end --if(save_setdir
							values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
							for key,value in pairs(values) do 
							value:setAttr(object_attributes["Current Settings"]["attr5"],self:getData().cs4:getCurrentText())
							print("output dir: "..get_nmr_directory())
							end

		end);
Current_settings[2]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr2"],self:getCurrentText())
					end
					execute_by_type_name(object_attributes["Current Settings"]["attr2"], self:getCurrentText()) 
		end);
Current_settings[3]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr3"],self:getCurrentText())
					end
		end);
Current_settings[4]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr4"],self:getCurrentText())
					end
		end);
Current_settings[5]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr5"],self:getCurrentText())
					end
		end);
Current_settings[6]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr6"],self:getCurrentText())
					end
		end);
Current_settings[7]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr7"],self:getCurrentText())
					end
					insert_to_spectrometer_after("proton_carrier_298k",self:getCurrentText())
		end);
Current_settings[8]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr8"],self:getCurrentText())
					end
					insert_to_spectrometer_after("calibration_power_db_f1",self:getCurrentText())
		end);
Current_settings[9]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr9"],self:getCurrentText())
					end
					insert_to_spectrometer_after("calibration_pulse90_f1",self:getCurrentText())
		end);
Current_settings[11]:setCallback(gui.event.Activated,
		function(self,menu_id)
					values = cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
					for key,value in pairs(values) do 
					value:setAttr(object_attributes["Current Settings"]["attr11"],self:getCurrentText())
					end
					insert_to_spectrometer_after("SR",self:getCurrentText())
		end);

 

end --function create_current_status_infolines(main_window_main_frame)


function date_stamp() 	 
 local datetime1={}
 local report
 datetime1=os.date("*t") -- from LUA manual
-- report=tostring(datetime1.year).."-"..tostring(datetime1.month).."-"..tostring(datetime1.day)
 report=tostring(datetime1.day).."-"..tostring(datetime1.month).."-"..tostring(datetime1.year)
return report;
end 

function extract_attributes_named(whatis)
--returns OID of record "whatis"
local listout={}

if(whatis==nil) then
listout["tmp"]="tmp"
else


local trcrds=cara:getRecords()
for key,value in pairs(trcrds) do 
local rcr=value:getAttr(whatis)
if(rcr) then
listout[rcr]=rcr
end
--print( key.." =(all) "..value:getAttr("Name")..",  "..value:getAttr("Type")..",  "..value:getAttr("Author")..",  "..value:getAttr("Date") ) 
end
end --if(wha

return listout;
end --end function 




function create_body_AttrEdit(at_main_window_main_frame1,at_numb_of_attr1,at_main_szx,at_main_szy,at_entry_szy )
local Attribute_body=nil
if(gui.createLuaEdit) then 
	Attribute_body=gui.createLuaEdit(at_main_window_main_frame1)
else
    Attribute_body=gui.createMultiLineEdit(at_main_window_main_frame1);
 	Attribute_body:setAlignment(gui.align.Left,gui.align.Top,true,true);
 	Attribute_body:setWordWrap(false);
end --if(gui.createLuaEdit)
	Attribute_body:resize(at_main_szx-10,at_main_szy-at_entry_szy*(at_numb_of_attr1+2));
	Attribute_body:move(10,at_entry_szy*(at_numb_of_attr1+2));
	Attribute_body:setBgColor("magenta");
	Attribute_body:setFont("Arial",12,0,0);
    --Attribute_body:setText(" ");
	--Attribute_body:show();
return Attribute_body;
end --function create_body_AttrEdit()


function create_filter_controls(main_window_main_frame0)
	local entry_szx=150
	local entry_szy=20
	local move_entry_szx=entry_szx*3
	local move_entry_szy=44

Filter_label=gui.createLabel(main_window_main_frame0);
Filter_label:resize(entry_szx,entry_szy);
--Filter_label:move(move_entry_szx*1.2,move_entry_szy);
Filter_label:move(move_entry_szx*1.2,10);
Filter_label:setAlignment(gui.align.Left,gui.align.Top,true,true);
Filter_label:setText("Show containing: ");
Filter_label:setFont("Arial",12,1,1);
Filter_label:show();

filter_query=gui.createComboBox(main_window_main_frame0);
filter_query:resize(entry_szx+50,entry_szy);
--filter_query:move(move_entry_szx*1.5,move_entry_szy);
filter_query:move(move_entry_szx*1.5,10);
filter_query:addItem("-");

for i = 1, 20 do if(keywords[i]) then
filter_query:addItem(keywords[i]);
end end

filter_query:setFont("Arial",12,1,1);
filter_query:setEditable(true);
filter_query:show();
return filter_query;
end --function



--########################
function versify_any_name(strinp) 	 
 local ScriptOutName
 local vnt=0
for vnm in string.gfind(strinp,"_v(%d+)") do
vnt=vnm
end
if(vnt == 0) then 
--print(strinp)
ScriptOutName = strinp.."_v1"
--print(ScriptOutName)
else
vnt=vnt+1
ScriptOutName = string.gsub( strinp,"_v(%d+)",("_v"..tostring(vnt)) )
end

return ScriptOutName;
end --function versify_any_name(strinp)
--###########################################

--########################
function Improve_name(strinp) 	 
 local ScriptOutName
ScriptOutName = string.gsub( strinp," ","_")
return ScriptOutName;
end --function versify_any_name(strinp)
--###########################################
--print(Improve_name("hjdh hdhd hdhd"))
--hjdh_hdhd_hdhd

function DuplicateEntry(record_OID)

local curr_record=cara:getRecord(record_OID)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..record_OID,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..record_OID,"continue");
return
end

local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end



print("Duplicate record: "..record_OID.." Type: "..curr_type.." in project: "..curr_project:getName())

--local at_numb_of_attr=0
--local attributes=object_attributes[curr_type]
--for key,value in pairs(attributes) do
--print(key)
--print(value)
--end

local new_name=""
local found_attrs=curr_record:getAttrs()

record_in_project = curr_project:getAttr(curr_type)
macro = cara:createRecord()


for key,value in pairs(found_attrs) do --run over all attributes
--print(key)  -- attr name like "Macro Name"
--print(value) --content like "watergate"
--macro:setAttr("Macro Name","zgpr")
macro:setAttr(key,value)
end --for key,value in pairs(found_attrs)


--versify attr1 (Name)  
	if(found_attrs[object_attributes[curr_type]["attr1"]]) then 
	--print("NAME: "..found_attrs[object_attributes[curr_type]["attr1"]])
	new_name=versify_any_name(found_attrs[object_attributes[curr_type]["attr1"]])
	print("Ver NAME: "..new_name)
	macro:setAttr(object_attributes[curr_type]["attr1"],new_name)
	else
	answ=dlg.getSymbol("Error in record "..record_OID,object_attributes[curr_type]["attr1"].." not found","continue")
	end

record_in_project:setAttr(macro:getId(),macro)
answ=dlg.getSymbol("New record: "..macro:getId(),"Type: "..curr_type..", in project: "..curr_project:getName(),"continue")

end --function DuplicateEntry(record_OID)

function RemoveEntry(record_OID)

local curr_record=cara:getRecord(record_OID)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..record_OID,"continue","get all record OID")
return
end


local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..record_OID,"continue");
return
end

local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end


answ=dlg.getSymbol("Remove record: "..record_OID,"Type: "..curr_type..", in project: "..curr_project:getName(),"continue removing","abort")
if(answ=="continue removing") then
cara:removeRecord(curr_record)
print("Removed record: "..record_OID.." Type: "..curr_type.." in project: "..curr_project:getName())
else
print("record remains: "..record_OID.." Type: "..curr_type.." in project: "..curr_project:getName())
end

end --function RemoveEntry(record_OID)

function CreateEntry(name, type)


local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end


record_in_project = curr_project:getAttr(type)
macro = cara:createRecord()
macro:setAttr(object_attributes[type]["attr0"],type)
macro:setAttr(object_attributes[type]["attr1"],name)
macro:setAttr("Datum",date_stamp())
record_in_project:setAttr(macro:getId(),macro)
AttributeEditor(macro:getId())

end --function CreateEntry(name, type)


function ExportEntry(record_OID)

local curr_record=cara:getRecord(record_OID)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..record_OID,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..record_OID,"continue");
return
end

local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end
print("Export record: "..record_OID.." Type: "..curr_type.." in project: "..curr_project:getName())

local new_name=""
local found_attrs=curr_record:getAttrs()
--improve attr1 (Name)  
	if(found_attrs[object_attributes[curr_type]["attr1"]]) then 
	--print("NAME: "..found_attrs[object_attributes[curr_type]["attr1"]])
	new_name=Improve_name(found_attrs[object_attributes[curr_type]["attr1"]])
	local FileOut= get_nmr_directory().."/"..object_attributes[curr_type]["location"].."/"..new_name
--test on errors
		outfile,errmsg=io.open(FileOut,"a")
		if(outfile==nil) then 
			answ=dlg.getSymbol("Error in write! record: "..record_OID,errmsg,"continue")
		else
			outfile:close()
			outfile = io.output( FileOut)
			outfile:write(curr_record:getAttr(object_attributes[curr_type]["attr99"])) 
			outfile:close()
			print("Exported as file: "..FileOut)
		end --if(outfile) then			
	else
	answ=dlg.getSymbol("Error in record "..record_OID,object_attributes[curr_type]["attr1"].." not found","continue")
	end
end --function ExportEntry(record_OID)
--########################################################

function ImportEntry(record_OID)

local curr_record=cara:getRecord(record_OID)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..record_OID,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..record_OID,"continue");
return
end

local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end
print("Import to record: "..record_OID.." Type: "..curr_type.." in project: "..curr_project:getName())

local new_name=""
local found_attrs=curr_record:getAttrs()
	if(found_attrs[object_attributes[curr_type]["attr1"]]) then 
	new_name=found_attrs[object_attributes[curr_type]["attr1"]]
	local nmrd=get_nmr_directory()
	local FileIn=nmrd.."/"..object_attributes[curr_type]["location"].."/"..new_name
--test on errors
		outfile,errmsg=io.open(FileIn,"r")
		if(outfile==nil) then 
			answ=dlg.getSymbol("Error in read! record: "..record_OID,errmsg,"find file elsewhere","continue")
				if(answ=="find file elsewhere") then
							local FileIn = dlg.getOpenFileName( "Select file", "*.*" )
							local accumulator=""
								if(FileIn) then 
									for line in io.lines(FileIn) do
									if(line) then accumulator=accumulator..line.."\n" end
									end
								curr_record:setAttr(object_attributes[curr_type]["attr99"],accumulator);
								print("Imported as file: "..FileIn)
								end --if(FileIn) then
				end
		else
			outfile:close()
			local accumulator=""
			for line in io.lines(FileIn) do
			if(line) then accumulator=accumulator..line.."\n" end
			end
			--print("attr: "..object_attributes[curr_type]["attr99"])
			--print("body: "..accumulator)
			curr_record:setAttr(object_attributes[curr_type]["attr99"],accumulator);
			print("Imported as file: "..FileIn)
		end --if(outfile) then			
	else
	answ=dlg.getSymbol("Error in record "..record_OID,object_attributes[curr_type]["attr1"].." not found","continue")
	end
end --function ImportEntry(record_OID)

function CreateImportEntry(name, type)
local curr_project=cara:getProject("NMRgenerator")
if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project is not setup in repository "..record_OID,"continue");
return
end

print("BBB "..type)
record_in_project = curr_project:getAttr(type)
macro = cara:createRecord()
macro:setAttr(object_attributes[type]["attr0"],type)
macro:setAttr(object_attributes[type]["attr1"],name)
macro:setAttr("Datum",date_stamp())
record_in_project:setAttr(macro:getId(),macro)
ImportEntry(macro:getId())

end --function CreateImportEntry(name, type)

function calc_power_set(curren_pulse90,reference_shape_constant,calibration_pulse90,calibration_power_db) 	 
 local reference_rect_pulse90 = 10.; --mks --from NMRSIM
 local reference_rect_power_rf=50000.; --Hz       NMRSIM
 local calibration_constant_db = 0.;
 local out_put=120;

out_put=20.*math.log10(reference_shape_constant*curren_pulse90/(calibration_pulse90))+calibration_power_db;
return out_put;
end 



function execute_by_type_name(curr_type, record_name)

local luacode=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr(curr_type)

values = r:getAttrs()
for key,value in pairs(values) do 
	if(record_name==value:getAttr(object_attributes[curr_type]["attr1"])) then --record found
--	print(key.." = "..value:getAttr(object_attributes[curr_type]["attr99"])) --print body
	luacode=value:getAttr(object_attributes[curr_type]["attr99"])
--compile and execute
			local chunk,errmsg=loadstring(luacode);
				if(chunk) then
				assert(loadstring(luacode))()
				print("Executed: "..record_name.." of type: "..curr_type)
				--answ=dlg.getSymbol("Results of checking","Seems OK","continue")
				else
				print("Error: "..errmsg)
				answ=dlg.getSymbol("Error in compilation!",errmsg,"continue")
				end


	end --if(record_n
end

end --function execute_by_type_name(curr_type, record_name)

function retrive_by_type_name(curr_type, record_name)

local luacode=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr(curr_type)

values = r:getAttrs()
for key,value in pairs(values) do 
	if(record_name==value:getAttr(object_attributes[curr_type]["attr1"])) then --record found
--	print(key.." = "..value:getAttr(object_attributes[curr_type]["attr99"])) --print body
	luacode=value:getAttr(object_attributes[curr_type]["attr99"])
	end --if(record_n
end
return(luacode)
end --function retrive_by_type_name(curr_type, record_name)

function retriveOID_by_type_name(curr_type, record_name)
local OID=0
local p = cara:getProject("NMRgenerator")
local r = p:getAttr(curr_type)

values = r:getAttrs()
for key,value in pairs(values) do 
	if(record_name==value:getAttr(object_attributes[curr_type]["attr1"])) then --record found
	--print(key.." = "..value:getAttr(object_attributes[curr_type]["attr1"])) --print body
	OID=key --value:getAttr(object_attributes[curr_type]["attr1"])
	end --if(record_n
end
return(OID)
end --function retriveOID_by_type_name(curr_type, record_name)


function get_cur_macro()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr3"])
end
return nmrdir
end

function get_cur_helpurl()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr10"])
end
return nmrdir
end


function get_cur_browser()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr6"])
end
--return nmrdir
return InternetBrowser
end

function get_cur_spectrometer()
local cursp=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
cursp=value:getAttr(object_attributes["Current Settings"]["attr1"])
end
return cursp
end

function get_cur_sample()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr2"])
end
return nmrdir
end

function get_nmr_directory()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr5"])
end
return nmrdir
end
function get_out_macro()
local nmrdir=""
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
nmrdir=value:getAttr(object_attributes["Current Settings"]["attr4"])
end
return nmrdir
end

function add_string_to_body_of_currentsettings(strng)
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
value:setAttr(object_attributes["Current Settings"]["attr99"],strng)
end
end

function show_currentsettings()
local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")
values = r:getAttrs()
for key,value in pairs(values) do 
AttributeEditor( key)
end
end--function show_currentsettings()


function ExportMacro(exp_vars, exp_vars_afterGetprosol)


MacFileLocation = get_nmr_directory().."/mac/"..get_out_macro()

outfile=io.open( MacFileLocation,"w")
if(nil == outfile) then
print("Cant't open file: "..MacFileLocation)
local FileOut = dlg.getSaveFileName( "Select TopSpin Macro file", "*.mac" )
	if(FileOut) then
	MacFileLocation=FileOut	
	else
	return
	end
end
if(outfile) then outfile:close() end
outfile = io.output( MacFileLocation)


local pathway
pathway=get_nmr_directory()

--for k in string.gfind(MacFileLocation, "(.*)/") do
--if(k) then pathway=k end
--print(k)
--end
--print(pathway)
if(exp_vars["xcpr"]) then --write dimensionality first
outfile:write( "\nxcpr "..exp_vars["xcpr"] )
end

for key, value in pairs( exp_vars ) do
	if(string.find(key,"(%s*)xcpr(%d-)") or string.find(key,"(%s*)script(%d-)") or string.find(key,"(%s*)getprosol(%d-)") ) then --remove "script" and "getprosol" statements from macro printout
		print("Parsed out: "..key.." "..value)
	else
		outfile:write( "\n"..key.." "..value ) 
	end --if(string.find(key,"(%s
end --for key, value in pairs( exp_vars )

if(exp_vars["getprosol"] and exp_vars.p1 and exp_vars.pl1) then --write getprosol at pre-last
outfile:write( "\ngetprosol "..exp_vars["getprosol"].." "..exp_vars.p1.." ".. exp_vars.pl1)
end

-- params to be setup after execution of getprosol. This is needed since getprosol missets some pulses, e.g. in roesy p15 is misset
for key, value in pairs( exp_vars_afterGetprosol ) do
		outfile:write( "\n"..key.." "..value ) 
end --for key, value in pairs( exp_vars )



outfile:close()
local accum=""
accum=accum.."\n##########\n"
accum=accum.."Macro file for TopSpin "..MacFileLocation.." is written.\n"
accum=accum.."Link these files to TopSpin file structure as suggested:"
accum=accum.."\n\n\n"

accum=accum.."ln -s "..MacFileLocation.." "..spectrometer[now].home_topspin.."/mac\n"

for key, value in pairs( exp_vars ) do
if  string.find( key,"cpdprg" ) then
accum=accum.."ln -s "..pathway.."/cpd/"..exp_vars[key].." "..spectrometer[now].home_topspin.."/cpd\n"
end
end

for key, value in pairs( exp_vars ) do
if  string.find( key,"pulprog" ) then
accum=accum.."ln -s "..pathway.."/pp/"..exp_vars[key].." "..spectrometer[now].home_topspin.."/pp\n"
end
end

for key, value in pairs( exp_vars ) do
if  string.find( key,"spnam" ) then
accum=accum.."ln -s "..pathway.."/wave/"..exp_vars[key].." "..spectrometer[now].home_topspin.."/wave\n"
accum=accum.."\n"
end
end 
print(accum)
answ=dlg.getSymbol("Macro for TS written",MacFileLocation,"View macro","View info","continue")
if(answ=="View macro") then
			local accumulator=""
			for line in io.lines(MacFileLocation) do
				if(line) then accumulator=accumulator..line.."\n" end
			end
			add_string_to_body_of_currentsettings(accumulator)
			show_currentsettings()
end --if(answ=="View macro")
if(answ=="View info") then
			add_string_to_body_of_currentsettings(accum)
			show_currentsettings()

end

end --fucntion ExportMacro


function ExportMacroSSR(exp_vars,phclc, j_max_ph,lns, j_max)


MacFileLocation = get_nmr_directory().."/mac/"..get_out_macro()

outfile=io.open( MacFileLocation,"w")
if(nil == outfile) then
print("Cant't open file: "..MacFileLocation)
local FileOut = dlg.getSaveFileName( "Select SSR input file", "*.mac" )
	if(FileOut) then
	MacFileLocation=FileOut	
	else
	return
	end
end
if(outfile) then outfile:close() end
outfile = io.output( MacFileLocation)


local pathway
pathway=get_nmr_directory()

--for k in string.gfind(MacFileLocation, "(.*)/") do
--if(k) then pathway=k end
--print(k)
--end
--print(pathway)

for key, value in pairs( exp_vars ) do
if(string.find(key,"(%s*)script(%d-)")) then 
print("Parsed out: "..key.." "..value)
else
if(string.find(key,"(%d)(%s+)(%w+)") or 
   string.find(key,"xcpr") or
   string.find(key,"pulprog")
   ) then 
--print(key)
else
	if(string.find(key,"nam")) then
	outfile:write( "\nv."..key.."='wave/"..value.."';" )
	else
	outfile:write( "\nv."..key.."="..value..";" )
	end --if
	--pulse length conversion
		for dl in string.gfind(key, "p(%d+)") do
		if(string.find(key,"sp")) then
		 --do nothing id sp1 is found
		else
		outfile:write( "\nv."..key.."="..value.."*1e-6;" )
		end
		end --if
		for dl in string.gfind(key, "pcpd(%d+)") do
		outfile:write( "\nv."..key.."="..value.."*1e-6;" )
		end --if

	
end --if
end
end
for j = 0, j_max_ph-1 do
	outfile:write("v."..phclc[j].."\n");
end --for j = 0, j_max-1
for j = 0, j_max-1 do
    outfile:write("%% --"..orig_lns[j]);
	--outfile:write(lns[j].."\n");
	outfile:write("events{1,ek}='"..lns[j].."'; ek=ek+1;\n"); 
end --for j = 0, j_max-1

outfile:close()
answ=dlg.getSymbol("Macro for TS written",MacFileLocation,"View macro","View info","continue")
if(answ=="View macro") then
			local accumulator=""
			for line in io.lines(MacFileLocation) do
				if(line) then accumulator=accumulator..line.."\n" end
			end
			add_string_to_body_of_currentsettings(accumulator)
			show_currentsettings()
end --if(answ=="View macro")
if(answ=="View info") then
			add_string_to_body_of_currentsettings(accum)
			show_currentsettings()

end

end --fucntion ExportMacroSSR




function find_pattern(search_text, search_pattern)
--retuns value in ["key"]="value"
ret99=nil
--print("ssss: "..search_text)
if(search_text and search_pattern) then
if(string.find(search_text,search_pattern)) then
local x = string.gsub(search_text, "%s*.."..search_pattern.."..%s*=%s*\"([%w_.,-]+)", function (v)
ret99=v
--print("vvv: "..v)
--return ret99
end)
end --if(string.find(search_text,search_pattern) then
end --if(search_text and search_pattern) then
return ret99
end --function find_pattern(search_text, search_pattern) 
--local curr_record=cara:getRecord(62)
--local tt = curr_record:getAttr("Body")
--print(tt)
--print("found: "..find_pattern(tt,"cpdprg2"))

function open_in_browser(xmlfile) 
local url
if(xmlfile) then 
	if(string.find(xmlfile,"file")) then url="\""..xmlfile.."\"" 
	else
		if(string.find(xmlfile,"http")) then url="\""..xmlfile.."\"" 
		else url="\"".."http://"..xmlfile.."\""
		end --if(string.find(xmlfile,"http"))
	end --if(string.find(xmlfile,"file"))
	
	
	print("Location to open: "..get_cur_browser().." "..url) 
	os.execute(get_cur_browser().." "..url.." &")
	--print(get_cur_browser().." "..url.." &")
end--if(xmlfile)
	end --function open_in_browser(xmlfile, filetype) --filetype="file:///" or "http://"

function insert_to_spectrometer_after(variable, inserttxt)

local luacode=""
local curr_type="Spectrometer"
local curspec=get_cur_spectrometer()
local p = cara:getProject("NMRgenerator")
local r = p:getAttr(curr_type)
values11 = r:getAttrs()
for key,value in pairs(values11) do 
	--print(key.." = "..value:getAttr(object_attributes[curr_type]["attr1"])) --print body
	if(curspec==value:getAttr(object_attributes[curr_type]["attr1"])) then --record found
	--print(key.." = "..value:getAttr(object_attributes[curr_type]["attr1"])) --print body
	luacode=value:getAttr(object_attributes[curr_type]["attr99"])
--compile and execute insert
			local chunk,errmsg=loadstring(" test="..inserttxt);
				if(chunk) then
				assert(loadstring(" test="..inserttxt))()
				print("Executed: ".." test="..inserttxt.." = "..test)
				--answ=dlg.getSymbol("Results of checking","Seems OK","continue")
				else
				print("Error: "..errmsg)
				answ=dlg.getSymbol("Error in compilation!",errmsg,"continue")
				end

local x
if(variable) then
if(string.find(luacode,variable.."(%s*)=(%s*)")) then
x = string.gsub(luacode, variable.."(%s*)=(%s*)", variable.."="..inserttxt..", --")
end 
end
--print(x)
value:setAttr(object_attributes[curr_type]["attr99"],x)
	end --if(curspec
end

end --function insert_to_spectrometer_after(variable, inserttxt)

function find_text_between_tags(search_text, tag1,tag2) --retuns text between tags next to each other, and outside text
local tag1posB,tag1posE,tag2posB,tag2posE
	if(search_text and tag1 and tag2) then
		tag1posB,tag1posE=string.find(search_text,tag1)
		tag2posB,tag2posE=string.find(search_text,tag2)
			if(tag1posB and tag2posB) then
			    --print("POS: "..tag1posB.."  "..tag2posB)
				if(tag1posB>=tag2posB) then
				print("Error in function find_text_between_tags: Pattern tag2 is before tag1: "..tag1posB.."  "..tag2posB)
				return nil,nil end
				local txtbetween=string.sub(search_text,tag1posE+1,tag2posB-1)
				local txtoutside=string.sub(search_text,1,tag1posB-1)..string.sub(search_text,tag2posE+1,-1)
				--print("ssss2: "..txtoutside)
				return txtbetween,txtoutside
			end --if(tag1posB and tag2posB)
	end --if(search_text an
return nil,nil
end --function find_text_between_tags(search_text, tag1,tag2) 

function parseRecordsFromPHPBB3(pastedtxt)
local nmritemstxt=""
local insidetxt=""
local outsidetxt=""
local records={}
local attrs={}
local att_v_k={}
local curr_project=cara:getProject("NMRgenerator")

--insidetxt,outsidetxt=find_text_between_tags("[nmrattr]Type[nmrtype]Spectrometer[\/nmrtype][nmrtype]Macro[\/nmrtype][\/nmrattr]", "%[nmrtype%]","(%[)(%/)nmrtype%]")

--level nmritems 
nmritemstxt,outsidetxt=find_text_between_tags(pastedtxt, "%[nmritems%]","(%[)(%/)nmritems%]")
if(nmritemstxt) then 
	--level records
		local i=1
		records[i],outsidetxt=find_text_between_tags(nmritemstxt, "%[nmrrecord%]","(%[)(%/)nmrrecord%]")
		while(records[i] and outsidetxt) do i=i+1
		records[i],outsidetxt=find_text_between_tags(outsidetxt, "%[nmrrecord%]","(%[)(%/)nmrrecord%]")
		end --while(nmrrecord[i]
	--print("Captured: "..records[2])

for kky,vva in pairs(records) do
		--level attr
		local i=1
		attrs[i],outsidetxt=find_text_between_tags(records[kky], "%[nmrattr%]","(%[)(%/)nmrattr%]")
		while(attrs[i] and outsidetxt) do i=i+1
		attrs[i],outsidetxt=find_text_between_tags(outsidetxt, "%[nmrattr%]","(%[)(%/)nmrattr%]")
		end --while(attrs[i]
		
		for kk,vv in pairs(attrs) do
		--print(vv)
			--level type
			value,key=find_text_between_tags(attrs[kk], "%[nmrtype%]","(%[)(%/)nmrtype%]")
			if(value and key) then att_v_k[key]=value end
			value,key=find_text_between_tags(attrs[kk], "%[nmrother%]","(%[)(%/)nmrother%]")
			if(value and key) then att_v_k[key]=value end
			value,key=find_text_between_tags(attrs[kk], "%[nmrname%]","(%[)(%/)nmrname%]")
			if(value and key) then att_v_k[key]=value end
			value,key=find_text_between_tags(attrs[kk], "%[nmrcode%]","(%[)(%/)nmrcode%]")
			if(value and key) then att_v_k[key]=value end
			value,key=find_text_between_tags(attrs[kk], "%[nmrauthor%]","(%[)(%/)nmrauthor%]")
			if(value and key) then att_v_k[key]=value end
			value,key=find_text_between_tags(attrs[kk], "%[nmrurl%]","(%[)(%/)nmrurl%]")
			if(value and key) then att_v_k[key]=value end
		end --for kk,vv in pairs(attrs)

if(att_v_k["Type"]) then 
record_in_project = curr_project:getAttr(att_v_k["Type"])
if(record_in_project) then
macro = cara:createRecord()
		for kk,vv in pairs(att_v_k) do
if(kk=="Datum") then
macro:setAttr(kk,date_stamp())
else
macro:setAttr(kk,vv)
end
record_in_project:setAttr(macro:getId(),macro)
		end --for kk,vv in pairs(att_v_k)
AttributeEditor(macro:getId())

end --if(record_in_project)
end --if(att_v_k["Type"])

end --for kky,vva in pairs(records) do


else
print("Error: Inputs has not nmritems tags")
end --if(nmritemstxt)

end --function parseRecordsFromPHPBB3(pastedtxt)

 function StartPage()
 
 local entry_szx=150
 local entry_szy=20
 local bar_w= 40
 local push_button_w= 120
 local main_szx=900 --the rest defined dynamically
 local main_szy=350

	main_display_window_startpage=gui.createWidget();    --this is the highest level window
	main_display_window_startpage:showNormal();
	--main_display_window_startpage:setBgColor("light grey");
	main_display_window_startpage:setBgColor("yellow");
   main_display_window_startpage:setCaption("NMR generator: Start Page");
	main_display_window_startpage:resize(main_szx,main_szy);
	main_display_window_startpage:move(40,20);
	main_display_window_startpage:getData().m_szx=main_szx;
	main_display_window_startpage:getData().m_szy=main_szy;
	
main_display_window_startpage:setCallback(gui.event.Closing,
		function(self)
			print("Closing Start Page");
					end);

main_window_main_frame_startpage=gui.createFrame(main_display_window_startpage);
main_display_window_startpage:getData().frame=main_window_main_frame_startpage;

central_display_widget_startpage=gui.createWidget(main_window_main_frame_startpage);
main_window_main_frame_startpage:setBgColor("yellow");
	main_window_main_frame_startpage:resize(main_szx,main_szy);
	main_window_main_frame_startpage:show();
	
	
--MENUE BAR
main_window_menu_bar_startpage=gui.createWidget(main_display_window_startpage);
	main_window_menu_bar_startpage:move(0,0);
    main_window_menu_bar_startpage:resize(push_button_w+4,main_szy);
	main_window_menu_bar_startpage:setBgColor("grey");
	main_window_menu_bar_startpage:show();
--END MENUE BAR

--BUTTON HOW-TO-USE
	main_file_menu_button_startpage1=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage1:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage1:move(2,2);
	main_file_menu_button_startpage1:setBgColor("green");
	main_file_menu_button_startpage1:setText("How to use");
	main_file_menu_button_startpage1:show();
	main_file_menu_button_startpage1:setCallback(gui.event.Clicked,
		function(self)
			open_in_browser(get_cur_helpurl());
					end);

--BUTTON SPECTROMETER
	main_file_menu_button_startpage2=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage2:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage2:move(2,bar_w+10);
	main_file_menu_button_startpage2:setBgColor("magenta");
	main_file_menu_button_startpage2:setText("1. Spectrometers");
	main_file_menu_button_startpage2:show();
	main_file_menu_button_startpage2:setCallback(gui.event.Clicked,
		function(self)
			ContentEditor("Spectrometer");
					end);
--BUTTON SPECTROMETER
--BUTTON Sample
	main_file_menu_button_startpage3=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage3:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage3:move(2,bar_w*2-2+10);
	main_file_menu_button_startpage3:setBgColor("magenta");
	main_file_menu_button_startpage3:setText("2. Samples");
	main_file_menu_button_startpage3:show();
	main_file_menu_button_startpage3:setCallback(gui.event.Clicked,
		function(self)
			ContentEditor("Sample");
					end);
--BUTTON 
--BUTTON Macro
	main_file_menu_button_startpage4=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage4:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage4:move(2,bar_w*3-4+10);
	main_file_menu_button_startpage4:setBgColor("magenta");
	main_file_menu_button_startpage4:setText("3. Experiments");
	main_file_menu_button_startpage4:show();
	main_file_menu_button_startpage4:setCallback(gui.event.Clicked,
		function(self)
			ContentEditor("Macro");
					end);
--BUTTON 
--BUTTON Calculate
	main_file_menu_button_startpage5=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage5:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage5:move(2,bar_w*4-6+10);
	main_file_menu_button_startpage5:setBgColor("red");
	main_file_menu_button_startpage5:setText("4. Calculate Macro");
	main_file_menu_button_startpage5:show();
	main_file_menu_button_startpage5:setCallback(gui.event.Clicked,
		function(self)
						--print("run "..self:getData().cr:getAttr("Body"))
			execute_by_type_name("Spectrometer", get_cur_spectrometer())
			execute_by_type_name("Sample", get_cur_sample())
			execute_by_type_name("Macro", get_cur_macro())
			if(exp_environment_afterGetprosol) then
				ExportMacro(exp_environment, exp_environment_afterGetprosol)
				else 
				exp_environment_afterGetprosol={}
				ExportMacro(exp_environment, exp_environment_afterGetprosol)
			end--if(exp_environment an
					end);
--BUTTON 
--BUTTON To Spinach
	main_file_menu_button_startpage8=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage8:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage8:move(2,bar_w*5-8+10);
	main_file_menu_button_startpage8:setBgColor("red");
	main_file_menu_button_startpage8:setText("To Spinach");
	main_file_menu_button_startpage8:show();
	main_file_menu_button_startpage8:setCallback(gui.event.Clicked,
		function(self)
						--print("run "..self:getData().cr:getAttr("Body"))
			To_Spinach();
					end);

--BUTTON 

--BUTTON Other lists
	main_file_menu_button_startpage6=gui.createPushButton(main_window_menu_bar_startpage);
	main_file_menu_button_startpage6:resize(push_button_w,bar_w-4);
	main_file_menu_button_startpage6:move(2,bar_w*5+60);
	main_file_menu_button_startpage6:setBgColor("blue");
	main_file_menu_button_startpage6:setText("More Lists..");
	main_window_file_menu_startpage7=gui.createPopupMenu(main_display_window_startpage);
	main_file_menu_button_startpage6:setPopup(main_window_file_menu_startpage7);

	main_file_menu_button_startpage6:show();
main_window_file_menu_startpage7:setCallback(gui.event.Showing,
		function(self,menu_id)
			self:clear();
			 
				self:insertItem("Current Settings",1,1);
				self:insertItem("Pulse Program",2,2);
				self:insertItem("Wave Form",3,3);
				self:insertItem("Composite Pulse Decoupling",4,4);
				self:insertItem("Script",5,5);
				self:insertSeparator();
				self:insertItem("Fetch Help from web",7,7);
		end);

main_window_file_menu_startpage7:setCallback(gui.event.Activated,
		function(self,menu_id)
			if(menu_id==1)then ContentEditor("Current Settings") end --if(menu_id==1
			if(menu_id==2)then ContentEditor("Pulse Program") end --if(menu_id==1
			if(menu_id==3)then ContentEditor("Wave Form") end --if(menu_id==1
			if(menu_id==4)then ContentEditor("Composite Pulse Decoupling") end --if(menu_id==1
			if(menu_id==5)then ContentEditor("Script") end --if(menu_id==1
			if(menu_id==7)then open_in_browser(get_cur_helpurl()) end --if(menu_id==1
		end);

--BUTTON 


create_current_status_infolines(main_window_main_frame_startpage);
--ContentEditor("Macro");

end --function StartPage()


--globally defined to avoid garbage collection

at_main_display_window={}
at_main_window_main_frame={}
Attribute_body={}
attr_window_menu_bar={}
attr_file_menu_button={}
attr_file_menu_button1={}
attr_file_menu_button2={}
attr_file_menu_button3={}
attr_file_menu_button4={}


function AttributeEditor(record_OID)

local curr_record=cara:getRecord(record_OID)
if(curr_record==nil) then answ=dlg.getSymbol("Inconsistency in dataset","No record with OID "..record_OID,"continue","get all record OID")
return
end

local curr_type=curr_record:getAttr("Type")
if(curr_type==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Attribute 'Type' is not setup in record "..record_OID,"continue");
return
end


number_of_opened_AttributeEditors=number_of_opened_AttributeEditors+1




local at_numb_of_attr=0
local attributes=object_attributes[curr_type]


local at_entry_szx=100
local at_entry_szy=20
local at_bar_w=30
local push_button_w=60
local at_main_szx=600
--local at_main_szy=at_entry_szy*10 + at_entry_szy*3
local at_main_szy=800
local steps_to_tail=50 -- to tail if many started

at_main_display_window[number_of_opened_AttributeEditors]=gui.createWidget();    --this is the highest level window
	--at_main_display_window[number_of_opened_AttributeEditors]:showFullScreen();
	at_main_display_window[number_of_opened_AttributeEditors]:showNormal();
	at_main_display_window[number_of_opened_AttributeEditors]:setBgColor("light grey");
	at_main_display_window[number_of_opened_AttributeEditors]:setCaption("Edit Attributes:    Type  "..curr_type..",    OID: "..curr_record:getId().."  ");
	at_main_display_window[number_of_opened_AttributeEditors]:resize(at_main_szx,at_main_szy);
	at_main_display_window[number_of_opened_AttributeEditors]:move(at_main_szx/4+number_of_opened_AttributeEditors*steps_to_tail,175+number_of_opened_AttributeEditors*steps_to_tail);
	at_main_display_window[number_of_opened_AttributeEditors]:setCallback(gui.event.Closing,
		function(self)
			--answ=dlg.getSymbol("Closing Attribute Editor","Use 'File' to update","OK","Discard")
			--if(answ=="OK") then
			--for i = 1, 20 do  
			--if(object_attributes[curr_type]["attr"..i]) then
				--print(Attribute[i]:getCurrentText())
				--curr_record:setAttr(object_attributes[curr_type]["attr"..i],Attribute[i]:getCurrentText())
			--end
			--end --for i = 1, 20  
			--curr_record:setAttr(object_attributes[curr_type]["attr99"],Attribute_body[number_of_opened_AttributeEditors]:getText())
			--print("Closing: repository updated")
			--else
			--print("Closing: discard changes")
			--end --if(ans
			number_of_opened_AttributeEditors=number_of_opened_AttributeEditors-1
			print("Attribute Editor: Closing.  "..number_of_opened_AttributeEditors.." still opened")
		end);
	at_main_display_window[number_of_opened_AttributeEditors]:setCallback(gui.event.Resized,
		function(self,w,h,old_w,old_h)
			--print("resized from: "..old_w.."  "..old_h.." to: "..w.." "..h);
			at_main_szx,at_main_szy=w,h;
			self:getData().frame:resize(at_main_szx,at_main_szy);
			self:getData().attr_body:resize(at_main_szx-10,at_main_szy-at_entry_szy*(at_numb_of_attr+2));
			self:getData().attr_body:show();
			
			--redraw_main_window();
		end);
		
	at_main_window_main_frame[number_of_opened_AttributeEditors]=gui.createFrame(at_main_display_window[number_of_opened_AttributeEditors]);
	at_main_display_window[number_of_opened_AttributeEditors]:getData().frame=at_main_window_main_frame[number_of_opened_AttributeEditors] --store frame for setCAllback (see page 90 of Calua manual)
	--local central_display_widget=gui.createWidget(at_main_window_main_frame[number_of_opened_AttributeEditors]);
	at_main_window_main_frame[number_of_opened_AttributeEditors]:resize(at_main_szx,at_main_szy);
	at_main_window_main_frame[number_of_opened_AttributeEditors]:show();

 	 Attribute_label={};
	 Attribute={};

for i = 0, 20 do  
if(object_attributes[curr_type]["attr"..i]) then
at_numb_of_attr=at_numb_of_attr+1
--print(object_attributes[curr_type]["attr"..i])
-- BUILD ITEMs	

	Attribute_label[number_of_opened_AttributeEditors*100+ i]=gui.createLabel(at_main_window_main_frame[number_of_opened_AttributeEditors]);
	Attribute_label[number_of_opened_AttributeEditors*100+i]:resize(at_entry_szx,at_entry_szy);
	Attribute_label[number_of_opened_AttributeEditors*100+i]:move(10,at_entry_szy*(1+i)+3+12);
	Attribute_label[number_of_opened_AttributeEditors*100+i]:setAlignment(gui.align.Left,gui.align.Top,true,true);
	Attribute_label[number_of_opened_AttributeEditors*100+i]:setText(object_attributes[curr_type]["attr"..i]..":"); --Name
	Attribute_label[number_of_opened_AttributeEditors*100+i]:show();

local attr_text=curr_record:getAttr(object_attributes[curr_type]["attr"..i])

-- Editable field	    
		Attribute[number_of_opened_AttributeEditors*100+i]=gui.createComboBox(at_main_window_main_frame[number_of_opened_AttributeEditors]);
		Attribute[number_of_opened_AttributeEditors*100+i]:resize(at_main_szx-at_entry_szx-10,at_entry_szy);
		Attribute[number_of_opened_AttributeEditors*100+i]:move(at_entry_szx+10,at_entry_szy*(1+i)+12);
			if(attr_text) then
								if(object_attributes[attr_text]) then
								Attribute[number_of_opened_AttributeEditors*100+i]:addItem(attr_text,object_attributes[attr_text]["icon"]);
								else
								Attribute[number_of_opened_AttributeEditors*100+i]:addItem(attr_text);
								end

			--Attribute[i]:addItem(attr_text); 
			--print(attr_text)
			else
				if("Datum"==object_attributes[curr_type]["attr"..i]) then
				Attribute[number_of_opened_AttributeEditors*100+i]:addItem(date_stamp())
				else
				Attribute[number_of_opened_AttributeEditors*100+i]:addItem("---")
				end
			end --if(attr_text)

				if("Datum"==object_attributes[curr_type]["attr"..i]) then
				Attribute[number_of_opened_AttributeEditors*100+i]:addItem(date_stamp());
				else
						if("Type (CARA)"==object_attributes[curr_type]["attr"..i]) then
							local sptypes=cara:getSpectrumTypes()
								for key,value in pairs(sptypes) do
									Attribute[number_of_opened_AttributeEditors*100+i]:addItem(key);
								end
						else
							for key,value in pairs(extract_attributes_named(object_attributes[curr_type]["attr"..i])) do 
								if(object_attributes[value]) then
								Attribute[number_of_opened_AttributeEditors*100+i]:addItem(value,object_attributes[value]["icon"]);
								else
								Attribute[number_of_opened_AttributeEditors*100+i]:addItem(value);
								end
							end --for key
						end --if("Type (CARA)"
				end --if("Datum
		if(i>0) then Attribute[number_of_opened_AttributeEditors*100+i]:setEditable(true); end;
		Attribute[number_of_opened_AttributeEditors*100+i]:show();
-- END editable field
-- END BUILD ITEM 
end
end --if(object_attributes[curr_type]

	Attribute_body[number_of_opened_AttributeEditors]=create_body_AttrEdit(at_main_window_main_frame[number_of_opened_AttributeEditors],at_numb_of_attr,at_main_szx,at_main_szy,at_entry_szy);
at_main_display_window[number_of_opened_AttributeEditors]:getData().attr_body=Attribute_body[number_of_opened_AttributeEditors]
	local attr_body_text=curr_record:getAttr(object_attributes[curr_type]["attr99"])
	if (attr_body_text) then Attribute_body[number_of_opened_AttributeEditors]:setText(attr_body_text); end
	Attribute_body[number_of_opened_AttributeEditors]:show();


attr_window_menu_bar[number_of_opened_AttributeEditors]=gui.createWidget(at_main_display_window[number_of_opened_AttributeEditors]);
	attr_window_menu_bar[number_of_opened_AttributeEditors]:move(0,0);
    attr_window_menu_bar[number_of_opened_AttributeEditors]:resize(at_main_szx,at_bar_w);
	attr_window_menu_bar[number_of_opened_AttributeEditors]:setBgColor("light grey");
	attr_window_menu_bar[number_of_opened_AttributeEditors]:show();

		attr_file_menu_button1[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
		attr_file_menu_button1[number_of_opened_AttributeEditors]:getData().cr=curr_record
		attr_file_menu_button1[number_of_opened_AttributeEditors]:resize(100,at_bar_w-4);
		attr_file_menu_button1[number_of_opened_AttributeEditors]:move(2+2+push_button_w,2);
		attr_file_menu_button1[number_of_opened_AttributeEditors]:setBgColor("green");
		attr_file_menu_button1[number_of_opened_AttributeEditors]:setText("Open URL");
		attr_file_menu_button1[number_of_opened_AttributeEditors]:show()
		attr_file_menu_button1[number_of_opened_AttributeEditors]:setCallback(gui.event.Clicked,
		function(self)
			local expm=self:getData().cr:getAttr("URL reference")
			open_in_browser(expm)
		end);



if(curr_type=="Macro") then

		attr_file_menu_button2[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
		attr_file_menu_button2[number_of_opened_AttributeEditors]:getData().cr=curr_record
		attr_file_menu_button2[number_of_opened_AttributeEditors]:resize(100,at_bar_w-4);
		attr_file_menu_button2[number_of_opened_AttributeEditors]:move(2+2+push_button_w+100+2,2);
		attr_file_menu_button2[number_of_opened_AttributeEditors]:setBgColor("red");
		attr_file_menu_button2[number_of_opened_AttributeEditors]:setText("Calculate Macro");
		attr_file_menu_button2[number_of_opened_AttributeEditors]:show()
		attr_file_menu_button2[number_of_opened_AttributeEditors]:setCallback(gui.event.Clicked,
		function(self)
			--print("run "..self:getData().cr:getAttr("Body"))
			execute_by_type_name("Spectrometer", get_cur_spectrometer())
			execute_by_type_name("Sample", get_cur_sample())
				local chunk,errmsg=loadstring(self:getData().cr:getAttr("Body"));
				if(chunk) then
				assert(loadstring(self:getData().cr:getAttr("Body")))()
				print("Executed: Macro")
				else
				print("Error: "..errmsg)
				answ=dlg.getSymbol("Error in compilation!",errmsg,"continue")
				end

			if(exp_environment_afterGetprosol) then
				ExportMacro(exp_environment, exp_environment_afterGetprosol)
				else 
				exp_environment_afterGetprosol={}
				ExportMacro(exp_environment, exp_environment_afterGetprosol)
			end--if(exp_environment an


		end);




		attr_file_menu_button3[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
		attr_file_menu_button3[number_of_opened_AttributeEditors]:getData().cr=curr_record
		attr_file_menu_button3[number_of_opened_AttributeEditors]:resize(100,at_bar_w-4);
		attr_file_menu_button3[number_of_opened_AttributeEditors]:move(2+2+push_button_w+200+4,2);
		attr_file_menu_button3[number_of_opened_AttributeEditors]:setBgColor("blue");
		attr_file_menu_button3[number_of_opened_AttributeEditors]:setText("CARA Pathway");
		attr_file_menu_button3[number_of_opened_AttributeEditors]:show()
		attr_file_menu_button3[number_of_opened_AttributeEditors]:setCallback(gui.event.Clicked,
		function(self)
			local expm=self:getData().cr:getAttr(object_attributes[curr_type]["attr7"])
			print("CARA Pathway for \"ALA\": "..expm);
			local nmr = spec.createExperiment(cara:getSpectrumType( expm ),cara:getResidueType( "ALA" ),cara:getResidueType( "ALA" ),cara:getResidueType( "ALA" ),"N","C" )
			if(nmr) then
			print( nmr:toString() )	
			add_string_to_body_of_currentsettings("CARA Pathway for \"ALA\": \n1 Experiment: \""..expm.."\"\n--Pathway :\n"..nmr:toString())
			show_currentsettings() 
			end --if(nmr) then
		end);
		
		
		attr_file_menu_button4[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:getData().cr=curr_record
		attr_file_menu_button4[number_of_opened_AttributeEditors]:resize(100,at_bar_w-4);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:move(2+2+push_button_w+300+6,2);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setBgColor("yellow");
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setText("To Spinach");
		attr_file_menu_button4[number_of_opened_AttributeEditors]:show()
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setCallback(gui.event.Clicked,
		function(self)
			--print("run "..self:getData().cr:getAttr("Body")) 
			To_Spinach();

		end);
	
attr_file_menu_button4[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:getData().cr=curr_record
		attr_file_menu_button4[number_of_opened_AttributeEditors]:resize(100,at_bar_w-4);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:move(2+2+push_button_w+400+8,2);
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setBgColor("green");
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setText("Predict S/N");
		attr_file_menu_button4[number_of_opened_AttributeEditors]:show()
		attr_file_menu_button4[number_of_opened_AttributeEditors]:setCallback(gui.event.Clicked,
		function(self)
			--print("run "..self:getData().cr:getAttr("Body")) 
			Predict_SN(self:getData().cr:getAttr("SP Measures"));

		end);
		
	

end --if(curr_type=="Macro")


	attr_file_menu_button[number_of_opened_AttributeEditors]=gui.createPushButton(attr_window_menu_bar[number_of_opened_AttributeEditors]);
	attr_file_menu_button[number_of_opened_AttributeEditors]:resize(push_button_w,at_bar_w-4);
	attr_file_menu_button[number_of_opened_AttributeEditors]:move(2,2);
	attr_file_menu_button[number_of_opened_AttributeEditors]:setBgColor("light grey");
--	attr_file_menu_button[number_of_opened_AttributeEditors]:setFlat(true);
	attr_file_menu_button[number_of_opened_AttributeEditors]:setText("File");
 --	attr_file_menu_button[number_of_opened_AttributeEditors]:setFont(base_font,base_font_size,0,0);
	attr_window_file_menu=gui.createPopupMenu(at_main_display_window[number_of_opened_AttributeEditors]);
	
		attr_window_file_menu:getData().attr_body=Attribute_body[number_of_opened_AttributeEditors] 
		attr_window_file_menu:getData().curr_type=curr_type
		attr_window_file_menu:getData().curr_record=curr_record
--			for i = 0, 20 do  
	--		if(object_attributes[curr_type]["attr"..i]) then
				attr_window_file_menu:getData().attr=Attribute
	--		end end	
	
	attr_file_menu_button[number_of_opened_AttributeEditors]:setPopup(attr_window_file_menu);
	attr_file_menu_button[number_of_opened_AttributeEditors]:show();
	
	attr_window_file_menu:insertItem("close",0,0);
	attr_window_file_menu:setCallback(gui.event.Showing,
		function(self,menu_id)
			self:clear();
			 
				self:insertItem("Save in Repository",1,1);
				self:insertItem("Export as text file",2,2);
				self:insertItem("Import as text file",3,3);
				self:insertSeparator();
				self:insertItem("Check syntax",5,5);
				self:insertSeparator();
				self:insertItem("Create Records from pasted PHPBB3",7,7);
		end); --function(self,


	attr_window_file_menu:setCallback(gui.event.Activated,
		function(self,menu_id)
			
			if(menu_id==7)then 
			local txtpasted=self:getData().attr_body:getText()
			parseRecordsFromPHPBB3(txtpasted)
			end    --if(menu_id==7  --parse phpbb3
		
			if(menu_id==5)then
			local chunk,errmsg=loadstring (self:getData().attr_body:getText());
				if(chunk) then
				assert(loadstring(self:getData().attr_body:getText()))()
				--print("Executed")
				answ=dlg.getSymbol("Results of checking","Seems OK","continue")
				else
				print("Error: "..errmsg)
				answ=dlg.getSymbol("Error in compilation!",errmsg,"continue")
				end
			end    --if(menu_id==100
			if(menu_id==1)then --Update
			for i = 1, 20 do  
			if(object_attributes[self:getData().curr_type]["attr"..i]) then
				--print(self:getData().attr[number_of_opened_AttributeEditors*100+i]:getCurrentText())
				self:getData().curr_record:setAttr(object_attributes[self:getData().curr_type]["attr"..i],self:getData().attr[number_of_opened_AttributeEditors*100+i]:getCurrentText())
			end
			end --for i = 1, 20 
			self:getData().curr_record:setAttr(object_attributes[self:getData().curr_type]["attr99"],self:getData().attr_body:getText())
			answ=dlg.getSymbol("Updating repository","Repository Updated","continue")
			end    --if(menu_id==1
			
			if(menu_id==2)then 
			dlg.setCurrentDir(get_nmr_directory()) 
			local FileOut = dlg.getSaveFileName( "Select output file", "*.*" )
			outfile = io.output( FileOut)
			outfile:write(self:getData().attr_body:getText()) 
			outfile:close()
			print("Exported as file: "..FileOut)				 
			end    --if(menu_id==2  --Save as
			
			if(menu_id==3)then
			dlg.setCurrentDir(get_nmr_directory()) 
			local FileIn = dlg.getOpenFileName( "Select file", "*.*" )
			local accumulator=""
			for line in io.lines(FileIn) do
				if(line) then accumulator=accumulator..line.."\n" end
			end
			local tmpss=accumulator
			self:getData().attr_body:setText(accumulator);
			self:getData().attr_body:show()			
 			print("Imported file: "..FileIn)				 
			end    --if(menu_id==3  --Save as
			
			
		end); --function(self,


end --function AttributeEditor

function text_between_onesymboltags(search_text, pattern) --pattern: %bxy, e.g. %b()
if(search_text==nil or pattern==nil) then return nil,nil end
local tag1posB,tag1posE=string.find(search_text,pattern)
if(tag1posB and tag1posE) then
				local txtbetween=string.sub(search_text,tag1posB+1,tag1posE-1)
				local txtoutside=string.sub(search_text,1,tag1posB-1)..string.sub(search_text,tag1posE+1,-1)
				return txtbetween,txtoutside
end --if(tag1posB and tag1posE) 
return nil,nil
end --function text_between_tags

function remove_bruker_comments(search_text) --pattern: %bxy, e.g. %b()
if(search_text==nil) then return nil,nil end
local tag1posB,tag1posE=string.find(search_text,"%b;\n")
if(tag1posB and tag1posE) then
				local txtbetween=string.sub(search_text,tag1posB+1,tag1posE-1)
				local txtoutside=string.sub(search_text,1,tag1posB-1)..string.sub(search_text,tag1posE,-1)
				return txtbetween,txtoutside
end --if(tag1posB and tag1posE) 
return nil,nil
end --function remove_bruker_comments

function To_Spinach()

			execute_by_type_name("Spectrometer", get_cur_spectrometer())
			execute_by_type_name("Sample", get_cur_sample())
			execute_by_type_name("Macro", get_cur_macro())
			print("PP: "..exp_environment["pulprog"])
			local pprog= retrive_by_type_name("Pulse Program", exp_environment["pulprog"])
			local txxtinside,txxtoutside,txxtremain,accu
			txxtoutside=pprog
for i = 0, 500 do
	txxtremain=txxtoutside
	txxtinside,txxtoutside=remove_bruker_comments(txxtremain)
if(txxtremain) then accu=txxtremain end
end --for i = 0
			--print(accu)


-- GET #define TABLE
def = {}
for k, v in string.gfind(accu, "#define%s*([%w_]+)%s*([%*%s%w:]+)\n") do
def[k] = v
end
for key, value in pairs( def ) do
print(key.." defined as __"..value.."__")
end
-- GET "calculus" TABLE
calc = {}
for k, v in string.gfind(accu, "\"%s*([%w_]+)%s*=%s*([%.%-%+%*%s%w:/%(%)]+)\"") do
--resolve explicite delays in calculus
	for dl in string.gfind(v, "(%d+)u") do
	v,nrt=string.gsub(v,"(%d+)u","%1*1e-6");
	end --if
	for dl in string.gfind(v, "(%d+)m") do
	v,nrt=string.gsub(v,"(%d+)m","%1*1e-3");
	end --if
	for dl,dl1 in string.gfind(v, "(%d+).(%d+)m") do
	v,nrt=string.gsub(v,"(%d+).(%d+)mm","%1.%2*1e-3");
	end --if
	for dl in string.gfind(v, "p(%d+)") do
	v,nrt=string.gsub(v,"p(%d+)","v.p%1");
	end --if
	for dl in string.gfind(v, "d(%d+)") do
	v,nrt=string.gsub(v,"d(%d+)","v.d%1");
	end --if
	for dl in string.gfind(v, "in(%d+)") do
	v,nrt=string.gsub(v,"in(%d+)","v.in%1");
	end --if 
	for dl in string.gfind(v, "cnst(%d+)") do
	v,nrt=string.gsub(v,"cnst(%d+)","v.cnst%1");
	end --if 
	
calc[k] = v

end
for key, value in pairs( calc ) do
print(key.." calculated as __"..calc[key].."__")
end



--print(accu)
-- GET all non empty lines TABLE
chrs = {}
i=0
for k in string.gfind(accu, "(.)") do
chrs[i] = k
i=i+1
end
i_max=i


lns = {}
j=0
lns[0]="";
for i = 0, i_max-1 do
--print(i.." ### "..chrs[i])
lns[j]=lns[j]..chrs[i]
	if(chrs[i]=="\n") then 
		if(string.find(lns[j],"^%s*\n$") or
		string.find(lns[j],"exit") or
		--string.find(lns[j],"define delay") or 
		string.find(lns[j],"#include") or
		string.find(lns[j],"prosol") or
		string.find(lns[j],"aqseq") or
		string.find(lns[j]," ze") or
		string.find(lns[j],"#define") or
		string.find(lns[j],"\"")	
		
		) then lns[j]=""
		else
		j=j+1
		end
    lns[j]=""	
	end
end
j_max=j
--print(j_max)


-- GET Phase TABLE
pht = {}
for j = 0, j_max-1 do
rst,nrt=string.gsub(lns[j],"\n","");
rst,nrt=string.gsub(rst,"ph(%d+)%s*=","ph%1=90*[");
if(nrt>0) then pht[rst] = rst.."];"; end

rst,nrt=string.gsub(lns[j],"\n","");
rst,nrt=string.gsub(rst,"ph(%d+)%s*=%((%d+)%)","ph%1=%2*[");
if(nrt>0) then pht[rst] = rst.."];"; end

end

phclc = {}
j=0
phclc[j]="\n%% Phase Table";
for key, value in pairs( pht ) do
j=j+1;
phclc[j]=value;
end

for key, value in pairs( calc ) do
j=j+1;
phclc[j]=key.." = "..value..";\n";
end
j_max_ph=j;



-- GET define delay TABLE
defdel = {}
for j = 0, j_max-1 do
rst,nrt=string.gsub(lns[j],"\n","");
rst,nrt=string.gsub(rst,"define delay ","");
if(nrt>0) then defdel[rst] = rst; end
end
--define extra delays
--defdel["DELTA"] = "DELTA";
defdel["DELTA1"] = "DELTA1";
defdel["DELTA2"] = "DELTA2";
defdel["DELTA3"] = "DELTA3";
defdel["DELTA4"] = "DELTA4";

for key, value in pairs( defdel ) do
print(key.." is 'define delay'  as __"..value.."__")
end


------------START with CONVERSION
orig_lns={}
for j = 0, j_max-1 do orig_lns[j]=lns[j]; end --for j = 0, j_max-1
print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
print("chann1='1H';")
print("chann2='13C';")
print("chann3='15N';")
print("chann4='2H';")
--set power calibartion for all 4 channels
p90={}; pl90={}
p90[1]=spectrometer[now].calibration_pulse90_f1; pl90[1]=spectrometer[now].calibration_power_db_f1;
p90[2]=spectrometer[now].calibration_pulse90_f2; pl90[2]=spectrometer[now].calibration_power_db_f2;
p90[3]=spectrometer[now].calibration_pulse90_f3; pl90[3]=spectrometer[now].calibration_power_db_f3;
p90[4]=spectrometer[now].calibration_pulse90_f4; pl90[4]=spectrometer[now].calibration_power_db_f4;



--resolve #define statements
for j = 0, j_max-1 do
	for key, value in pairs( def ) do
	lns[j],nrt=string.gsub(lns[j],key,value);
	end--for key, value
end --for j = 0, j_max-1

--resolve define delay statements
for j = 0, j_max-1 do
	for key, value in pairs( defdel ) do
	lns[j],nrt=string.gsub(lns[j],key,"[rho,pp]=delay_kope(spinsys, rho,pp, v."..key.."); ");
	end--for key, value
end --for j = 0, j_max-1

--resolve power statements
for j = 0, j_max-1 do
	for pl, ch in string.gfind(lns[j], "%s*pl(%d+)%s*:f(%d)") do
		lns[j],nrt=string.gsub(lns[j],"%s*pl(%d+)%s*:f(%d)","pp=set_power_kope(v.pl%1,pp,  "..ch..","..p90[tonumber(ch)]..","..pl90[tonumber(ch)]..");");
	end --for p, ph, chend
end --for j = 0, j_max-1

--resolve gradient p23:gp3 statements
for j = 0, j_max-1 do
	for p, gp in string.gfind(lns[j], "%s*p(%d+)%s*:gp(%d+)") do
	lns[j],nrt=string.gsub(lns[j],"%s*p(%d+)%s*:gp(%d+)"," [rho,pp]=delay_kope(spinsys, rho,pp, v.p"..p..");");
	end --for p, ph, chend
end --for j = 0, j_max-1

--resolve cpd, cpds, do
for j = 0, j_max-1 do
    -- cpds4:f4
	for cpd, ch in string.gfind(lns[j], "%s*cpds(%d+)%s*:f(%d+)") do
	lns[j],nrt=string.gsub(lns[j],"%s*cpds(%d+)%s*:f(%d+)","pp.cpd_on("..ch..",1)=1; pp.cpd_offset("..ch..",1)=0.0;");
--cpd_on(1,1)=1; cpd_offset(1,1)=0.0;
end --for p, ph, chend
	for cpd, ch in string.gfind(lns[j], "%s*cpd(%d+)%s*:f(%d+)") do
	lns[j],nrt=string.gsub(lns[j],"%s*cpd(%d+)%s*:f(%d+)","pp.cpd_on("..ch..",1)=1; pp.cpd_offset("..ch..",1)=0.0;");
	end --for p, ph, chend
    -- do:f4
	for ch in string.gfind(lns[j], "%s*do:f(%d+)") do
	lns[j],nrt=string.gsub(lns[j],"%s*do:f(%d+)","pp.cpd_on("..ch..",1)=0;");
	--cpd_on(1,1)=0;
	end --for p, ph, chend

end --for j=


--resolve explicit delays statements -- 10u, 10m, 10s
for j = 0, j_max-1 do
	for dl in string.gfind(lns[j], "(%d+)u") do
		if(tonumber(dl)>0.1) then      -- cutoff for executed delays, currently remoived
	lns[j],nrt=string.gsub(lns[j],"(%d+)u"," [rho,pp]=delay_kope(spinsys, rho,pp, %1*1e-06); ");
		else
		lns[j],nrt=string.gsub(lns[j],"(%d+)u"," ");
		end --if
	end --for p, ph, chend
	
	for dl in string.gfind(lns[j], "(%d+)m") do
	lns[j],nrt=string.gsub(lns[j],"(%d+)m"," [rho,pp]=delay_kope(spinsys, rho,pp, %1*1e-3); ");
	end --for p, ph, chend
	
	for dl in string.gfind(lns[j], "(%d+)s") do
	lns[j],nrt=string.gsub(lns[j],"(%d+)s"," [rho,pp]=delay_kope(spinsys, rho,pp, %1*1); ");
	end --for p, ph, chend

	for dl in string.gfind(lns[j], "d(%d+)") do
	lns[j],nrt=string.gsub(lns[j],"d(%d+)"," [rho,pp]=delay_kope(spinsys, rho,pp, v.d%1); ");
	end --for p, ph, chend


end --for j = 0, j_max-1


------------ pulse structures
for j = 0, j_max-1 do
--print(j.." ### "..lns[j])
	onepulse = {}
	--strtmp="   (p1 ph20):f1 "
	for p, ph, ch in string.gfind(lns[j], "%(%s*p(%d+)%s*ph(%d+)%s*%):f(%d)") do
	lns[j],nrt=string.gsub(lns[j],"%(%s*p(%d+)%s*ph(%d+)%s*%):f(%d)","[rho,pp]=pulse_kope(spinsys, rho,pp,v.p%1, v.ph%2,k, %3);");
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend
	
	
	--strtmp="  (p1*300 ph20):f1 "
	for p, mult, ph, ch in string.gfind(lns[j], "%(%s*p(%d+)%*(%d*%.*%d*)%s*ph(%d+)%s*%):f(%d)") do
	onepulse[j] = "[rho,pp]=pulse_kope(spinsys, rho,pp,v.p"..p.."*"..mult..", v.ph"..ph..",k, "..ch..");";
	lns[j],nrt=string.gsub(lns[j],"%(%s*p(%d+)%*(%d*%.*%d*)%s*ph(%d+)%s*%):f(%d)",onepulse[j]);
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend


	--strtmp="  (p1:sp1 ph20):f1 "
	pttrn="%(%s*p(%d+):sp(%d+)%s*ph(%d+)%s*%):f(%d)"
	for p, sp, ph, ch in string.gfind(lns[j], pttrn) do
	onepulse[j] = "[rho,pp]=pulse_shaped_kope(spinsys, rho,pp,v.p"..p..", v.sp"..sp..",v.spoff"..sp..", v.spnam"..sp..", v.ph"..ph..",k, "..ch..","..p90[tonumber(ch)]..","..pl90[tonumber(ch)]..", compress_shape);";
	lns[j],nrt=string.gsub(lns[j],pttrn,onepulse[j]);
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend

--strtmp="  (p1:sp1 ph20:r):f1 "
	pttrn="%(%s*p(%d+):sp(%d+)%s*ph(%d+):r%s*%):f(%d)"
	for p, sp, ph, ch in string.gfind(lns[j], pttrn) do
	onepulse[j] = "[rho,pp]=pulse_shaped_kope(spinsys, rho,pp,v.p"..p..", v.sp"..sp..",v.spoff"..sp..", v.spnam"..sp..", v.ph"..ph.."+ v.phcor"..ph..",k, "..ch..","..p90[tonumber(ch)]..","..pl90[tonumber(ch)]..", compress_shape);";
	lns[j],nrt=string.gsub(lns[j],pttrn,onepulse[j]);
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend


	--strtmp="   p1 ph20 "
	pttrn="%s*p(%d+)%s*ph(%d+)%s*"
	for p, ph in string.gfind(lns[j], pttrn) do
	lns[j],nrt=string.gsub(lns[j],pttrn,"[rho,pp]=pulse_kope(spinsys, rho,pp,v.p%1, v.ph%2,k, channXXX);");
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend

	--receiver
	--strtmp="   go=2 ph31 "
	pttrn="go%s*=%s*(%d+)%s*ph(%d+)";
	for p, ph in string.gfind(lns[j], pttrn) do
	onepulse[j] = "[rho,pp]=receiver_kope(spinsys, rho,pp, v.ph"..ph..",k, "..p..");";
	lns[j],nrt=string.gsub(lns[j],pttrn,onepulse[j]);
	--print("(*line "..j.." *) "..onepulse[j])
	end --for p, ph, chend

	
end --for j = 0, j_m
nlns={}; -- attempt to return carrage return at the line end
for j = 0, j_max-1 do
--    print("%% --"..orig_lns[j]);
nlns[j]=string.sub(lns[j],1,-2);
--print(nlns[j]);

--print(lns[j].."\n");
end --for j = 0, j_max-1
ExportMacroSSR(exp_environment,phclc, j_max_ph,nlns, j_max)


end --function To_Spinach()

function Predict_SN(SP_measures)

			execute_by_type_name("Spectrometer", get_cur_spectrometer())
			execute_by_type_name("Sample", get_cur_sample())
			execute_by_type_name("Macro", get_cur_macro())
			print("PP: "..exp_environment["pulprog"])
			local pprog= retrive_by_type_name("Pulse Program", exp_environment["pulprog"])

local accumulator="Spinach performance measures\nInput data:\n\n"
			local line ="";
			line=SP_measures;
				if(line) then accumulator=accumulator..line.."\n" end
			
			
			
			-- get sample info
			local labeling_pattern="";
			local sample_tauc="";
			local sample_snD="";
            local p = cara:getProject("NMRgenerator")
			local r = p:getAttr("Sample")

			values = r:getAttrs()
				for key,value in pairs(values) do
					labeling_pattern=value:getAttr(object_attributes["Sample"]["attr4"]);
					sample_tauc=value:getAttr(object_attributes["Sample"]["attr5"]);
					sample_snD=value:getAttr(object_attributes["Sample"]["attr7"]);  
				end --for key

			
			if(labeling_pattern) then accumulator=accumulator..labeling_pattern.."\n" 
			    else   accumulator=accumulator.." \nlabeling pattern Not Set in Sample\n" end
			if(sample_tauc) then accumulator=accumulator..sample_tauc.."\n" 
				else   accumulator=accumulator.." \nsample tauc Not Set in Sample\n" end
			if(sample_snD) then accumulator=accumulator..sample_snD.."\n" 
				else   accumulator=accumulator.." \nsample S/N in 1D Not Set in Sample\n" end
			
			
			 
			
			add_string_to_body_of_currentsettings(accumulator)
			show_currentsettings()



end --function Predict_SN()

function BufferGetPpm( buffer, index )
	StartPpm,EndPpm = buffer:getPpmRange( 1 )
	PpmRange = EndPpm - StartPpm
	SampleCount = buffer:getSampleCount( 1 )
	PpmStep = PpmRange / (SampleCount - 1)
	PpmValue = StartPpm + index * PpmStep
	return PpmValue
end--function BufferGetPpm( buff



function MeanInPpmRange(buffer, ppmStart1, ppmEnd1) --
--local StartPpm,EndPpm = buffer:getPpmRange( 1 )
local averg =0
local SampleCount = buffer:getSampleCount( 1 )
local tmpppm
local j=0
local contPnts
local pnts={}
local cumul=0

--calc average
for i=1,SampleCount do
        tmpppm=BufferGetPpm( buffer, i )
		--print(string.format( " AAA %7.2f %7.2f %7.2f ",ppmStart1, ppmEnd1, tmpppm))
		if(ppmStart1>=tmpppm and tmpppm>= ppmEnd1) then
			j=j+1
			cumul = cumul +buffer:getAt( i )
--print(string.format( "%7.2f %7.2f %7.2f %7.2f",ppmStart1, ppmEnd1, tmpppm, buffer:getAt( i )))			
		end		
end--for i=1,Sampl
contPnts=j
averg=cumul/contPnts
return averg
end --function MeanInPpmRange(buffer, ppmStart, ppmEnd)



function RMSDinPpmRange(buffer, ppmStart, ppmEnd)
--local StartPpm,EndPpm = buffer:getPpmRange( 1 )
local averg =0
local rmsd =0
local SampleCount = buffer:getSampleCount( 1 )
local tmpppm
local j=0
local contPnts
local pnts={}
local cumul=0

--calc average
for i=1,SampleCount do
        tmpppm=BufferGetPpm( buffer, i )
		if(ppmStart>=tmpppm and tmpppm>= ppmEnd) then
			j=j+1
			pnts[j]=buffer:getAt( i )
			cumul = cumul + pnts[j]
		end		
end--for i=1,Sampl
contPnts=j
averg=cumul/contPnts
--calc RMSD
cumul=0.0
for i=1,contPnts do
	cumul=cumul+(pnts[i]-averg)*(pnts[i]-averg)
end--for i=1
rmsd = math.sqrt(cumul)/contPnts
return rmsd*10  --NOISE peak - to -peak RMSD-based estimate
end --function RMSDinPpmRange(buffer, ppmStart, ppmEnd)

function Draw1Dspectrum(spectrum_name)
local t={}

	t.P = cara:getProject( "NMRgenerator" )
	local SpectrumNames = {}
	local SpectrumIds = {}
	i = 0
	for id,spectrum in pairs( t.P:getSpectra() ) do
		if spectrum:getDimCount() == 1 then
			-- spectrum is a 1D
			i = i + 1
			SpectrumIds[ i ] = spectrum:getId()
			SpectrumNames[ i ] = spectrum:getId()..":"..spectrum:getName()
		end --if
	end --for id,s
	t.SpectrumName = spectrum_name;
	for i = 1,table.getn( SpectrumNames ) do
		if SpectrumNames[ i ] == t.SpectrumName then
			t.Spectrum = t.P:getSpectrum( SpectrumIds[ i ] )
			print("Draw spectrum ID "..SpectrumIds[ i ].. " named: "..SpectrumNames[ i ])
		end --if SpectrumN
	end-- for i = 1,table
	if(t.Spectrum) then
		t.startPpmDim,t.endPpmDim = t.Spectrum:getPpmRange( 1 )
		-- b. get the SliceBuffer (Class Buffer)
		t.SliceBuffer = t.Spectrum:getSlicePpm(1,t.startPpmDim,t.endPpmDim)
		t.SliceBuffer2 = t.Spectrum:getSlicePpm(1,t.startPpmDim,6.0)

	c = dlg.createSlice( 1, t.SliceBuffer )
	c2 = dlg.createSlice( 1, t.SliceBuffer2 )
	c2:setColor("red")
	cv = dlg.createCanvas()
	--cv:resize(200,200);
	cv:setSize(500,500)
	cv:setCaption(spectrum_name)
	cv:setBgColor("black")
	cv:begin()
	cv:setPen( "blue", 1 )
	cv:drawRect( 5, 5, 500, 500 )
	cv:drawSlice( c, 5, 5, 500, 500 )
	cv:drawSlice( c2, 5, 5, 500*(t.startPpmDim-6.0)/(t.startPpmDim-t.endPpmDim), 430 )
	cv:commit()

-- Report to terminal
		for i=1,t.SliceBuffer:getSampleCount(1) do
        formattedPpm = string.format("%7.4f", BufferGetPpm( t.SliceBuffer, i ) )
		formattedAmplitude = string.format( "%7.2f", t.SliceBuffer:getAt( i ) )
        Line = formattedPpm.." , "..formattedAmplitude
			print( Line )
		end --for i=1,t.SliceBuffer:getSampleCount(1) 

	else
		local tresp = dlg.getSymbol("No 1D spectrum found",spectrum_name, "Got it" ,"Ok" )
	end --if(t.Spectrum)





end --function Draw1Dspectrum(spectrum_name)

function Multiple1Doverlay(selected_OIDs)
-- Create Object Table for Script
local t={}
-- Create objects
t.specnum={}
t.color={"green","red","yellow","cyan","blue","white","grey","magenta"} --if beyound that - grey
--t.color={"green","red"}
t.i=0
t.spectra={}
t.names={}
t.spectrum={}
t.cb={}
t.colorbgd="black"
t.noiseboxPpmRange = {10.5,9.5}  --initial settings for noise box. Can be changed by cntrl-mouse-move


--Retreave all 1D names and IDs
	t.P = cara:getProject( "NMRgenerator" )
	local SpectrumNames = {}
	local SpectrumIds = {}
	local SpectraMaxN = 0
	i = 0
	for id,spectrum in pairs( t.P:getSpectra() ) do  --fill names in SpectrumNames[]
		if spectrum:getDimCount() == 1 then
			-- spectrum is a 1D
			i = i + 1
			SpectrumIds[ i ] = spectrum:getId()
			--SpectrumNames[ i ] = spectrum:getId()..":"..spectrum:getName()
			SpectrumNames[ i ] = spectrum:getName()
		end --if
	end --for id,s
	SpectraMaxN=i;
	
--	if(SpectraMaxN>0) then
--	any1Dspectra=true
--	else
--		local tresp = dlg.getSymbol("No 1D spectra found","in NMRgenerator", "Got it" ,"Ok" )
--	end --if(SpectrumNumb>0)


	j=0;
	for key,value in pairs(selected_OIDs) do --loop over all items
		for i=1,SpectraMaxN do
--print("Item OID to draw: "..key.." and the record is "..value) --this returns record's OID
--print(cara:getRecord(key))
--print("Item OID to draw: "..key.." and the record is "..value.." and the cara:getRecord(key) is "..cara:getRecord(key)) --this returns record's OID
		if(cara:getRecord(key)) then
			t.SpectrumName=cara:getRecord(key):getAttr("1D Spectrum"); --
			--							Draw1Dspectrum(t.SpectrumName)
			t.ExperimentName=cara:getRecord(key):getAttr("Macro Name"); 
			if(t.ExperimentName==nil) then
				t.ExperimentName=cara:getRecord(key):getAttr("Sample Name");
			end --if(t.ExperimentName==nil)
		else
			t.SpectrumName="---"
		end --if(key>0) then
				--print("Plot ExperimentName  "..t.ExperimentName)

			if SpectrumNames[ i ] == t.SpectrumName then
				j=j+1
				t.names[j]=t.ExperimentName
				t.spectra[j] = t.P:getSpectrum( SpectrumIds[ i ] )
				t.specnum[j]=SpectrumIds[ i ]
				--print("Plot spectrum ID "..SpectrumIds[ i ].. " named: "..SpectrumNames[ i ])
			end --if SpectrumN
		end --for i=1,SpectraMaxN do
	end --for key,value in pa
	SpectraMaxN=j;
	
for key,value in pairs(t.names) do
print("Plot spectrum from exp "..value)
end



-- The actual drawing function -----------------------------------------------------------------

function t.drawspec(imax, specnumlist, colors, namelist)

-- Initialize lots of stuff 
  w=gui.createWidget()
  w:setCaption("Viewer for multiple 1D NMR Spectra")
  w:setBgColor(t.colorbgd)
  w:show()
  w:getData().spec={}  --Spectrum from repository
  w:getData().color={} --color of ind Slices from colors
  w:getData().buf={}   --buffer from Spectrum
  w:getData().c={}     --dlg.createSlice from buffer
  w:getData().name={}  --experiment name to display

-- Define refresh buffer function

  function refresh(widget)
    for ii=1,imax do
      widget:getData().buf[ii]=w:getData().spec[ii]:getSlicePpm(1,w:getData().ppmmax1,w:getData().ppmmin1)
      widget:getData().c[ii]=dlg.createSlice(1,w:getData().buf[ii])	  
	  widget:getData().c[ii]:setColor(w:getData().color[ii])
    end
    widget:update()
  end -- refresh function

-- Get colors & spectra
	local globalppmmax=-1000
	local globalppmmin=1000
	local tmax,tmin	
  for ii=1,imax do
    if(colors[ii]==nil) then colors[ii]="grey" end
    w:getData(colors[ii]).color[ii]=colors[ii]  
    w:getData().spec[ii]=cara:getProject( "NMRgenerator" ):getSpectrum(specnumlist[ii])
	w:getData().name[ii]=namelist[ii]
	--get ppm range for all spectra
	tmax, tmin= w:getData().spec[ii]:getPpmRange(1)
	if(tmax>globalppmmax) then globalppmmax=tmax end --if
	if(tmin<globalppmmin) then globalppmmin=tmin end --if
  end

-- Determine max, min ppm
--  w:getData().ppmmax1,w:getData().ppmmin1=w:getData().spec[1]:getPpmRange(1)
	w:getData().ppmmax1=globalppmmax
	w:getData().ppmmin1=globalppmmin
	w:getData().globalppmmax=globalppmmax
	w:getData().globalppmmin=globalppmmin
	w:getData().noiseboxppmmax=t.noiseboxPpmRange[1]
	w:getData().noiseboxppmmin=t.noiseboxPpmRange[2]
	w:getData().globalnoiseboxppmmax=t.noiseboxPpmRange[1]
	w:getData().globalnoiseboxppmmin=t.noiseboxPpmRange[2]

refresh(w)

-- Draw and Redraw
  w:setCallback(gui.event.Paint,
    function (self, p)
       local width,height = self:getSize()
	   local ampl=0
	   local baseline=0
	   local rmsd=0
	   local sn =0
	for ii=1,imax do
        --p:drawContour( self:getData().c[ii],0,0,width,height)
		p:drawSlice( self:getData().c[ii],0,0,width,height)
		
		
		
		p:setPen(self:getData().color[ii],1)
		
		if(self:getData().XcursorPos) then
		    --print(string.format( "%7.2f",self:getData().XcursorPos)) 
			ampl = self:getData().buf[ii]:getAtPpm(self:getData().XcursorPos)
		else 
			ampl=0.0
		end
			baseline = MeanInPpmRange(self:getData().buf[ii], self:getData().noiseboxppmmax, self:getData().noiseboxppmmin)
			rmsd = RMSDinPpmRange(self:getData().buf[ii], self:getData().noiseboxppmmax, self:getData().noiseboxppmmin)
			sn = (ampl-baseline)/(rmsd+0.01) -- to aviod division by zero

		local otxt=self:getData().name[ii].." Ampl: "..string.format( "%7.2f",ampl).." BL: "..string.format( "%7.2f",baseline)
		otxt=otxt.." rmsd*10: "..string.format( "%7.2f",rmsd) --check the factor in function RMSDinPpmRange
		otxt=otxt.." SN: "..string.format( "%7.2f",sn)
		p:drawText( width*0.03,height*0.04+15*ii,otxt)
		--draw noiseboxes
		--p:setPen("white",1)
		p:setPen("blue",1)
		local xnb = (self:getData().ppmmax1-self:getData().noiseboxppmmax)/(self:getData().ppmmax1-self:getData().ppmmin1)
			xnb=xnb*width
		local mi,ma = self:getData().c[ii]:getMinMax()
		local ynb = (ma-baseline-rmsd/2)/(ma-mi)*height
		
		local wnb = (self:getData().noiseboxppmmax-self:getData().noiseboxppmmin)/(self:getData().ppmmax1-self:getData().ppmmin1)
			wnb=wnb*width+2
		local hnb = (rmsd)/(ma-mi)*height+2

		--print(string.format( "xnb %7.2f",xnb) ..string.format( " ynb %7.2f",ynb))
		--print(string.format( "wnb %7.2f",wnb) ..string.format( " hnb %7.2f",hnb)) 		
		--p:drawRect(xnb,ynb,wnb,hnb) --draws filled rect
		p:drawLine(xnb,ynb,xnb+wnb,ynb)
		p:drawLine(xnb,ynb+hnb,xnb+wnb,ynb+hnb)
		
	end --for ii=1,imax do


	   
       -- draw Cursor HERE
       --t.drawcursor(p, self:getData().buf[1], self:getData().XcursorPos, height)
       --t.drawcursor(p, self:getData().buf[1], self:getData().XcursorPos, width, height)
	    p:setPen("yellow",1)
		if(self:getData().XcursorPosPts) then 
			p:drawLine(self:getData().XcursorPosPts,0,self:getData().XcursorPosPts,height)
			p:drawText(width*0.03,height*0.04, "Cursor: "..string.format("%7.3f",self:getData().XcursorPos).. " ppm")	
		else 
			p:drawLine(width/2,0,width/2,height)
			p:drawText(width*0.03,height*0.04, "Cursor:     ppm")	

		end --if
	   p:setPen("white",1)
	   p:drawText(width*0.03,height*0.04-15, "Cntrl+Shift Mouse to zoom, Cntr Mouse to re-define noisebox (blue)")
    end ) -- end Draw and Redraw Callback
	
-- mouse actions
  w:setCallback(gui.event.MousePressed,
    function (self, x,y,left,mid,right,shift,ctrl,alt)
       local width,height = self:getSize()
       if ctrl==true and shift==true then   --zoom in spectra
        --self:getData().ppmmin1=self:getData().c[1].toPpm(self:getData().c[1],1,0,width,x)
        self:getData().XcursorPos=self:getData().ppmmax1-(self:getData().ppmmax1-self:getData().ppmmin1)*x/width 
        self:getData().XcursorPosPts=x 
		self:getData().ppmmax1tmp=self:getData().XcursorPos --define tmp ppmmax
         --print( "cntshfit Mpressed x="..string.format("%7.3f",self:getData().XcursorPos))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cntshfit Mpressed x="..string.format("%7.3f",self:getData().XcursorPosPts))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cntshfit Mpressed ppmmax1="..string.format("%7.3f",self:getData().ppmmax1))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )

 
		elseif ctrl==true and shift==false then  --new noisebox
         self:getData().XcursorPos=self:getData().ppmmax1-(self:getData().ppmmax1-self:getData().ppmmin1)*x/width 
        self:getData().XcursorPosPts=x 
		self:getData().noiseboxppmmaxtmp=self:getData().XcursorPos --define tmp ppmmax
		self:getData().noiseboxppmmax=self:getData().XcursorPos --define tmp ppmmax

		--print( "cnt Mpressed noiseboxppmmax="..string.format("%7.3f",self:getData().noiseboxppmmax))

         --print( "cnt Mpressed x="..string.format("%7.3f",self:getData().XcursorPos))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cnt Mpressed x="..string.format("%7.3f",self:getData().XcursorPosPts))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cnt Mpressed ppmmax1="..string.format("%7.3f",self:getData().ppmmax1))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )

		elseif ctrl==false and shift==false then
         self:getData().XcursorPos=self:getData().ppmmax1-(self:getData().ppmmax1-self:getData().ppmmin1)*x/width 
         self:getData().XcursorPosPts=x 
         --print( "x="..string.format("%7.3f",self:getData().XcursorPos))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "x="..string.format("%7.3f",self:getData().XcursorPosPts))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         self:update()
       end
    end ) -- end MousePressed Callback

  w:setCallback(gui.event.MouseReleased,
    function (self, x,y,left,mid,right,shift,ctrl,alt)
       local width,height = self:getSize()
       if ctrl==true and shift==true then
         --self:getData().ppmmax1=self:getData().c[1].toPpm(self:getData().c[1],1,0,width,x)
         self:getData().XcursorPos=self:getData().ppmmax1-(self:getData().ppmmax1-self:getData().ppmmin1)*x/width 
        self:getData().XcursorPosPts=x 
		self:getData().ppmmin1=self:getData().XcursorPos --define new ppmmin
         --print( "cntshfit Mreleased x="..string.format("%7.3f",self:getData().XcursorPos))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cntshfit Mreleased x="..string.format("%7.3f",self:getData().XcursorPosPts))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
         --print( "cntshfit Mreleased ppmmin1="..string.format("%7.3f",self:getData().ppmmin1))--.." / y="..string.format("%7.3f",self:getData().YcursorPos) )
  
         if self:getData().ppmmax1tmp<self:getData().ppmmin1 then --right to left mouse move
           self:getData().ppmmax1=self:getData().globalppmmax
           self:getData().ppmmin1=self:getData().globalppmmin
		   else
		   self:getData().ppmmax1=self:getData().ppmmax1tmp --left to right mouse move
         end 
--print( "new ppm maxmin="..string.format("%7.3f",self:getData().ppmmax1).. "  "..string.format("%7.3f",self:getData().ppmmin1))
	refresh(self)

       elseif ctrl==true and shift==false then
         self:getData().XcursorPos=self:getData().ppmmax1-(self:getData().ppmmax1-self:getData().ppmmin1)*x/width 
        self:getData().XcursorPosPts=x 
		self:getData().noiseboxppmmin=self:getData().XcursorPos --define new ppmmin
 
         if ((self:getData().noiseboxppmmaxtmp)<(self:getData().noiseboxppmmin)) then --right to left mouse move
           self:getData().noiseboxppmmax=self:getData().globalnoiseboxppmmax
           self:getData().noiseboxppmmin=self:getData().globalnoiseboxppmmin           
		   else --left to right mouse move
		   self:getData().noiseboxppmmax=self:getData().noiseboxppmmaxtmp
         end 
		 --print( "cnt Mreleased noiseboxppmmin="..string.format("%7.3f",self:getData().noiseboxppmmin))
		 --print( "cnt Mreleased noiseboxppmmax="..string.format("%7.3f",self:getData().noiseboxppmmax))

	refresh(self)
  
         self:update()

         refresh(self)

         --self:getData().CtrlClickStartX = nil
         --self:getData().CtrlClickStartY = nil
       end
    end ) -- end MouseReleased Callback

  w:update()
end -- function t.drawspec	




if(SpectraMaxN>0) then
	t.drawspec(SpectraMaxN, t.specnum, t.color, t.names)
else
local answ=dlg.getSymbol("No 1D to show","Got it!","continue");
end




end --function Multiple1Doverlay

function CreateCurrentSettingsAndAllComponents()
local curr_project=cara:getProject("NMRgenerator")
	if(curr_project==nil) then answ=dlg.getSymbol("Inconsistency in dataset","Project ".."NMRgenerator".." is not setup in repository "..record_OID,"continue");
	return
	end

--local found_attrs=curr_record:getAttrs()


local p = cara:getProject("NMRgenerator")
local r = p:getAttr("Current Settings")

local type = "Current Settings"
-- two level access to the actual info
-- This is for all types of objects

--<fld name='Current Settings' type='OID'>44</fld> ##In project
--...
--<obj oid='44'>                                   ##In database
--<fld name='45' type='OID'>45</fld>               ## this is relay to the database record 45
--</obj>
--<obj oid='45'>
--<fld name='Macro' type='String'>cosy_dqf_excitation_sculpting_15Ndecoupling</fld>
--<fld name='Pulse Program' type='String'>hncacbgp3d</fld>
--<fld name='Current Settings' type='String'>Datastation</fld>
--<fld name='Composite Pulse Decoupling' type='String'>garp</fld>
--<fld name='Wave Form' type='String'>Q3.1000</fld>
--<fld name='Type' type='String'>Current Settings</fld>
--<fld name='Datum' type='String'>11.20.07</fld>
--<fld name='Body' type='Memo'> 




if(p:getAttr(type)==nil) then
local macroAbove = cara:createRecord()
local macro = cara:createRecord()
local macroUp = cara:createRecord()
macro:setAttr(object_attributes[type]["attr0"],type)
macro:setAttr(object_attributes[type]["attr1"],"MyDatastation")
macro:setAttr(object_attributes[type]["attr2"],"MySample")
macro:setAttr(object_attributes[type]["attr3"],"MyExperiment")
macro:setAttr(object_attributes[type]["attr4"],"MyOutputMacro")
macro:setAttr(object_attributes[type]["attr5"],"/")
macro:setAttr(object_attributes[type]["attr6"],InternetBrowser)
macro:setAttr(object_attributes[type]["attr7"],2000)
macro:setAttr(object_attributes[type]["attr8"],5.2)
macro:setAttr(object_attributes[type]["attr9"],12)
macro:setAttr(object_attributes[type]["attr10"],"https://github.com/kpervushin/NMRgenerator-new/wiki")
macro:setAttr(object_attributes[type]["attr11"],0)
macroUp:setAttr(macro:getId(),macro) --second child in Project
p:setAttr(type,macroUp) --first child in Project
end --if(curr_project:getAttr(type)==nil)

--two level access
print("Created attrs in Current settings")
values=cara:getProject("NMRgenerator"):getAttr("Current Settings"):getAttrs()
for key,value in pairs(values) do
values1=value:getAttrs()
	for key,value1 in pairs(values1) do
	print("key = "..key.." value1= "..value1)
	end
end

--Create default Spectrometer
 p = cara:getProject("NMRgenerator")
 type="Spectrometer"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"MyDatastation")
 local s = "now=\"selected\";\n"
 s=s.."spectrometer ={[\"selected\"]={ \n"
 s=s.."proton_carrier_298k= 3282,  \n"
 s=s.."SR= 0,  \n"
 s=s.."calibration_power_db_f1= 5,  \n"
 s=s.."calibration_pulse90_f1=9, \n"
 s=s.."home_topspin=\"/opt/ts1.3/exp/stan/nmr/lists\"}}\n"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 

--Create default Sample
 p = cara:getProject("NMRgenerator")
 type="Sample"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"MySample")
 local s = "spectrum ={SR = 6.26}"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 

--Create default Macro
 p = cara:getProject("NMRgenerator")
 type="Macro"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"MyExperiment")
 local s = "exp_environment_afterGetprosol={p27=spectrometer[now].calibration_pulse90_f1,pl27=spectrometer[now].calibration_power_db_f1}\n"
 s=s.."exp_environment = {[\"pulprog\"]= \"Default.pp\",o1 = spectrometer[now].proton_carrier_298k, p1=spectrometer[now].calibration_pulse90_f1,pl1= spectrometer[now].calibration_power_db_f1}"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 

--Create default PP
 p = cara:getProject("NMRgenerator")
 type="Pulse Program"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"Default.pp")
 local s = "My exp"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 

--Create default 
 p = cara:getProject("NMRgenerator")
 type="Script"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"Default.scpt")
 local s = "My script"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 
--Create default 
 p = cara:getProject("NMRgenerator")
 type="Composite Pulse Decoupling"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"Default.cpd")
 local s = "My cpd"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 
--Create default 
 p = cara:getProject("NMRgenerator")
 type="Wave Form"
 if(p:getAttr(type)==nil) then
 macroAbove = cara:createRecord()
 macro = cara:createRecord()
 macroUp = cara:createRecord()
 macro:setAttr(object_attributes[type]["attr0"],type)
 macro:setAttr(object_attributes[type]["attr1"],"Default.wav")
 local s = "My wave"
 macro:setAttr(object_attributes[type]["attr99"],s)
 macroUp:setAttr(macro:getId(),macro) --second child in Project
 p:setAttr(type,macroUp) --first child in Project
 end 



end --function CreateCurrentSettingsAndAllComponents()



StartPage()
 




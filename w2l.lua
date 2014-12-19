winPath="C:/Dropbox/My CARA/NMRgenerator/Development/SPECTRA/"
linPath="/home/konstantin/NMRgenerator/SPECTRA/"

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


function convertWindows2LinuxSpecPathsInCara()
--attmpt to convert from Win to Lin and from Lin to Win
--local answ=dlg.getSymbol("Adjust *.cara", "Convert path to spectra", "Windows->Linux","Linux->Windows");
--print(answ)
local t={}
local FileIn = dlg.getOpenFileName( "Select file", "*.cara" )
local j=0
local nlines=0
local nsub=0

--Read *.cara and attemt Win to Lin conversion
print("Attempt Win to Lin conversion")
								if(FileIn) then 
									for line in io.lines(FileIn) do
									j=j+1
									t[j]=line --storage of lines
										if(string.find(line,winPath)) then
											line = string.gsub(line, winPath, linPath)
											nsub=nsub+1
											print(" From: "..t[j])
											print(" To  : "..line)
											t[j]=line
										end --if(string.fin
									end --for line
									nlines=j
								print(string.format("read lines: %d ",j).."in: "..FileIn)
								print("substituted: ", nsub)
								
								end --if(FileIn) then
								
if(nsub==0) then  --attempt Lin to Win conversion
print("Attempt Lin to Win conversion")
	for j=1, nlines do
										if(string.find(t[j],linPath)) then
											line = string.gsub(t[j], linPath, winPath)
											nsub=nsub+1
											print(" From: "..t[j])
											print(" To  : "..line)
											t[j]=line
										end --if(string.fin
	
	end --for

end --

if(nsub>0) then

	-- get output filename	
if(string.find(FileIn,".cara")) then
FileOut = string.gsub(FileIn, ".cara", "-1.cara")
end 
	
	
	local FileOut = dlg.getText("Enter the output filename", "", FileOut ) --return nil if Cancel
	--print(FileOut)
	if(FileOut) then
		outfile = io.output( FileOut)
		for j=1, nlines do
			outfile:write(t[j].."\n")
		end --for
		outfile:close()
		print("Exported as file: "..FileOut)
    else 
		local answ=dlg.getSymbol("Canceled writing", "", "Got it","hmm..");
	end--if(FileOut)
	
else--if(nsub>0) then
	local answ=dlg.getSymbol("No convertable path found in", FileIn, "Got it","hmm..");
end--if(nsub>0) then

end --convertWindows2LinuxSpecPathsInCara()

convertWindows2LinuxSpecPathsInCara()

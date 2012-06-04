-- fs_changelist.lua : execute the filesystem changelist file
-- 
-- typical usage: 
--  (a) $ lua -e "dstdir=\"<projdir>/export/dist\" dstdir=\"<builddir>\"" fs_changelist.lua 
--  (b) $ export TOP_BUILD_DIR=$(TOP_BUILD_DIR) 
--      $ export EXPORT_DIST_DIR=$(EXPORT_DIST_DIR) 
--      $ $(FAKEROOT) \
--			rpm --eval '%{lua: dofile("$(top_srcdir)/scripts/fs_changelist.lua")} ' 
--  (c) $ export CHANGELIST_CMND=export
--      $ export TOP_BUILD_DIR=/path/to/project/dir 
--      $ export EXPORT_DIST_DIR=/path/to/layer/dir
--		$ rpm --eval '%{lua: dofile("$(top_srcdir)/scripts/fs_changelist.lua")} ' 
--

local version,action,name,source,target,umode,uid,gid,major,minor
local srcfile, dstfile, changelist_line
local line_cnt=0
local versionNumber=0

-- debugging
local execute=true
local dbg_level=1


-- Command?
local command=fs
changelist_cmnd=os.getenv("CHANGELIST_CMND")
if (nil ~= changelist_cmnd) then
	command=changelist_cmnd
end

-- SRCDIR and DSTDIR from command line
if (nil == srcdir) then
	srcdir=os.getenv("TOP_BUILD_DIR")
end
if (nil == srcdir) then
	print("ERROR: You must specify the source file system directory")
	print("Usage: lua -e \"dstdir=\\\"<builddir>/export/dist\\\" srcdir=\\\"<builddir>\\\"\" fs_changelist.lua")
	return(1)
end
if (nil == dstdir) then
	dstdir=os.getenv("EXPORT_DIST_DIR")
end
if (nil == dstdir) then
	print("ERROR: You must specify the destination file system directory")
	print("Usage: lua -e \"dstdir=\\\"<builddir>/export/dist\\\" srcdir=\\\"<builddir>\\\"\" fs_changelist.lua")
	return(1)
end

-- if debug, display basic settings
if (1 <= dbg_level) then
	print("srcdir: " .. srcdir)
	print("dstdir: " .. dstdir)
	if (execute) then
		print("execute: true")
	else
		print("execute: false")
	end
end

-- dstdir= dstdir or "/opt/myTarget"	
-- srcdir= srcdir or ""	

-----------------------------------------------
-- basic subroutines
--

function errorMsg (msg)
	print("ERROR] ".. msg .. " Line:" .. line_cnt .. "\n")
end

function debugMsg (level,msg)
	if (level <= dbg_level) then
		print(msg .. ", Line:" .. line_cnt .. "\n")
	end
end

function printMsg (msg)
	print(msg .. ", Line:" .. line_cnt)
end

function do_execute(msg)
	if ((nil ~= msg) and (0 ~= string.len(msg))) then
		debugMsg(1,msg)
		if (execute) then
			Hnd, ErrStr = io.popen(msg,r)
			if ( ErrStr and string.len(ErrStr) ) then
				errorMsg(ErrStr)
			end
			if (Hnd) then
				Hnd:close()
			end
		end
	end	
end


-----------------------------------------------
-- action handlers
--

function do_version (entry)
	debugMsg(2,"do_verson:" )
	
	local version
	
	version=entry["version"]
	
	-- check for missing values
	if     (version == nil) then
		errorMsg("version: missing version")
		return
	end

	debugMsg(2,"do_version:" .. entry["version"])
	versionNumber=version
	
end

function do_addfile (entry)
	debugMsg(2,"do_addfile:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	source=entry["source"]
	umode =entry["umode"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	-- check for missing values
	if     (name == nil) then
		errorMsg("addfile: missing name")
		return
	elseif (source == nil) then
		errorMsg("addfile: missing source")
		return
	elseif (source == nil) then
		errorMsg("addfile: missing source")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_addfile:" .. entry["name"] .. "," .. entry["source"])
	do_execute("install -D " .. source .. " " .. name) 

	if (nil ~= umode) then
		debugMsg(2,"do_addfile:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_addfile:uid=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_addfile:gid=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

-- this version is for converting external file references into
-- "filesystem/fs" copies, and command becomes just "chmod"
function do_exportfile (entry)
	debugMsg(1,"do_exportfile:" .. entry["action"] .. "," .. entry["name"] .. "," .. entry["source"])
	
	name  =entry["name"]
	source=entry["source"]
	umode =entry["umode"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	-- check for missing values
	if     (name == nil) then
		errorMsg("addfile: missing name")
		return
	elseif (source == nil) then
		errorMsg("addfile: missing source")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. "/templates/default/fs/" .. name

	debugMsg(2,"do_exportfile:" .. entry["name"] .. "," .. entry["source"])
	do_execute("install -D " .. source .. " " .. name) 


	-- Assemble replacement "changelist_line" as "chmod" without "source"
	changelist_line=""
	
	if (nil ~= umode) then
		debugMsg(2,"do_exportfile:umode=" .. entry["umode"])
		changelist_line=changelist_line .. " umode=\"" .. entry["umode"] .. "\"" 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_exportfile:uid=" .. entry["uid"])
		changelist_line=changelist_line .. " uid=\"" .. entry["uid"] .. "\"" 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_exportfile:gid=" .. entry["gid"])
		changelist_line=changelist_line .. " gid=\"" .. entry["gid"] .. "\"" 
	end
	
	if (0 ~= string.len(changelist_line)) then
		changelist_line="        <cl action=\"chmod\" name=\"" .. entry["name"] .. "\"" .. changelist_line .. "/>"
	end
end

function do_adddir (entry)
	debugMsg(2,"do_adddir:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	source=entry["source"]
	umode =entry["umode"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("adddir: missing name")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	if (source) then
		debugMsg(2,"do_adddir:" .. entry["name"]  .. "," .. entry["source"])
		do_execute("install -d " .. source .. " " .. name )
	else
		debugMsg(2,"do_adddir:" .. entry["name"] )
		do_execute("mkdir --parents " .. name) 
	end

	if (nil ~= umode) then
		debugMsg(2,"do_adddir:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_adddir:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_adddir:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_addsymlink (entry)
	debugMsg(2,"do_addsymlink:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	target=entry["target"]
	umode =entry["umode"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("addsymlink: missing name")
		return
	elseif (target == nil) then
		errorMsg("addsymlink: missing target")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_addsymlink:" .. entry["name"] .. "," .. entry["target"])
	do_execute("ln -s " .. target .. " " .. name ) 

	if (nil ~= umode) then
		debugMsg(2,"do_addsymlink:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_addsymlink:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_addsymlink:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_addbdev (entry)
	debugMsg(2,"do_addbdev:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	major =entry["major"]
	minor =entry["minor"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("addbdev: missing name")
		return
	elseif (major == nil) then
		errorMsg("addbdev: missing major")
		return
	elseif (minor == nil) then
		errorMsg("addbdev: missing minor")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_addbdev:" .. entry["name"] .. "," .. entry["major"] .. "," .. entry["minor"])
	do_execute("mknod " .. name .. " b " .. major .. " " .. minor ) 

	if (nil ~= umode) then
		debugMsg(2,"do_addbdev:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_addbdev:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_addbdev:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_addcdev (entry)
	debugMsg(2,"do_addbdev:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	major =entry["major"]
	minor =entry["minor"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("addcdev: missing name")
		return
	elseif (major == nil) then
		errorMsg("addcdev: missing major")
		return
	elseif (minor == nil) then
		errorMsg("addcdev: missing minor")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_addcdev:" .. entry["name"] .. "," .. entry["major"] .. "," .. entry["minor"])
	do_execute("mknod " .. name .. " c " .. major .. " " .. minor ) 

	if (nil ~= umode) then
		debugMsg(2,"do_addcdev:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_addcdev:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_addcdev:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_addpipe (entry)
	debugMsg(2,"do_addbdev:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("addpipe: missing name")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_pipe:" .. entry["name"] )
	do_execute("mkfifo " .. name) 

	if (nil ~= umode) then
		debugMsg(2,"do_pipe:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_addpipe:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_addpipe:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_chmod (entry)
	debugMsg(2,"do_chmod:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	umode =entry["umode"]
	uid   =entry["uid"]
	gid   =entry["gid"]
	
	if     (name == nil) then
		errorMsg("chmod: missing name")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_chmod:" .. entry["name"]  )

	if (nil ~= umode) then
		debugMsg(2,"do_chmod:umode=" .. entry["umode"])
		do_execute("chmod " .. umode .. " " .. name) 
	end
	if (nil ~= uid) then
		debugMsg(2,"do_chmod:UID=" .. entry["uid"])
		do_execute("chown " .. uid .. " " .. name) 
	end
	if (nil ~= gid) then
		debugMsg(2,"do_chmod:GID=" .. entry["gid"])
		do_execute("chgrp " .. gid .. " " .. name) 
	end
		
end

function do_delfile (entry)
	debugMsg(2,"do_delfile:" .. entry["action"] .. "," .. entry["name"])
	
	name  =entry["name"]
	
	if     (name == nil) then
		errorMsg("delfile: missing name")
		return
	end

	-- prefix name with destination dir
	name=dstdir .. name

	debugMsg(2,"do_delfile:" .. entry["name"] )
	do_execute("rm -rf "..name) 

end


-------------------------------------------
-- Paser and dispatch the change entries
--

function parse (l,start,filter)

	local isQuote,name,value
	local entry={}
	
	debugMsg(2,l)
	debugMsg(2,string.sub(l,start))
	
	isQuote=false
	for i=start,string.len(l) do
		local c
		
		c=string.sub(l,i,i)
		
		if (c == "=") then
			-- we have the name
			name=string.sub(l,start,i-1)
			start=i
		elseif (c == "\"") then
			if (isQuote) then
				-- closing quote, we have the value
				isQuote=false
				value=string.sub(l,start,i-1)
				debugMsg(2,"name,value:" .. name .. "," .. value .. ";")
				entry[name]=value
			else
				-- opening quote, we start the value
				isQuote=true
				start=i+1
			end
		elseif (((c == " ") or (c == "\t")) and (false==isQuote)) then
			-- skip white space, except within quotes
			start=i+1
		elseif ((c == "<") and (string.sub(l,i+1,i+3) == "!--")) then
			-- truncate comments
			debugMsg(2,"TRUCATE ] " .. string.sub(l,i) )
			break;
		end
	
	end
	
	-- pass the action to the handler
	-- report bad entries on the "files" pass
	if ("export" == filter) then
		if (entry["action"]=="addfile") then
			do_exportfile(entry) 
			debugMsg(2,"changelist_line: " .. changelist_line)
		end	
	elseif (entry["action"]=="addfile") then
		if ("files" == filter) then do_addfile(entry) end
	elseif (entry["action"]=="addbdev") then
		if ("files" == filter) then do_addbdev(entry) end
	elseif (entry["action"]=="addcdev") then
		if ("files" == filter) then do_addcdev(entry) end
	elseif (entry["action"]=="addpipe") then
		if ("files" == filter) then do_addpipe(entry) end
	elseif (entry["action"]=="chmod") then
		if ("files" == filter) then do_chmod(entry)   end
	elseif (entry["action"]=="delfile") then
		if ("files" == filter) then do_delfile(entry) end
	elseif (entry["version"]~=nil) then
		if ("files" == filter) then do_version(entry) end
	elseif (entry["action"]=="adddir") then
		if ("directories" == filter) then do_adddir(entry) end
	elseif (entry["action"]=="addsymlink") then
		if ("symlinks" == filter) then do_addsymlink(entry) end
	elseif ("files" == filter) then
		if (nil == entry["action"]) then
			errorMsg("Missing action:")
		else
			errorMsg("Unknown action:" .. entry["action"])
		end
	end

end

-------------------------------------------
-- main(): scan each line of change file
--

function scan_srcfile (srcfile,filter)

	local skipping_DTD=true

	debugMsg(2,"scan_srcfile: " .. srcfile .. "," .. filter)

	for line in io.lines(srcfile) do

		local start,stop

		line_cnt=line_cnt+1
		changelist_line=line

		-- skip the DTD, if any
		if (skipping_DTD) then
			start,stop=string.find(line,"<layout_change_list",1,TRUE)
			if (start) then
				skipping_DTD=false
			end	
		end

		if (false == skipping_DTD) then
			start,stop=string.find(line,"<cl ",1,TRUE)
			if (stop) then 
				parse(line,stop+1,filter)
			else
				start,stop=string.find(line,"version=",1,TRUE)
				if (start) then 
					parse(line,start,filter)
				end
			end
		end	

		-- export the entry, if there is something left to export		
		if (filter == "export") and (0 ~= string.len(changelist_line)) then
			do_execute("echo '" .. changelist_line .. "' >> " .. dstfile) 
		end
		
	end
end

-------------------------------------------
-- main(): scan each line of change file
--

if (command == "export") then
	srcfile=dstdir .. "/templates/default/changelist.xml"
	dstfile=dstdir .. "/templates/default/changelist.xml_new"
	debugMsg(2,"srcfile: " .. srcfile)
	debugMsg(2,"dstfile: " .. dstfile)

	-- Single pass to dup change list file, resolve external file paths
	do_execute("rm -f " .. dstfile) 
	scan_srcfile(srcfile,"export")
	do_execute("mv -f " .. dstfile .. " " .. srcfile) 
else
	if (0 ~= string.len(srcdir)) then
		srcfile=srcdir .. "/" .. "changelist.xml"
	else
		srcfile="changelist.xml"
	end
	debugMsg(2,"srcfile: " .. srcfile)

	-- Ordered file object creation
	scan_srcfile(srcfile,"directories")
	scan_srcfile(srcfile,"files")
	scan_srcfile(srcfile,"symlinks")
end

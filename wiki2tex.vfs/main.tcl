# -*-Tcl-*-
## 2007 Tomasz Luczak tlu@technodat.com.pl
# $Id: main.tcl 17 2007-02-01 10:09:30Z tlu $
############################
# Tcl/Tk 8.4.11
############################## SETTINGS
  
############### version
set VER "0.4"
set INSTALL " ver. $VER 2007.01.28"
set TCLREV [info patchlevel]

##########################
package require starkit
starkit::startup
set sourcedir $starkit::topdir

############################# Procedures
proc wiki2latex line {
    global itemenum table
    if [regexp (^\={2,})(.+)(\={2,}) $line] then {
	###### Tytularia
	if {[regsub (^\={6})(.+)(\={6})       $line {\\section*{\2}}        newline] eq 1} then {
	} elseif {[regsub (^\={5})(.+)(\={5}) $line {\\subsection*{\2}}     newline] eq 1} then {
	} elseif {[regsub (^\={4})(.+)(\={4}) $line {\\subsubsection*{\2}}  newline] eq 1} then {
	} elseif {[regsub (^\={3})(.+)(\={3}) $line {\\subsubsection*{\2}} newline] eq 1} then {
	} elseif {[regsub (^\={2})(.+)(\={2}) $line {\\paragraph{\2}}      newline] eq 1} then {
	}
    } elseif [regexp (^\ {2,}\-)(.+) $line] then {
	###### Enumerate
	# item
	regsub (^\ {2}\-)(.+) $line {\\item \2} newline1
	# [[address|name]]
	regsub {(.*)(\[{2})(.+)(\|)(.+)\]{2}} $newline1 {\1 \5\7} newline
	if {$itemenum eq 0} then {
	    set newline "\n\\begin{enumerate}\n$newline"
	}
	set itemenum enumerate
    } elseif {[regexp (^\ {2,}\[*\])(.+) $line]} then {
	##### Itemize
	# item
	regsub (^\ {2}\[*\])(.+) $line {\\item \2} newline1
	# [[address|name]]
	regsub -all {(.*)(\[{2})(.+)(\|)(.+)\]{2}} $newline1 {\1 \5\7} newline
	if {$itemenum eq 0} then {
	    set newline "\n\\begin{itemize}\n$newline"
	}
	set itemenum itemize
    } elseif [regexp (^\ {0,}$) $line] then {
	##### Empty line
	if {$itemenum ne 0} then {
	    set newline "\\end{$itemenum}\n"
	    set itemenum 0
	} elseif {$table eq 1} {
	    set newline "\\end{longtable}\n\}\n"
	    set table 0
	} else {
	    set newline ""
	}
    } else {
	if {[string first "\[" $line] ne -1} then {
	    # [[address|name]]
	    regsub -all {(\[{2})([^\[\]]+)(\|)([^\[\]]+)(\]{2})} $line {\4} newline
	} elseif {[string first "\{" $line] ne -1} then {
	    # {{address|name}}
	    regsub {^(\{{2})(.+)(\|)(.+)(\}{2})} $line {\\begin{figure}\\includegraphics[width=\textwidth]{\2.pdf}\\caption{\4}\end{figure}} newline1
	    regsub {.png.pdf} $newline1 {.pdf} newline
	} elseif {[string first "^" $line] ne -1} then {
	    # Table - header
	    regsub {[\^]([^\^]+)[\^]([^\^]+)[\^]([^\^]+)[\^]} $line { \1 \& \2 \& \3 } newline1
	    set table 1
	    set newline "\n\{\\flushleft\\begin{longtable}{|p{3.5cm}|p{6cm}|p{5.5cm}|}\n \\hline $newline1 \\\\ \\hline\\hline"
	} elseif {[string first "|" $line] ne -1} then {
	    # Table - row
	    regsub {[|]([^\|]+)[\|]([^\|]+)[\|]([^\|]+)[\|]} $line {\1 \& \2 \& \3} newline1
	    # [[address|name]]
	    #regsub -all {(.*)(\[{2})(.+)(\|)(.+)\]{2}} $newline1 {\1 \5 \7} newline2
	    set newline "$newline1 \\\\ \\hline"
	} else {
	    # Normal line without [[]] and {{}} and ^ and | and =+
	    set newline $line
	}
	
    }
    return "\n$newline"
}
############################# MAIN
#puts " wiki2tex $INSTALL
# 2006 by Tomasz Luczak tlu@technodat.com.pl"
#########
set filetex ""
set itemenum 0
set table 0
set filename $argv
puts "$INSTALL - $filename"
if [file exists $argv] then {
    if { [catch {set input [open $filename r]} result] eq 0} then {
	# read file line by line
	while {![eof $input]} {
	    append filetex [wiki2latex [gets $input]]
	}
	close $input

	# write to TeX file
	set filenametex "[file tail [file rootname $filename]].tex"
	if { [catch {set filehandle [open $filenametex w]} result] eq 0} then {
	    puts -nonewline $filehandle $filetex
	    close $filehandle
	} else {puts "Error write '$filename'"}
    } else {puts "Error open '$filename'"}
} else {puts "File '$filename' not exists"}

exit
## EOF

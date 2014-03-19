-- Author: Ben Guitreau
-- http://github.com/akiress/haskell-config

Config {  font = "xft:DejaVu Sans-7:bold"
        , bgColor = "black"
        , fgColor = "grey"
        , position = TopW L 100
        , commands = 
            [ Run Weather "KBTR" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000
            , Run Network "wlan0" ["-t","<dev>: [<rx>/<tx>]"] 10
            , Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10
            , Run CoreTemp ["-t", "<core0> <core1> <core2> <core3> °C","-L", "40","-H", "65","-l", "lightblue","-h", "orange"] 50
            , Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
            , Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
            , Run DiskU [("/", "/: <usedp>"), ("/boot", "/boot: <usedp>"), ("/home", "/home: <usedp>"), ("/var", "/var: <usedp>")] []  60
            , Run DiskIO [("/", "/: <total>"), ("/boot", "/boot: <total>"), ("/home", "/home: <total>"), ("/var", "/var: <total>")] [] 10
            , Run Network "enp4s0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
            , Run Date "%a %b %_d %l:%M" "date" 10
            , Run Com "/home/akiress/scripts/volume.sh" [] "volume" 10
            , Run StdinReader
        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "<fc=#ff66ff>%date%</fc> %KBTR% } %StdinReader% { %enp4s0% | %multicpu% | %memory% | %swap% | Vol: %volume%" 
}
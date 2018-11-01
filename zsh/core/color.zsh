# ls colors

# Attribute codes;
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes;
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes;
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

LS_COLORS="fi=37;00:di=36:ex=31:ln=37;04:bd=33:cd=33:pi=35:so=35"
LS_COLORS="$LS_COLORS:*.gz=31:*.Z=31:*.lzh=31:*.zip=31:*.bz2=31:*.bz=31:*.sit=31:*.hqx=31"
LS_COLORS="$LS_COLORS:*.tar=31:*.tgz=31:*.shar=31"
LS_COLORS="$LS_COLORS:*.gif=35:*.jpg=35:*.jpeg=35:*.tif=35:*.ps=35"
LS_COLORS="$LS_COLORS:*.xpm=35:*.xbm=35:*.xwd=35:*.xcf=35"
LS_COLORS="$LS_COLORS:*.avi=35:*.mov=35:*.mpeg=35:*.mpg=35"
LS_COLORS="$LS_COLORS:*.mid=35:*.MID=35:*.rcp=35:*.RCP=35:*.mp3=35"
LS_COLORS="$LS_COLORS:*.mod=35:*.MOD=35:*.au=35:*.aiff=35:*.wav=35"
LS_COLORS="$LS_COLORS:*.htm=33:*.html=33:*.java=33:*.class=33:*.shtml=33"
LS_COLORS="$LS_COLORS:*.php=33:*.phps=33:*.cdml=33:*.css=33:*.dat=33"
LS_COLORS="$LS_COLORS:*.c=33:*.h=33:*.C=33:*.c++=33:*.cp=33:*.cpp=33:*.hp=33:*.hpp=33:*.m=33:*.mm=33"
LS_COLORS="$LS_COLORS:*.tex=33:*~=0"

export LS_COLORS

# BSD ls colors ANSI
export LSCOLORS="gxhxfxfxbxdxdxbxbx"


set CARD=%CD%
set PARAM=%1
C:\Users\Pierre\Documents\FlatCAM\FlatCAM.exe --shellfile=C:\Users\Pierre\Dropbox\eagle\generic.FlatScript
grecode -cw -o tempo.nc complet.nc
grecode -align min min -o complet_90.nc tempo.nc
del tempo.nc
set term svg
set output "circuits/DiffAmp-AC.svg"

set multiplot layout 2,1
set logscale x
set title "Differential Gain"
plot [:] [:] \
  'circuits/DiffAmp.cir.FD.prn' using 2:3 notitle with lines
set title "Phase Margin"
plot [:] [:] \
  'circuits/DiffAmp.cir.FD.prn' using 2:4 notitle with lines
unset multiplot
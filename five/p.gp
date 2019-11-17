
set term svg
set output "circuits/five.svg"

set multiplot layout 2,1
set logscale x
set xrange [1:1e10]
set title "Differential Gain (dB) vs. Frequency (Hz)"
plot [:] [:] \
  'circuits/five.cir.FD.prn' using 2:3 title 'Schematic' with lines, \
  'circuits/five_transistor_ota.cir.FD.prn' using 2:3 title 'Layout' with lines
set title "Phase Margin (Degrees) vs. Frequency (Hz)"
plot [:] [:] \
  'circuits/five.cir.FD.prn' using 2:4 title 'Schematic' with lines, \
  'circuits/five_transistor_ota.cir.FD.prn' using 2:4 title 'Layout' with lines

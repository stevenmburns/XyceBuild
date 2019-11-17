
set term svg
set output "circuits/five.svg"

set ylabel "Voltage"

set logscale x

plot [:] [:] \
  'circuits/five_transistor_ota.cir.FD.prn' using 2:3 with lines


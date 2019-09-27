
set term svg
set output "circuits/DP.svg"

set ylabel "Voltage"
set y2label "Current"

set y2range [0:]

plot [0:1] [0:1] \
  '<head --lines=-1 circuits/DP.cir.prn' using 2:4 with lines, \
  '<head --lines=-1 circuits/DP.cir.prn' using 2:5 with lines, \
  '<head --lines=-1 circuits/DP.cir.prn' using 2:7 with lines, \
  '<head --lines=-1 circuits/DP.cir.prn' using 2:8 with lines axes x1y2




set term svg
set output "circuits/RF.svg"

plot [:] [-0.1:1.1] \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:3 with lines, \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:4 with lines, \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:5 with lines, \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:6 with lines, \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:7 with lines, \
  '<head --lines=-1 circuits/RF.cir.prn' using 2:8 with lines

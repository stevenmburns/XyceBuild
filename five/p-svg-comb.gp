
set term png
set output "five-comb.png"

set ylabel "Voltage"

set logscale x

plot [:] [:] \
  '<head --lines=-1 polo-fd.txt' using 2:3 with lines, \
  '<head --lines=-1 sch-fd.txt'  using 2:3 with lines


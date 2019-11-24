import numpy as np
import scipy.optimize
import scipy.interpolate
import matplotlib.pyplot as plt
import math

def annotated_gain( fn):



    with open( fn,"rt") as fp:
        f = fp.read()

    txt = [ [x for x in y.split(' ') if x != ''] for y in f.split('\n')[1:-2]]

    xs = [math.log10(float(x[1])) for x in txt]
    ys = [float(x[2]) for x in txt]

    b = scipy.interpolate.make_interp_spline( xs,ys)

    n = 100
    f0,f1 = 1,11
    f = np.arange( f0, f1 + 1/(2*n), 1/n)

    y_3db = b(1)-3
    x_3db = scipy.optimize.brenth( lambda x: b(x)-y_3db, f0, f1)

    x_unity_gain = scipy.optimize.brenth( b, f0, f1)

    plt.plot( f, [ b(x) for x in f])
    plt.plot( x_3db, y_3db, "o")
    plt.plot( x_unity_gain, 0, "d")



if __name__ == "__main__":
    annotated_gain( "circuits-polo/five_transistor_ota.cir.FD.prn")
    annotated_gain( "circuits-sch/five_transistor_ota_sch.cir.FD.prn")
    plt.show()


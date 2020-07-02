import numpy as np
import math

import matplotlib as mpl
import matplotlib.pyplot as plt
plt.rc("font", family='Arial', size=12)
plt.rc("mathtext", fontset='stix')


def binet(n):
    return np.power((1+np.sqrt(5))/2 + 0j,n)/np.sqrt(5) - np.power((1-np.sqrt(5))/2+ 0j,n)/np.sqrt(5)


def complex_plot_(x, y, xlabel="x", ylabel="y", addtitle=" "):
	plt.figure(figsize=(10, 5))
	plt.subplot(121)
	plt.plot(x, np.real(y))
	plt.xlabel(xlabel)
	plt.ylabel(r"Re("+ylabel+")")
	plt.title("Real part")

	plt.subplot(122)
	plt.plot(x, np.imag(y))
	plt.xlabel(xlabel)
	plt.ylabel(r"Im("+ylabel+")")
	plt.title("Imaginary part")
	plt.suptitle(addtitle)

	

if __name__=="__main__":
	n_array = np.linspace(0, 10, 100)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Positive numbers")	
	
	n_array = np.linspace(-10, 0, 100)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Negative numbers")	
	plt.show()
	
	
	

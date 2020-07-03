import numpy as np
import math

import matplotlib as mpl
import matplotlib.pyplot as plt
plt.rc("font", family='Arial', size=12)
plt.rc("mathtext", fontset='stix')


def binet(n):
    return np.power((1+np.sqrt(5))/2 + 0j,n)/np.sqrt(5) - np.power((1-np.sqrt(5))/2+ 0j,n)/np.sqrt(5)


def complex_plot_(x, y, xlabel="x", ylabel="y", addtitle=" "):
	plt.figure(figsize=(5, 5))
	
	plt.subplot(221)
	plt.plot(x, np.real(y), linewidth=2)
	plt.xlabel(xlabel)
	plt.ylabel(r"Re("+ylabel+")")
	plt.title(" ")
	plt.grid(which='major', axis='both')

	plt.subplot(222)
	plt.plot(x, np.imag(y), linewidth=2)
	plt.xlabel(xlabel)
	plt.ylabel(r"Im("+ylabel+")")
	plt.title(" ")
	plt.grid(which='major', axis='both')

	plt.subplot(223)
	plt.plot(np.real(y), np.imag(y), linewidth=2)
	plt.xlabel(r"Re("+ylabel+")")
	plt.ylabel(r"Im("+ylabel+")")
	plt.title(" ")
	plt.grid(which='major', axis='both')

	plt.suptitle(addtitle)

	plt.tight_layout()
	

if __name__=="__main__":
	print("Input value as x where interval is [-x, x]")
	num = float(input())

	n_array = np.arange(0, num, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Positive numbers")	
	
	n_array = np.arange(-num, 0, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Negative numbers")

	n_array = np.arange(-num, num, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$")	
	plt.show()
	
	
	

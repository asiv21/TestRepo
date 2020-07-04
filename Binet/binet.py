import numpy as np
import math

import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d

plt.rc("font", family='Arial', size=12)
plt.rc("mathtext", fontset='stix')


def binet(n):
    return np.power((1+np.sqrt(5))/2 + 0j,n)/np.sqrt(5) - np.power((1-np.sqrt(5))/2+ 0j,n)/np.sqrt(5)



def complex_plot_(x, y, xlabel="x", ylabel="y", addtitle=" "):
	plt.figure(figsize=(4, 8))
	
	plt.subplot(211)
	plt.plot(x, np.real(y), linewidth=2, color='tab:blue', label=r"Re("+ylabel+")")
	plt.plot(x, np.imag(y), linewidth=2, color='tab:red', label=r"Im("+ylabel+")")
	plt.xlabel(xlabel)
	plt.xticks(np.arange(x.min(), x.max()+1, 1))
	plt.yticks(np.arange(y.real.min(), y.real.max()+1, 1))
	plt.ylabel(r"Re, Im("+ylabel+")")
	plt.title(" ")
	plt.grid(which='major', axis='both')
	plt.legend()

	plt.subplot(212)
	plt.axhline(0, color='lightgray')
	plt.plot(np.real(y), np.imag(y), color='tab:green', linewidth=2)
	plt.xlabel(r"Re("+ylabel+")")
	plt.ylabel(r"Im("+ylabel+")")
	plt.xticks(np.arange(y.real.min(), y.real.max()+1, 1))
	plt.title(" ")
	plt.grid(which='major', axis='both')

	plt.suptitle(addtitle)

	plt.tight_layout()

def complex_plot_2d_(X, Y, Z):
	fig = plt.figure()
	ax1 = fig.add_subplot(211, projection='3d')
	ax1.plot_surface(X, Y, Z.real, color='tab:blue')
	ax1.set_xlabel(r"$x$")
	ax1.set_ylabel(r"$iy$")
	ax1.set_zlabel(r"Re($f(x+iy)$)")

	ax2 = fig.add_subplot(212, projection='3d')
	ax2.plot_surface(X, Y, Z.imag, color='tab:red')
	ax2.set_xlabel(r"$x$")
	ax2.set_ylabel(r"$iy$")
	ax2.set_zlabel(r"Im($f(x+iy)$)")

	plt.tight_layout()

if __name__=="__main__":
	print("Input the upper bound of Binet numbers, n: ")
	num_str = input()
	if num_str == "":
		num_str = "6"
	num = float(num_str)
	print(num_str)


	####################################################
	# Positive Numbers
	####################################################
	n_array = np.arange(0, num, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Positive numbers")	
	
	####################################################
	# Negative Numbers
	####################################################
	n_array = np.arange(-num, 0, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$", "Negative numbers")

	####################################################
	# Negative Numbers
	####################################################
	n_array = np.arange(-num, num, 0.001)
	binet_array = binet(n_array)
	complex_plot_(n_array, binet_array, "$n$", "$f(n)$")


	####################################################
	# Complex Numbers
	####################################################
	X, Y = np.meshgrid(np.linspace(-num, num, 100), np.linspace(0, num, 100))
	Z = binet(X + Y*1j)
	complex_plot_2d_(X, Y, Z)
	print("Binet Analysis Done!")

	plt.show()
	
	
	

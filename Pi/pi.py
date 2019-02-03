import numpy as np

import matplotlib.pyplot as plt

''' This approximates Pi using Leibnitz formula'''
def pi_approx(N,showplot = True):

    pi_approx = np.zeros((N,))
    pi_approx[0] = 4
    for n in range(N-1):
        pi_approx[n+1] = pi_approx[n] + 4*(-1)**(n+1)/(2*(n+1)+1)
    print('The approximation of pi upto', N, 'terms is \n', pi_approx[N-1])
    #Plot
    if showplot==True:
        plt.figure()

        plt.plot(range(1,N+1),pi_approx,'o--')
        plt.plot(range(N+1),np.pi*np.ones((N+1,)),color = [0.8,0.2,0.1])
        plt.xlim([1,N])
        plt.legend(['Leibnitz approximation', 'Pi'])
        plt.show()

        plt.figure()
        plt.plot(range(1,N+1), np.abs(pi_approx-np.pi))
        plt.xlim([1,N])
        plt.title('Error in pi')
        plt.show()
        
pi_approx(100)

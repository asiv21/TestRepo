import numpy as np

def GameInit():
    # Generates two random numbers A and B

    NumAll = np.random.rand(2,1)
    A = NumAll[0]
    B = NumAll[1]
    return A,B

def GreaterThan(A):
    # Takes in A and generates a random number K and predicts if A is greater than B based on K
    K = np.random.rand(1,1)
    if A>K:
        return(1)
    else:
        return(0)

s = 0
N = 10000
for i in range(N):
    [A,B] = GameInit()

    Gr = GreaterThan(A)

    if A>B:
        Gr_truth = 1
    else:
        Gr_truth = 0

    if Gr_truth==Gr:
        s +=1

print "The accuracy of the guessing game is : ", float(s)/N*100,"%"

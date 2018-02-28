# 7-2 Quicksort with equal element values  
The analysis of the expected running time of randomized quicksort in Section 7.4.2
assumes that all element values are distinct. In this problem, we examine what
happens when they are not.

# Answer  
a. Since all elements are the same, the initial random choice of index and swap
change nothing. Thus, randomized quicksort’s running time will be the same
as that of quicksort. Since all elements are equal, PARTITION(A, P, r) will
always return r − 1. This is worst-case partitioning, so the runtime is Θ(n^2).  
b. See the PARTITION’ algorithm for modifications.  
c. See the RANDOMIZED-PARTITION’ algorithm for modifications.  
d. Let d be the number of distinct elements in A. The running time is dominated
by the time spent in the PARTITION procedure, and there can be at most d
calls to PARTITION. If X is the number of comparisons performed in line 4
of PARTITION over the entire execution of QUICKSORT’, then the running
time is O(d + X). It remains true that each pair of elements is compared
at most once. If zi is the ith smallest element, we need to compute the
probability that zi is compared to zj . This time, once a pivot x is chosen
with zi ≤ x ≤ zj , we know that zi and zj cannot be compared at any
subsequent time. This is where the analysis differs, because there could be
many elements of the array equal to zi or zj , so the probability that zi and
zj are compared decreases. However, the expected percentage of distinct
elements in a random array tends to 1 − 1/e , so asymptotically the expected
number of comparisons is the same.  

# Quicksort(A,p,r)  
1: if p < r then  
2: x = A[p]  
3: q = HoareP artition(A, p, r)  
4: i = 0  
5: while A[i] 6= x do  
6: i = i + 1  
7: end while  
8: if i ≤ q then  
9: exchange A[i] and A[q]  
10: else  
11: exchange A[i] and A[q + 1]  
12: q = q + 1  
13: end if  
14: Quicksort(A,p,q-1)  
15: Quicksort(A,q+1,r)  
16: end if  

# Algorithm 1 PARTITION’(A,p,r)  
1: x = A[r]  
2: exchange A[r] with A[p]  
3: i = p − 1  
4: k = p  
5: for j = p + 1 to r − 1   
6: if A[j] < x then  
7: i = i + 1    
8: k = i + 2  
9: exchange A[i] with A[j]  
10: exchange A[k] with A[j]  
11: end if  
12: if A[j] = x then  
13: k = k + 1  
14: exchange A[k] with A[j]  
15: end if  
16: end for  
17: exchange A[i + 1] with A[r]  
18: return i + 1 and k + 1  

# Algorithm 2 RANDOMIZED-PARTITION’  
1: i = RANDOM(p, r)  
2: exchange A[r] with A[i]  
3: return PARTITION’(A,p,r)  

# Algorithm 3 QUICKSORT’(A,p,r)  
1: if p < r then   
2: (q, t) = RANDOMIZED − P ART IT ION0  
3: QUICKSORT’(A,p,q-1)  
4: QUICKSORT’(A,t+1,r)  
5: end if  

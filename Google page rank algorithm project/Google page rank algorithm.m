% MATH 3100 Project 1
% Google PageRank
% Group 2 -- Lucas Benson, Yuchao Chen, Zhou Shen, Amedee O'Gorman

clear all

% create G matrix such that G = ?*H + ?*a*1 + ((1-?)/n)*1*1^t 
% for the mini-graph described 

alpha = 0.9; % let ? be any number such that 0 ? ? ? 1
n = 6; % let n = number of web pages being ranked

% create substochastic H matrix
H = [0   1/2   1/2   0   0   0; 
     0    0     0    0   0   0;
    1/3  1/3    0    0  1/3  0;
     0    0     0    0  1/2 1/2;
     0    0     0   1/2  0  1/2;
     0    0     0    1   0   0];
 
one = ones(6,1); % "1" column vector
one_t = ones(1,6); % transpose of "1" column vector gives a "1" row vector

a = [0; 1/6; 0; 0; 0; 0]; % a column vector 

% compute G matrix using equation described above
G = alpha*H + alpha*a*one_t + ((1-alpha)/n)*one*one_t;


% Now we must create the update algorithm to find final page rank using 
% equation ?^t = G*?^t where LHS is ?^t with respect to k+1 
% and RHS is ?^t with respect to k. That is,
% LHS ?^t is the new rank vector that is being updated (k+1) and
% RHS ?^t is the previous rank vector used to do the updating (k)
% where k is the number representing the current iteration step

% Start by assuming the first RHS ?^t row vector at k = 0 is
pi_kt = [1/6 1/6 1/6 1/6 1/6 1/6];
% Note that RHS ?^t is assumed to be the transpose of the ? column 
% vector at k = 0

% we then compute the LHS row vector ?^t by using the 
% equation pi_kkt = G*pi_kt, where for notation we have pi_kkt = LHS ?^t 
% and pi_kt = RHS ?^t

% therefore to find our solution, we will iterate k as many times as 
% we desire by changing the value of k in the for loop
% *********NOTE TO GROUP: play arounf with the value of k (which is now 10, 
% and see how it corresponds to the steady state vector at the end of 
% this program. 
for k = 1 : 16
pi_kkt = pi_kt*G;
pi_kt = pi_kkt;
end

% to get the column vector ? of the final ranking of ?^t we take the 
% transpose of the final row rank vector after all iterations, giving
pi_kk = pi_kkt.' % again, for notation, we have pi_kk = ? in steady state

% How does this compare to decomposing the update relationship for G into
% its eigenvalues and eigenvectors?

% The equation  pi_kkt = pi_kt*G in its final form (when ?^t has converged
% so that LHS ?^t equals RHS ?^t, i.e., steady state) can be written as an 
% eigen relationship such that ?^t = ?^t*G. This can be written in the 
% more familiar form Av = ?v by rewritting the row vector ?^t (1x6) as a 
% column vector ? (6x1) and taking the transpose of G. Therefore we 
% have G^t*? = ??, or in an easier to read notation, G'? = ??

% We can find the characteristic equation of G'? = ?? by using the 
% equation (G'-?I)? = 0 and finding det(G-?I) = 0. 

% Instead, MATLAB conviently has supplied a function eig() that finds 
% the eigenvalues of a matrix. Therefore, we use eig(G') to 
% find the eigenvalues.
e = eig(G')

% We then compute the corresponding eigen vectors using
[V,D] = eig(G'); 
% This returns a diagonal matrix D of eigenvalues and matrix V whose 
% columns are the corresponding right eigenvectors

V % print V

% We notice from our first eigenvalue of 1, the corresponding eigenvector
% is the first column of V. To peel off that vector we will multiply
% V by the vector [1; 0; 0; 0; 0; 0] so we get
e1 = V * [1; 0; 0; 0; 0; 0] % e1 is the eigenvector corresponding 
% to eigenvalue 1

% We can find the steady state vector by multiplying e1 by the
% recipricol sum of its elements

rs = 1/(ones(1,6)*e1); % where rs equals the recipricol sum of e1
% the ones(1,6) vector (a 1x6 one's vector) was multiplied e1 (a 6x1)
% vector, which yields the sum of e1's elements. We then divide one 
% by this sum yielding the recipricol sum

% Finally, to acquire the steady state vector, we multiply rs, the
% recipricol sum, by e1, the eigenvector corresponding to eigenvalue one

ss= e1*rs; % ss = steady state vector that represents the final value 
% of the rank column vector ? once it has converged

% In order to test if we have iterated our update matrix enough, so that
% we are certain it has converged, we must iterate it until we find that
% pi_kk is equal to ss, where pi_kk equals the cloumn rank vector ? and ss
% equals the steady state vector

% To test this, we set pi_kk - e1, and if it gives the 0 vector, we
% can assume that we have done enough iterations
pi_kk - ss

% Note that because MATLAB's ince eig performs the decomposition using 
% floating-point computations, then the result will not exactly
% equal 0. That it, it is close to, but not exactly, 0.

% By printing both vectors to our command window, we can observe if they
% are equivalent
pi_kk
ss


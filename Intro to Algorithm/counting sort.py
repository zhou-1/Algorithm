def counting(data):
    counts = [0 for i in xrange(max(data)+1)]

    for el in data:
        counts[el] += 1 

    for index in xrange(1, len(counts)):
        counts[index] = counts[index-1] + counts[index]

    L = [0 for loop in xrange(len(data)+1)]
    for el in data:
        index = counts[el] - 1
        L[index] = el
        counts[el] -= 1 

    return L
    
    
data = [27, 4, 15, 9, 110, 0, 13, 25, 1, 17, 802, 66, 25, 45, 97, 9]
assert sorted(data) == counting(data)

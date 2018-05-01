class A:
    x = 'a'
    print("A", x)

class B(A):
    print("B")

class C(A):
    x = 'c'
    print("C", x)

class D(B, C):
    print("D")

print(B.x)
print(D.x) 

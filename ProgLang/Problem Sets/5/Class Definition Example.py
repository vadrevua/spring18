import math

class Point:
    def __init__(self, x, y): # constructor, 2 arguments
        self.x = x
        self.y = y
    def __str__(self):
        return "I'm a point at (%d, %d)" %(self.x, self.y)
    def distance_from_origin(self):
        return math.sqrt(self.x**2 + self.y**2)
    def distance(self, p2):
        return math.sqrt((p2.x - self.x)**2 + (p2.y - self.y)**2)
    def getOrigin():
        return Point(0,0)

pt = Point(10,2)
print(pt)
print("Distance is %d" % pt.distance(Point(20,2)))

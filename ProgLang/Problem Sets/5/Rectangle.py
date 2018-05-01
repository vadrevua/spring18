#Name: Aditya Vadrevu
#CMSC 403

class Rectangle:
    def __init__(self, array):
        self.array = array


    def minX(self):
        count = 99999
        for i in range(len(self.array)):
            if self.array[i][0] < count:
                count = self.array[i][0]
        return count
        # print (count)

    def minY(self):
        count = 99999
        for i in range(len(self.array)):
            if self.array[i][1] < count:
                count = self.array[i][1]
        return count
        # print (count)

    def maxX(self):
        count = 0
        for i in range(len(self.array)):
            if self.array[i][0] > count:
                count = self.array[i][0]
        return count
    def maxY(self):
        count = 0
        for i in range(len(self.array)):
            if self.array[i][1] > count:
                count = self.array[i][1]
        return count


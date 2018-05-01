#Name: Aditya Vadrevu
#CMSC 403

from tkinter import *
from Rectangle import *


class Border(Canvas):
    def __init__(self, array):
        window = Tk()  # Create a window
        window.title("Problem set 5 Vadrevu")  # Set title
        # Place self.canvas in the window
        self.canvas = Canvas(window, width=200, height=100,
                             bg="white")
        self.canvas.pack()

        # Place buttons in frame

        frame = Frame(window)
        frame.pack()

        for i in range(len(array) - 1):
            self.display(array[i][0], array[i][1], array[i + 1][0], array[i + 1][1])

        rect = Rectangle(nums)
        minx = rect.minX()
        miny = rect.minY()
        maxx = rect.maxX()
        maxy = rect.maxY()
        width = maxx - minx
        height = maxy - miny
        cx = (float(width) / 2) + minx
        cy = (float(height) / 2) + miny
        print("The bounding Rectangle is centered at ("+ str(cx)+ ", "+ str(cy)+ ") with width "
              + str(width) + " and height " + str(height))
        self.displayRect(minx, miny, maxx, maxy)
        window.mainloop()  # Create an event loop

    def display(self, x1, y1, x2, y2):
        self.canvas.create_line(x1, y1, x2, y2, fill="red",
                                    tags="line")
        # self.canvas.create_line(10, 90, 190, 10, width=9,
        #                         arrow="last", activefill="blue", tags="line")

    def displayRect(self, x1, y1, x2, y2):
        self.canvas.create_rectangle(x1, y1, x2, y2, tags="rect")



items = input("Enter the coordinates separated by spaces (must be even number): ").strip().split()

if len(items) % 2 == 0:
    nums = [[eval(items[i]), eval(items[i + 1])] for i in range(0, len(items), 2)]
else:
    print("Enter even number of coordinates")
    exit(1)


obj = Border(nums)

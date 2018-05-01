from tkinter import * # Import tkinter

class CanvasCircle:
    def __init__(self):
        window = Tk() # Create a window
        window.title("Canvas Demo") # Set title
        
        # Place self.canvas in the window
        self.canvas = Canvas(window, width = 200, height = 100, 
            bg = "white")
        self.canvas.pack()

        radius = getRadius()
        self.displayOval(radius)

    # Display an oval
    def display_oval_radius(func):
        def inner(self, radius):
            print("The radius of the circle is: ", radius)
            return func(self, radius)
        return inner
    
    @display_oval_radius
    def displayOval(self, radius):
        self.canvas.create_oval(10, 10, radius, radius, fill = "blue")
            

def getRadius():
    radius = eval(input("Enter the radius of the circle: "))
    return radius             

CanvasCircle()

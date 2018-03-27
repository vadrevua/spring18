class Employee:
    def __init__(self,homeAddress):
        self.homeAddress=homeAddress
        
    def printAddress(self):
        print(self.homeAddress)
        
class HourlyEmployee(Employee):
    def __init__(self,homeAddress,rate):
        super().__init__(homeAddress)
        self.rate=rate
        
    def printSalaryPerMonth(self):
        print("$", str(self.rate*20*8))
        
e=Employee("Henrico")
e.printAddress()
f=HourlyEmployee("Midlothian",10)
f.printSalaryPerMonth()  
f.printAddress()

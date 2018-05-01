#To enter items separated spaces, you can use an array of strings
#split the string with .split() into a Strings

items = input("Enter the items separated by spaces (must be even number): ").strip().split()


#Separate the strings into a two-dimensional array of numbers called nums

nums = [[eval(items[i]), eval(items[i + 1])] for i in range(0, len(items), 2)]

for i in range(len(nums)):
    print(nums[i][0])
    print(nums[i][1])
    print()
        
    

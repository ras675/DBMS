
f = open("grades.txt", "r")
maxGPA = 0;
stID = 0;
for x in f:
  x = x.split(";")
  x[1] = float(x[1])
  if(x[1] > maxGPA):
    maxGPA = x[1]
    stID = x[0]
print(f"ID {stID} has highest GPA of {maxGPA}")
f.close()
input("Press enter to continue")
ID = input("Enter the Student ID: ")
GPASum, SemCount = 0, 0
f = open("grades.txt", "r")
for x in f:
  x = x.replace("\n", "")
  x = x.split(";")
  if x[0] == ID:
    GPASum += float(x[1])
    SemCount += 1 
f.close()
if SemCount != 0:
  CGPA = GPASum/SemCount
  f = open("studentInfo.txt", "r")
  for x in f:
    x = x.replace("\n", "")
    x = x.split(";")
    if x[0] == ID:
      print(f"CGPA of {x[1]} is {CGPA}")
      break
else:
  print("Invalid ID")

input("Press enter to continue")
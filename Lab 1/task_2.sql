ID = input("Enter the Student ID: ")
GPA = float(input("Enter GPA: "))
sem = input("Enter semester: ")

def is_valid(ID, GPA, sem):
  if (2.5 > GPA or GPA > 4) or (int(ID) > 2147483647 or int(ID) < 0): 
    return False
  f = open("grades.txt", "r")
  for x in f:
    x = x.replace("\n", "")
    x = x.split(";")
    x[1] = float(x[1])
    if x[0] == ID and x[2] == sem:
      f.close();
      return False
  f.close()
  return True

if is_valid(ID, GPA, sem):
  f = open("grades.txt", "a")
  f.write(f"{ID};{GPA};{sem}\n")
  f.close()
else:
  print("Invalid Input")
input("Press enter to continue
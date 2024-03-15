# first = input()
# second = input()
# third = input()
# first = first.split(" ")
# second = second.split(" ")
# third = third.split(" ")
# sum = 0
# for i in [first, second, third]:
#     l = (float(i[0])**2 + float(i[1])**2)**(0.5)
#     if l <= 0.1:
#         sum += 3
#     if l > 0.1 and l <= 0.8:
#         sum += 2
#     if l > 0.8 and l <= 1:
#         sum += 1
# print(sum)

# first = int(input())
# second = input()
# sort = list(map(len, second.split("#")))
# sort = list(sorted(sort))
# print(sort[0], sort[-1])

# first = int(input())
# second = input()
# spisok = second.split(" ")
# sum = 0
# for i in spisok:
#     sum += int(i)
# sum = sum - 0.5*int(spisok[0]) - 0.5*int(spisok[-1])
# answ = sum/(first-1)
# print(answ)


# first = int(input())
# second = input()
# spisok = list(sorted(list(map(int, second.split(" ")))))
# answ = [spisok[0]]
# last = spisok[0]
# one = None
# val = 0
# for j, i in enumerate(spisok):
#     if i-last > 1 and one == None:
#         last = i
#         answ.append(i)
#     if i-last > 1 and one != None and val > 1:
#         answ += ["...", last, i]
#         last = i
#         one = None
#         val = 0
#     if i-last > 1 and one != None and val == 1:
#         answ.append(last)
#         answ.append(i)
#         last = i
#         one = None
#         val = 0
#     if i == last:
#         continue
#     if i-last == 1 and one == None:
#         one = last
#         last = i
#         val += 1
#     if i-last == 1 and one != None:
#         last = i
#         val += 1
# if one != None and val > 1:
#     answ += ["...", last]
# if one != None and val == 1:
#     answ += [last]
#
# print(" ".join(map(str, answ)))


first = input()
first = first.split(" ")
n = int(first[0])
m = int(first[1])
k = int(first[2])
spisok = []
for i in range(1, m+1):
    a = input()
    spisok.append(list(map(int, a.split(" "))))
way = input()

way = list(map(int, way.split(" ")))
current_point = 1
for i in way:
    previous_point = current_point
    for j in spisok:
        if j[0] == current_point and j[1] == i:
            current_point = j[2]
            break
    if current_point == previous_point:
        current_point = 0
        break
print(current_point)









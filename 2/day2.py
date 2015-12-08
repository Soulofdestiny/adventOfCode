# DAY 02

boxes_data = []
part1_solution = 0
part2_solution = 0

with open('day2', encoding='utf-8') as input:
    for line in input:
        dimensions = list(map(int, line.split('x')))
        boxes_data.append(dimensions)

for box in boxes_data:
    l, w, h = box
    smallSide1, smallSide2, _ = sorted([l, w, h])
    wrapping = 2*l*w + 2*w*h + 2*h*l
    areaOfSmallestSide = smallSide1 * smallSide2
    part1_solution += wrapping + areaOfSmallestSide


for box in boxes_data:
    l, w, h = box
    smallSide1, smallSide2, _ = sorted([l, w, h])
    part2_solution += (l * w * h) + (2*smallSide1 + 2*smallSide2)

print("Part 1: " + str(part1_solution))
print("Part 2: " + str(part2_solution))

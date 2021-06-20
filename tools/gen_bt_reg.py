if __name__ == '__main__':
    f = open('../src/DTW_BT.gen', 'w')

    content = []
    content.append('case (nit)')
    for i in range(39):
        content.append(f'\t6\'d{i}: begin')
        content.append(f'\t\tcase (npe)')
        for j in range(6):
            content.append(f'\t\t\t3\'d{j}: path = PathRAM[{467-i*12-j*2}:{466-i*12-j*2}];')
        content.append('\t\tendcase')
        content.append('\tend')
    content.append('endcase')

    for line in content:
        f.write(line + '\n')
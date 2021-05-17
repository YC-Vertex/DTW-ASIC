import numpy as np

N = 10

if __name__ == '__main__':
    src = 0.5 + 0.5 * np.cos(np.linspace(0, np.pi*3.6, 20))
    src_std = np.clip(np.int16(src*1024), 0, 1023)

    with open('../data/memory.vec', 'w') as fsrc:
        for item in src_std:
            data = (item << 20) | (item << 10) | item
            fsrc.write(f'{data:08x}\n')

    with open('../data/in.vec', 'w') as fqry:
        for i in range(N):
            qry_std = []
            for j in range(3):
                qry = src + np.random.randn(20)* 1
                qry_std.append(np.clip(np.int16(qry*1024), 0, 1023))

            for i in range(20):
                data = (qry_std[0][i] << 20 | qry_std[1][i] << 10) | qry_std[2][i]
                fqry.write(f'{data:08x} ')
            fqry.write('\n')
        
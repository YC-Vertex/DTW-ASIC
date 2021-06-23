import argparse
import numpy as np

from GenPlayground import GenPlayground

def dist(x, y):
    return np.sum(np.abs(np.array(x) - np.array(y))) 

# Dynamic Time Warping with Itakura constraint
def DTW_Itakura(src, qry, w):
    n = len(src)
    m = len(qry)
    if not(m == n):
        return None
    l = m # l = m = n

    # 动态规划范围
    IP, _, _ = GenPlayground(l, w)
    IP = np.vstack((np.zeros((1, IP.shape[1])), IP))
    IP = np.hstack((np.zeros((IP.shape[0], 1)), IP))
    IP[0,0] = 1

    # 代价矩阵
    DP = np.zeros((n+1, m+1)) + float('inf')
    DP[0,0] = 0
    TB = np.zeros((n+1, m+1)) + float('inf') # trace back

    # 动态规划
    for i in range(1, l+1):
        for j in range(1, l+1):
            if IP[i,j] == 0:
                continue
            cost = dist(src[i-1], qry[j-1])
            prev = [DP[i-1,j-1], DP[i-1,j], DP[i,j-1]]
            DP[i,j] = cost + min(prev)
            t1 = prev[0] <= prev[1]
            t2 = prev[1] <= prev[2]
            t3 = prev[2] <= prev[0]
            if t1 & ~t3:
                TB[i,j] = 0
            elif t2 & ~t1:
                TB[i,j] = 1
            else:
                TB[i,j] = 2

    return DP[1:,1:], TB[1:,1:]

# 回溯
def traceback(DP, TB):
    align = []
    i = len(DP) - 1
    j = len(DP) - 1
    while True:
        item = (i, j, np.int32(DP[i,j]))
        align.append(item)
        if i == 0 or j == 0:
            break
        if TB[i,j] == 0:
            i = i - 1
            j = j - 1
        elif TB[i,j] == 1:
            i = i - 1
        else:
            j = j - 1
    # align.reverse()
    return align

# 生成输出文件
def genOutput(align, fout):
    first = True
    for item in align:
        if first:
            data = (item[0] << 24) | (item[1] << 16) | item[2]
            first = False
        else:
            data = (item[0] << 24) | (item[1] << 16)
        fout.write(f'{data:08x} ')
    fout.write('ffffffff\n')
    fout.flush()

if __name__ == '__main__':
    np.set_printoptions(linewidth=200)

    parser = argparse.ArgumentParser()
    parser.add_argument('-isrc', '--srcfile', type=str, default='../data/memory.vec',
                        help='input file (source sequence)')
    parser.add_argument('-i', '--ifile', type=str, default='../data/in.vec',
                        help='input file (query sequence)')
    parser.add_argument('-o', '--ofile', type=str, default='../data/out.vec',
                        help='output file')
    parser.add_argument('-w', '--window', type=int, default=-1,
                        help='window size')
    parser.add_argument('-d', '--debug', action='store_true',
                        help='enable debug mode')
    args = parser.parse_args()

    # open files
    fsrc = open(args.srcfile, 'r')
    fqry = open(args.ifile, 'r')
    fout = open(args.ofile, 'w')
    if args.debug:
        fdebug = open('debug.log', 'w')

    src = []
    lines = fsrc.readlines()
    for line in lines:
        # preprocessing
        line = line.strip()
        line = line.split('//')[0] # drop the comments
        if len(line) == 0:
            continue

        # source sequence
        d = int(line, 16)
        src.append([(d>>20) & 0x3ff, (d>>10) & 0x3ff, d & 0x3ff])
        for i in range(3):
            if src[-1][i] >= 512:
                src[-1][i] -= 1024
    
    lines = fqry.readlines()
    for line in lines:
        # preprocessing
        line = line.strip()
        line = line.split('//')[0] # drop the comments
        if len(line) == 0:
            continue

        # query sequence
        data = line.split(' ')
        qry = []
        for d in data:
            d = int(d, 16)
            qry.append([(d>>20) & 0x3ff, (d>>10) & 0x3ff, d & 0x3ff])
            for i in range(3):
                if qry[-1][i] >= 512:
                    qry[-1][i] -= 1024

        # run DTW algorithm
        DP, TB = DTW_Itakura(src, qry, 2.5)
        align = traceback(DP, TB)

        # generate output
        genOutput(align, fout)
        if args.debug:
            print(f'---- Source Sequence ----\n{src}', file = fdebug)
            print(f'---- Query Sequence ----\n{qry}', file = fdebug)
            print(f'---- Dynamic Program ----\n{DP}', file = fdebug)
            print(f'---- Traceback ----\n{TB}', file = fdebug)
            print(f'---- Aignment ----\n{align}\n', file = fdebug)
            fdebug.flush()

    fsrc.close()
    fqry.close()
    fout.close()
    if args.debug:
        fdebug.close()

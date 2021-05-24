import numpy as np
from collections import OrderedDict

from GenPlayground import GenPlayground

def init_cycle(cycle, IP_cycle, ind_src, ind_sel):
    assert len(ind_src) == len(ind_sel)

    Arr = (IP_cycle == cycle)

    Dict = OrderedDict()
    src = ['o_tsrc', 'o_rsrc']
    sel = ['o_sel0', 'o_sel1', 'o_sel2']
    for ind in ind_src[1:]:
        for item in src:
            Dict[f'{item}{ind}'] = None
    for ind in ind_sel[1:]:
        for item in sel:
            Dict[f'{item}{ind}'] = None
    Dict['tindex'] = None
    Dict['rindex'] = None
    Dict['R'] = None

    return Arr, Dict

def Gen_CTRL(IP, IP_cycle, IP_pe):
    f = open('../src/DTW_CTRL.gen', 'w')

    ind_src = [f'[-1:-1]']
    ind_sel = [f'[-1:-1]']
    for i in range(6):
        ind_src.append(f'[{11-i*2}:{10-i*2}]')
        ind_sel.append(f'[{17-i*3}:{15-i*3}]')
    
    for cycle in range(np.max(IP_cycle) + 1):
        Arr, Dict = init_cycle(cycle, IP_cycle, ind_src, ind_sel)

        for i in range(20):
            for j in range(20):
                if Arr[i,j]:
                    tsrc = f'o_tsrc{ind_src[IP_pe[i,j]]}'
                    rsrc = f'o_rsrc{ind_src[IP_pe[i,j]]}'
                    sel0 = f'o_sel0{ind_sel[IP_pe[i,j]]}'
                    sel1 = f'o_sel1{ind_sel[IP_pe[i,j]]}'
                    sel2 = f'o_sel2{ind_sel[IP_pe[i,j]]}'

                    # tsrc
                    if j == 0 or IP_pe[i,j-1] == -1:
                        Dict[tsrc] = '2\'d2'
                    elif IP_pe[i,j] == IP_pe[i,j-1]:
                        Dict[tsrc] = '2\'d0'
                    else:
                        Dict[tsrc] = '2\'d1'
                    # rsrc
                    if i == 0 or IP_pe[i-1,j] == -1:
                        Dict[rsrc] = '2\'d2'
                    elif IP_pe[i,j] == IP_pe[i-1,j]:
                        Dict[rsrc] = '2\'d0'
                    else:
                        Dict[rsrc] = '2\'d1'

                    # sel0
                    if i == 0 and j == 0:
                        Dict[sel0] = '3\'d7'
                    elif i == 0 or j == 0 or IP_pe[i-1,j-1] == -1:
                        Dict[sel0] = '3\'d6'
                    else:
                        Dict[sel0] = f'3\'d{IP_pe[i-1,j-1] - 1}'
                    # sel1
                    if i == 0 or IP_pe[i-1,j] == -1:
                        Dict[sel1] = '3\'d6'
                    else:
                        Dict[sel1] = f'3\'d{IP_pe[i-1,j] - 1}'
                    # sel2
                    if j == 0 or IP_pe[i,j-1] == -1:
                        Dict[sel2] = '3\'d6'
                    else:
                        Dict[sel2] = f'3\'d{IP_pe[i,j-1] - 1}'

        f.write(f'6\'d{cycle}: begin\n')
        for k,v in Dict.items():
            if v == None:
                continue
            f.write(f'    {k}<={v};\n')
            f.flush()
        f.write('end\n\n')

    f.write('\n-----\n\n\n')

    r_buf_ptr = 0
    for cycle in range(np.max(IP_cycle) + 1):
        Arr, _ = init_cycle(cycle, IP_cycle, ind_src, ind_sel)
        r_flag = False
        for i in range(20):
            for j in range(20):
                if Arr[i,j]:
                    # o_rindex & R
                    if i == 0 or IP[i-1,j] == False:
                        f.write(
                            f'6\'d{cycle+1}: '
                            f'R = R_buf[{29+r_buf_ptr*30}:{r_buf_ptr*30}];\n'
                        )
                        f.flush()
                        r_flag = True
        if r_flag == False:
            r_buf_ptr += 1

    f.write('\n-----\n\n\n')

    r_buf_ptr = 0
    for cycle in range(np.max(IP_cycle) + 1):
        Arr, Dict = init_cycle(cycle, IP_cycle, ind_src, ind_sel)
        r_flag = False

        for i in range(20):
            for j in range(20):
                if Arr[i,j]:
                    # o_tindex
                    if j == 0 or IP[i,j-1] == False:
                        Dict['tindex'] = f'5\'d{i}'
                    # o_rindex & R
                    if i == 0 or IP[i-1,j] == False:
                        Dict['rindex'] = f'5\'d{j}'
                        r_flag = True

        if r_flag == False:
            r_buf_ptr += 1

        f.write(f'6\'d{cycle}: begin\n')
        for k,v in Dict.items():
            if v == None:
                continue
            f.write(f'    {k} = {v};\n')
            f.flush()
        f.write('end\n\n')

    f.close()


if __name__ == '__main__':
    np.set_printoptions(linewidth=200)

    IP, IP_cycle, IP_pe = GenPlayground()
    # print(IP_cycle)
    # print(IP_pe)
    Gen_CTRL(IP, IP_cycle, IP_pe)

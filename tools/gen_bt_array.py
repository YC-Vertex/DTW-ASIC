import numpy as np

from GenPlayground import GenPlayground

def Gen_ScoreArr(IP, IP_cycle, IP_pe):
    f = open('../src/ScoreArr.gen', 'w')

    for i in reversed(range(20)):
        for j in reversed(range(20)):
            if IP[i,j]:
                # instantiate the array
                f.write(
                    f'wire i_outena_{i}_{j};\n'
                    f'wire o_ena0_{i}_{j}, o_ena1_{i}_{j}, o_ena2_{i}_{j};\n'
                    f'wire [9:0] o_index_{i}_{j};\n'
                    f'wire [9:0] _{i}_{j}; assign _{i}_{j} = o_index_{i}_{j};\n'
                    f'ScoreUnit #(.TINDEX(5\'d{i}), .RINDEX(5\'d{j})) uut{i}_{j}(\n'
                    f'    .clk(clk),\n' 
                    f'    .nrst(nrst),\n\n'
                    f'    .i_tindex(i_tindex_{IP_pe[i,j]}),\n'
                    f'    .i_rindex(i_rindex_{IP_pe[i,j]}),\n'
                    f'    .i_path(i_path_{IP_pe[i,j]}),\n\n'
                    f'    .i_outena(i_outena_{i}_{j}),\n'
                    f'    .o_ena0(o_ena0_{i}_{j}),\n'
                    f'    .o_ena1(o_ena1_{i}_{j}),\n'
                    f'    .o_ena2(o_ena2_{i}_{j}),\n'
                    f'    .o_index(o_index_{i}_{j})\n'
                    f');\n'
                    f'assign i_outena_{i}_{j} = '
                )
                # connect i_outena
                if i == 19 and j == 19:
                    f.write('i_bt_start')
                else:
                    conn = []
                    if i < 19 and j < 19 and IP[i+1, j+1]:
                        conn.append(f'o_ena0_{i+1}_{j+1}')
                    if i < 19 and IP[i+1, j]:
                        conn.append(f'o_ena1_{i+1}_{j}')
                    if j < 19 and IP[i, j+1]:
                        conn.append(f'o_ena2_{i}_{j+1}')
                    f.write(' | '.join(conn))
                f.write(';\n\n')
                f.flush()
    
    f.write('assign o_bt_end = o_ena0_0_0 | o_ena1_0_0 | o_ena2_0_0;\n\n')

    for i in range(20):
        f.write(f'wire [9:0] _{i};\n')
        s = [f'_{i}_{j}' for j in range(20) if IP[i,j]]
        s = ' | '.join(s)
        f.write(f'assign _{i} = {s};\n')
    s = [f'_{i}' for i in range(20)]
    s = ' | '.join(s)
    f.write(f'assign o_index = {s};\n')

    f.close()

if __name__ == '__main__':
    np.set_printoptions(linewidth=200)

    IP, IP_cycle, IP_pe = GenPlayground()
    # print(IP_cycle)
    # print(IP_pe)
    Gen_ScoreArr(IP, IP_cycle, IP_pe)

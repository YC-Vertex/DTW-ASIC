`include "TOP.v"

module TOP_PAD(
	input   wire    clk_i,
    input   wire    rst_i,

    output  wire    [9:0]   addr_o,
    inout   wire    [31:0]  data,
    output  wire    WR_o,
    output  wire    CS_o,

    input   wire    [31:0]  Sin_i,
    input   wire    valid_i,
    output  wire    ready_o
);

wire _clk_i;
wire _rst_i;
wire [9:0] _addr_o;
wire [31:0] _data_i;
wire [31:0] _data_o;
wire data_tri_ena;
wire _WR_o;
wire _CS_o;
wire [31:0] _Sin_i;
wire _valid_i;
wire _ready_o;

 TOP chip_core(_clk_i,_rst_i,_addr_o,_data_i,_data_o,data_tri_ena,_WR_o,_CS_o,_Sin_i,_valid_i,_ready_o);

//input
 PIW    PCLK(.PAD(clk_i),.C(_clk_i));
 PIW    PRST(.PAD(rst_i),.C(_rst_i));
 PIW    PVALID(.PAD(valid_i),.C(_valid_i));
 PIW    PSin_i0(.PAD(Sin_i[0]),.C(_Sin_i[0])),
        PSin_i1(.PAD(Sin_i[1]),.C(_Sin_i[1])),
        PSin_i2(.PAD(Sin_i[2]),.C(_Sin_i[2])),
        PSin_i3(.PAD(Sin_i[3]),.C(_Sin_i[3])),
        PSin_i4(.PAD(Sin_i[4]),.C(_Sin_i[4])),
        PSin_i5(.PAD(Sin_i[5]),.C(_Sin_i[5])),
        PSin_i6(.PAD(Sin_i[6]),.C(_Sin_i[6])),
        PSin_i7(.PAD(Sin_i[7]),.C(_Sin_i[7])),
        PSin_i8(.PAD(Sin_i[8]),.C(_Sin_i[8])),
        PSin_i9(.PAD(Sin_i[9]),.C(_Sin_i[9])),
   	PSin_i10(.PAD(Sin_i[10]),.C(_Sin_i[10])),
	PSin_i11(.PAD(Sin_i[11]),.C(_Sin_i[11])),
	PSin_i12(.PAD(Sin_i[12]),.C(_Sin_i[12])),
	PSin_i13(.PAD(Sin_i[13]),.C(_Sin_i[13])),
	PSin_i14(.PAD(Sin_i[14]),.C(_Sin_i[14])),
	PSin_i15(.PAD(Sin_i[15]),.C(_Sin_i[15])),
	PSin_i16(.PAD(Sin_i[16]),.C(_Sin_i[16])),
	PSin_i17(.PAD(Sin_i[17]),.C(_Sin_i[17])),
	PSin_i18(.PAD(Sin_i[18]),.C(_Sin_i[18])),
	PSin_i19(.PAD(Sin_i[19]),.C(_Sin_i[19])),
	PSin_i20(.PAD(Sin_i[20]),.C(_Sin_i[20])),
	PSin_i21(.PAD(Sin_i[21]),.C(_Sin_i[21])),
	PSin_i22(.PAD(Sin_i[22]),.C(_Sin_i[22])),
	PSin_i23(.PAD(Sin_i[23]),.C(_Sin_i[23])),
	PSin_i24(.PAD(Sin_i[24]),.C(_Sin_i[24])),
	PSin_i25(.PAD(Sin_i[25]),.C(_Sin_i[25])),
	PSin_i26(.PAD(Sin_i[26]),.C(_Sin_i[26])),
	PSin_i27(.PAD(Sin_i[27]),.C(_Sin_i[27])),
	PSin_i28(.PAD(Sin_i[28]),.C(_Sin_i[28])),
	PSin_i29(.PAD(Sin_i[29]),.C(_Sin_i[29])),
	PSin_i30(.PAD(Sin_i[30]),.C(_Sin_i[30])),
	PSin_i31(.PAD(Sin_i[31]),.C(_Sin_i[31]));
	
//output
 PO16W 	PWR(.PAD(WR_o),.I(_WR_o));
 PO16W 	PCS(.PAD(CS_o),.I(_CS_o));
 PO16W  PREADY(.PAD(ready_o),.I(_ready_o));
 PO16W 	Paddr_o0(.PAD(addr_o[0]),.I(_addr_o[0])),
        Paddr_o1(.PAD(addr_o[1]),.I(_addr_o[1])),
        Paddr_o2(.PAD(addr_o[2]),.I(_addr_o[2])),
        Paddr_o3(.PAD(addr_o[3]),.I(_addr_o[3])),
        Paddr_o4(.PAD(addr_o[4]),.I(_addr_o[4])),
        Paddr_o5(.PAD(addr_o[5]),.I(_addr_o[5])),
        Paddr_o6(.PAD(addr_o[6]),.I(_addr_o[6])),
        Paddr_o7(.PAD(addr_o[7]),.I(_addr_o[7])),
   	Paddr_o8(.PAD(addr_o[8]),.I(_addr_o[8])),
	Paddr_o9(.PAD(addr_o[9]),.I(_addr_o[9]));
//inout

 PB2W PDATA0(.PAD(data[0]),.I(_data_o[0]),.C(_data_i[0]),.OEN(~data_tri_ena)),
 PDATA1(.PAD(data[1]),.I(_data_o[1]),.C(_data_i[1]),.OEN(~data_tri_ena)),
 PDATA2(.PAD(data[2]),.I(_data_o[2]),.C(_data_i[2]),.OEN(~data_tri_ena)),
 PDATA3(.PAD(data[3]),.I(_data_o[3]),.C(_data_i[3]),.OEN(~data_tri_ena)),
 PDATA4(.PAD(data[4]),.I(_data_o[4]),.C(_data_i[4]),.OEN(~data_tri_ena)),
 PDATA5(.PAD(data[5]),.I(_data_o[5]),.C(_data_i[5]),.OEN(~data_tri_ena)),
 PDATA6(.PAD(data[6]),.I(_data_o[6]),.C(_data_i[6]),.OEN(~data_tri_ena)),
 PDATA7(.PAD(data[7]),.I(_data_o[7]),.C(_data_i[7]),.OEN(~data_tri_ena)),
 PDATA8(.PAD(data[8]),.I(_data_o[8]),.C(_data_i[8]),.OEN(~data_tri_ena)),
 PDATA9(.PAD(data[9]),.I(_data_o[9]),.C(_data_i[9]),.OEN(~data_tri_ena)),
 PDATA10(.PAD(data[10]),.I(_data_o[10]),.C(_data_i[10]),.OEN(~data_tri_ena)),
 PDATA11(.PAD(data[11]),.I(_data_o[11]),.C(_data_i[11]),.OEN(~data_tri_ena)),
 PDATA12(.PAD(data[12]),.I(_data_o[12]),.C(_data_i[12]),.OEN(~data_tri_ena)),
 PDATA13(.PAD(data[13]),.I(_data_o[13]),.C(_data_i[13]),.OEN(~data_tri_ena)),
 PDATA14(.PAD(data[14]),.I(_data_o[14]),.C(_data_i[14]),.OEN(~data_tri_ena)),
 PDATA15(.PAD(data[15]),.I(_data_o[15]),.C(_data_i[15]),.OEN(~data_tri_ena)),
 PDATA16(.PAD(data[16]),.I(_data_o[16]),.C(_data_i[16]),.OEN(~data_tri_ena)),
 PDATA17(.PAD(data[17]),.I(_data_o[17]),.C(_data_i[17]),.OEN(~data_tri_ena)),
 PDATA18(.PAD(data[18]),.I(_data_o[18]),.C(_data_i[18]),.OEN(~data_tri_ena)),
 PDATA19(.PAD(data[19]),.I(_data_o[19]),.C(_data_i[19]),.OEN(~data_tri_ena)),
 PDATA20(.PAD(data[20]),.I(_data_o[20]),.C(_data_i[20]),.OEN(~data_tri_ena)),
 PDATA21(.PAD(data[21]),.I(_data_o[21]),.C(_data_i[21]),.OEN(~data_tri_ena)),
 PDATA22(.PAD(data[22]),.I(_data_o[22]),.C(_data_i[22]),.OEN(~data_tri_ena)),
 PDATA23(.PAD(data[23]),.I(_data_o[23]),.C(_data_i[23]),.OEN(~data_tri_ena)),
 PDATA24(.PAD(data[24]),.I(_data_o[24]),.C(_data_i[24]),.OEN(~data_tri_ena)),
 PDATA25(.PAD(data[25]),.I(_data_o[25]),.C(_data_i[25]),.OEN(~data_tri_ena)),
 PDATA26(.PAD(data[26]),.I(_data_o[26]),.C(_data_i[26]),.OEN(~data_tri_ena)),
 PDATA27(.PAD(data[27]),.I(_data_o[27]),.C(_data_i[27]),.OEN(~data_tri_ena)),
 PDATA28(.PAD(data[28]),.I(_data_o[28]),.C(_data_i[28]),.OEN(~data_tri_ena)),
 PDATA29(.PAD(data[29]),.I(_data_o[29]),.C(_data_i[29]),.OEN(~data_tri_ena)),
 PDATA30(.PAD(data[30]),.I(_data_o[30]),.C(_data_i[30]),.OEN(~data_tri_ena)),
 PDATA31(.PAD(data[31]),.I(_data_o[31]),.C(_data_i[31]),.OEN(~data_tri_ena));

endmodule

module DTW_BT(
    input   wire    clk,
    input   wire    nrst,
    
    input   wire    [95:0]  D,
    input   wire    [11:0]  i_path,

    input   wire    i_bt_ena,
    output  wire    o_bt_end,

    output  wire    [31:0]  o_data
);

    localparam PATH0 = 2'b11; // (i-1,j-1)
    localparam PATH1 = 2'b10; // (i-1,j)
    localparam PATH2 = 2'b01; // (i,j-1)
    localparam PATH_RST = 2'b00;

    reg [467:0] PathRAM;
    reg [1:0] path;

    reg [5:0] nit; // number of iterations
    reg [2:0] npe; // pe index
    reg rem_i; // whether (i-1,j) corresponds to the same pe

    reg [4:0] tindex;
    reg [4:0] rindex;
    assign o_bt_end = (tindex == 5'd0 && rindex == 5'd0);

    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            nit <= 6'd38;
            npe <= 3'd2;
            rem_i <= 1'b1;
        end
        else begin
            if (~i_bt_ena) begin
                nit <= 6'd38;
                npe <= 3'd2;
                rem_i <= 1'b1;
            end
            else begin
                if (path == PATH0)
                    nit <= nit - 2;
                else
                    nit <= nit - 1;
                if (path == PATH1) begin
                    if (~rem_i)
                        npe <= npe - 1;
                    rem_i <= ~rem_i;
                end
                else if (path == PATH2) begin
                    if (rem_i)
                        npe <= npe + 1;
                    rem_i <= ~rem_i;
                end
            end
        end
    end

    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            tindex <= 5'd19;
            rindex <= 5'd19;
        end
        else begin
            if (~i_bt_ena) begin
                tindex <= 5'd19;
                rindex <= 5'd19;
            end
            else begin
                if (path == PATH0) begin
                    tindex <= tindex - 1;
                    rindex <= rindex - 1;
                end
                else if (path == PATH1) begin
                    tindex <= tindex - 1;
                end
                else if (path == PATH2) begin
                    rindex <= rindex - 1;
                end
            end
        end
    end

    always @ (posedge clk or negedge nrst) begin
        if (~nrst) begin
            PathRAM <= {468{1'b1}};
        end
        else begin
            if (~i_bt_ena)
                PathRAM <= {PathRAM[455:0], i_path};
        end
    end

    always @ (*) begin
		path = PATH_RST;
        case (nit)
            6'd0: begin
                case (npe)
                    3'd0: path = PathRAM[467:466];
                    3'd1: path = PathRAM[465:464];
                    3'd2: path = PathRAM[463:462];
                    3'd3: path = PathRAM[461:460];
                    3'd4: path = PathRAM[459:458];
                    3'd5: path = PathRAM[457:456];
                endcase
            end
            6'd1: begin
                case (npe)
                    3'd0: path = PathRAM[455:454];
                    3'd1: path = PathRAM[453:452];
                    3'd2: path = PathRAM[451:450];
                    3'd3: path = PathRAM[449:448];
                    3'd4: path = PathRAM[447:446];
                    3'd5: path = PathRAM[445:444];
                endcase
            end
            6'd2: begin
                case (npe)
                    3'd0: path = PathRAM[443:442];
                    3'd1: path = PathRAM[441:440];
                    3'd2: path = PathRAM[439:438];
                    3'd3: path = PathRAM[437:436];
                    3'd4: path = PathRAM[435:434];
                    3'd5: path = PathRAM[433:432];
                endcase
            end
            6'd3: begin
                case (npe)
                    3'd0: path = PathRAM[431:430];
                    3'd1: path = PathRAM[429:428];
                    3'd2: path = PathRAM[427:426];
                    3'd3: path = PathRAM[425:424];
                    3'd4: path = PathRAM[423:422];
                    3'd5: path = PathRAM[421:420];
                endcase
            end
            6'd4: begin
                case (npe)
                    3'd0: path = PathRAM[419:418];
                    3'd1: path = PathRAM[417:416];
                    3'd2: path = PathRAM[415:414];
                    3'd3: path = PathRAM[413:412];
                    3'd4: path = PathRAM[411:410];
                    3'd5: path = PathRAM[409:408];
                endcase
            end
            6'd5: begin
                case (npe)
                    3'd0: path = PathRAM[407:406];
                    3'd1: path = PathRAM[405:404];
                    3'd2: path = PathRAM[403:402];
                    3'd3: path = PathRAM[401:400];
                    3'd4: path = PathRAM[399:398];
                    3'd5: path = PathRAM[397:396];
                endcase
            end
            6'd6: begin
                case (npe)
                    3'd0: path = PathRAM[395:394];
                    3'd1: path = PathRAM[393:392];
                    3'd2: path = PathRAM[391:390];
                    3'd3: path = PathRAM[389:388];
                    3'd4: path = PathRAM[387:386];
                    3'd5: path = PathRAM[385:384];
                endcase
            end
            6'd7: begin
                case (npe)
                    3'd0: path = PathRAM[383:382];
                    3'd1: path = PathRAM[381:380];
                    3'd2: path = PathRAM[379:378];
                    3'd3: path = PathRAM[377:376];
                    3'd4: path = PathRAM[375:374];
                    3'd5: path = PathRAM[373:372];
                endcase
            end
            6'd8: begin
                case (npe)
                    3'd0: path = PathRAM[371:370];
                    3'd1: path = PathRAM[369:368];
                    3'd2: path = PathRAM[367:366];
                    3'd3: path = PathRAM[365:364];
                    3'd4: path = PathRAM[363:362];
                    3'd5: path = PathRAM[361:360];
                endcase
            end
            6'd9: begin
                case (npe)
                    3'd0: path = PathRAM[359:358];
                    3'd1: path = PathRAM[357:356];
                    3'd2: path = PathRAM[355:354];
                    3'd3: path = PathRAM[353:352];
                    3'd4: path = PathRAM[351:350];
                    3'd5: path = PathRAM[349:348];
                endcase
            end
            6'd10: begin
                case (npe)
                    3'd0: path = PathRAM[347:346];
                    3'd1: path = PathRAM[345:344];
                    3'd2: path = PathRAM[343:342];
                    3'd3: path = PathRAM[341:340];
                    3'd4: path = PathRAM[339:338];
                    3'd5: path = PathRAM[337:336];
                endcase
            end
            6'd11: begin
                case (npe)
                    3'd0: path = PathRAM[335:334];
                    3'd1: path = PathRAM[333:332];
                    3'd2: path = PathRAM[331:330];
                    3'd3: path = PathRAM[329:328];
                    3'd4: path = PathRAM[327:326];
                    3'd5: path = PathRAM[325:324];
                endcase
            end
            6'd12: begin
                case (npe)
                    3'd0: path = PathRAM[323:322];
                    3'd1: path = PathRAM[321:320];
                    3'd2: path = PathRAM[319:318];
                    3'd3: path = PathRAM[317:316];
                    3'd4: path = PathRAM[315:314];
                    3'd5: path = PathRAM[313:312];
                endcase
            end
            6'd13: begin
                case (npe)
                    3'd0: path = PathRAM[311:310];
                    3'd1: path = PathRAM[309:308];
                    3'd2: path = PathRAM[307:306];
                    3'd3: path = PathRAM[305:304];
                    3'd4: path = PathRAM[303:302];
                    3'd5: path = PathRAM[301:300];
                endcase
            end
            6'd14: begin
                case (npe)
                    3'd0: path = PathRAM[299:298];
                    3'd1: path = PathRAM[297:296];
                    3'd2: path = PathRAM[295:294];
                    3'd3: path = PathRAM[293:292];
                    3'd4: path = PathRAM[291:290];
                    3'd5: path = PathRAM[289:288];
                endcase
            end
            6'd15: begin
                case (npe)
                    3'd0: path = PathRAM[287:286];
                    3'd1: path = PathRAM[285:284];
                    3'd2: path = PathRAM[283:282];
                    3'd3: path = PathRAM[281:280];
                    3'd4: path = PathRAM[279:278];
                    3'd5: path = PathRAM[277:276];
                endcase
            end
            6'd16: begin
                case (npe)
                    3'd0: path = PathRAM[275:274];
                    3'd1: path = PathRAM[273:272];
                    3'd2: path = PathRAM[271:270];
                    3'd3: path = PathRAM[269:268];
                    3'd4: path = PathRAM[267:266];
                    3'd5: path = PathRAM[265:264];
                endcase
            end
            6'd17: begin
                case (npe)
                    3'd0: path = PathRAM[263:262];
                    3'd1: path = PathRAM[261:260];
                    3'd2: path = PathRAM[259:258];
                    3'd3: path = PathRAM[257:256];
                    3'd4: path = PathRAM[255:254];
                    3'd5: path = PathRAM[253:252];
                endcase
            end
            6'd18: begin
                case (npe)
                    3'd0: path = PathRAM[251:250];
                    3'd1: path = PathRAM[249:248];
                    3'd2: path = PathRAM[247:246];
                    3'd3: path = PathRAM[245:244];
                    3'd4: path = PathRAM[243:242];
                    3'd5: path = PathRAM[241:240];
                endcase
            end
            6'd19: begin
                case (npe)
                    3'd0: path = PathRAM[239:238];
                    3'd1: path = PathRAM[237:236];
                    3'd2: path = PathRAM[235:234];
                    3'd3: path = PathRAM[233:232];
                    3'd4: path = PathRAM[231:230];
                    3'd5: path = PathRAM[229:228];
                endcase
            end
            6'd20: begin
                case (npe)
                    3'd0: path = PathRAM[227:226];
                    3'd1: path = PathRAM[225:224];
                    3'd2: path = PathRAM[223:222];
                    3'd3: path = PathRAM[221:220];
                    3'd4: path = PathRAM[219:218];
                    3'd5: path = PathRAM[217:216];
                endcase
            end
            6'd21: begin
                case (npe)
                    3'd0: path = PathRAM[215:214];
                    3'd1: path = PathRAM[213:212];
                    3'd2: path = PathRAM[211:210];
                    3'd3: path = PathRAM[209:208];
                    3'd4: path = PathRAM[207:206];
                    3'd5: path = PathRAM[205:204];
                endcase
            end
            6'd22: begin
                case (npe)
                    3'd0: path = PathRAM[203:202];
                    3'd1: path = PathRAM[201:200];
                    3'd2: path = PathRAM[199:198];
                    3'd3: path = PathRAM[197:196];
                    3'd4: path = PathRAM[195:194];
                    3'd5: path = PathRAM[193:192];
                endcase
            end
            6'd23: begin
                case (npe)
                    3'd0: path = PathRAM[191:190];
                    3'd1: path = PathRAM[189:188];
                    3'd2: path = PathRAM[187:186];
                    3'd3: path = PathRAM[185:184];
                    3'd4: path = PathRAM[183:182];
                    3'd5: path = PathRAM[181:180];
                endcase
            end
            6'd24: begin
                case (npe)
                    3'd0: path = PathRAM[179:178];
                    3'd1: path = PathRAM[177:176];
                    3'd2: path = PathRAM[175:174];
                    3'd3: path = PathRAM[173:172];
                    3'd4: path = PathRAM[171:170];
                    3'd5: path = PathRAM[169:168];
                endcase
            end
            6'd25: begin
                case (npe)
                    3'd0: path = PathRAM[167:166];
                    3'd1: path = PathRAM[165:164];
                    3'd2: path = PathRAM[163:162];
                    3'd3: path = PathRAM[161:160];
                    3'd4: path = PathRAM[159:158];
                    3'd5: path = PathRAM[157:156];
                endcase
            end
            6'd26: begin
                case (npe)
                    3'd0: path = PathRAM[155:154];
                    3'd1: path = PathRAM[153:152];
                    3'd2: path = PathRAM[151:150];
                    3'd3: path = PathRAM[149:148];
                    3'd4: path = PathRAM[147:146];
                    3'd5: path = PathRAM[145:144];
                endcase
            end
            6'd27: begin
                case (npe)
                    3'd0: path = PathRAM[143:142];
                    3'd1: path = PathRAM[141:140];
                    3'd2: path = PathRAM[139:138];
                    3'd3: path = PathRAM[137:136];
                    3'd4: path = PathRAM[135:134];
                    3'd5: path = PathRAM[133:132];
                endcase
            end
            6'd28: begin
                case (npe)
                    3'd0: path = PathRAM[131:130];
                    3'd1: path = PathRAM[129:128];
                    3'd2: path = PathRAM[127:126];
                    3'd3: path = PathRAM[125:124];
                    3'd4: path = PathRAM[123:122];
                    3'd5: path = PathRAM[121:120];
                endcase
            end
            6'd29: begin
                case (npe)
                    3'd0: path = PathRAM[119:118];
                    3'd1: path = PathRAM[117:116];
                    3'd2: path = PathRAM[115:114];
                    3'd3: path = PathRAM[113:112];
                    3'd4: path = PathRAM[111:110];
                    3'd5: path = PathRAM[109:108];
                endcase
            end
            6'd30: begin
                case (npe)
                    3'd0: path = PathRAM[107:106];
                    3'd1: path = PathRAM[105:104];
                    3'd2: path = PathRAM[103:102];
                    3'd3: path = PathRAM[101:100];
                    3'd4: path = PathRAM[99:98];
                    3'd5: path = PathRAM[97:96];
                endcase
            end
            6'd31: begin
                case (npe)
                    3'd0: path = PathRAM[95:94];
                    3'd1: path = PathRAM[93:92];
                    3'd2: path = PathRAM[91:90];
                    3'd3: path = PathRAM[89:88];
                    3'd4: path = PathRAM[87:86];
                    3'd5: path = PathRAM[85:84];
                endcase
            end
            6'd32: begin
                case (npe)
                    3'd0: path = PathRAM[83:82];
                    3'd1: path = PathRAM[81:80];
                    3'd2: path = PathRAM[79:78];
                    3'd3: path = PathRAM[77:76];
                    3'd4: path = PathRAM[75:74];
                    3'd5: path = PathRAM[73:72];
                endcase
            end
            6'd33: begin
                case (npe)
                    3'd0: path = PathRAM[71:70];
                    3'd1: path = PathRAM[69:68];
                    3'd2: path = PathRAM[67:66];
                    3'd3: path = PathRAM[65:64];
                    3'd4: path = PathRAM[63:62];
                    3'd5: path = PathRAM[61:60];
                endcase
            end
            6'd34: begin
                case (npe)
                    3'd0: path = PathRAM[59:58];
                    3'd1: path = PathRAM[57:56];
                    3'd2: path = PathRAM[55:54];
                    3'd3: path = PathRAM[53:52];
                    3'd4: path = PathRAM[51:50];
                    3'd5: path = PathRAM[49:48];
                endcase
            end
            6'd35: begin
                case (npe)
                    3'd0: path = PathRAM[47:46];
                    3'd1: path = PathRAM[45:44];
                    3'd2: path = PathRAM[43:42];
                    3'd3: path = PathRAM[41:40];
                    3'd4: path = PathRAM[39:38];
                    3'd5: path = PathRAM[37:36];
                endcase
            end
            6'd36: begin
                case (npe)
                    3'd0: path = PathRAM[35:34];
                    3'd1: path = PathRAM[33:32];
                    3'd2: path = PathRAM[31:30];
                    3'd3: path = PathRAM[29:28];
                    3'd4: path = PathRAM[27:26];
                    3'd5: path = PathRAM[25:24];
                endcase
            end
            6'd37: begin
                case (npe)
                    3'd0: path = PathRAM[23:22];
                    3'd1: path = PathRAM[21:20];
                    3'd2: path = PathRAM[19:18];
                    3'd3: path = PathRAM[17:16];
                    3'd4: path = PathRAM[15:14];
                    3'd5: path = PathRAM[13:12];
                endcase
            end
            6'd38: begin
                case (npe)
                    3'd0: path = PathRAM[11:10];
                    3'd1: path = PathRAM[9:8];
                    3'd2: path = PathRAM[7:6];
                    3'd3: path = PathRAM[5:4];
                    3'd4: path = PathRAM[3:2];
                    3'd5: path = PathRAM[1:0];
                endcase
            end
        endcase
    end

    reg [15:0] result;
    always @ (posedge clk) begin
        if (~i_bt_ena)
            result <= D[63:48];
    end

    reg bt_ena;
    always @ (posedge clk) begin
        bt_ena <= i_bt_ena;
    end

    wire bt_start;
    assign bt_start = i_bt_ena & (~bt_ena);

    assign o_data = {3'b0, tindex, 3'b0, rindex,
        bt_start ? result : 16'b0};

endmodule

module verify_retake_v2 ( clk, n_rst, en, clr, inc, min, zro, max, acc );
  input [3:0] inc;
  output [11:0] acc;
  input clk, n_rst, en, clr;
  output min, zro, max;
  wire   n56, n58, n60, n62, n64, n66, n68, n70, n72, n74, n76, n78, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201;

  DFFSR \acc_reg[0]  ( .D(n78), .CLK(clk), .R(1'b1), .S(n_rst), .Q(acc[0]) );
  DFFSR \acc_reg[9]  ( .D(n76), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[9]) );
  DFFSR \acc_reg[8]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[8]) );
  DFFSR \acc_reg[7]  ( .D(n72), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[7]) );
  DFFSR \acc_reg[6]  ( .D(n70), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[6]) );
  DFFSR \acc_reg[5]  ( .D(n68), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[5]) );
  DFFSR \acc_reg[4]  ( .D(n66), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[4]) );
  DFFSR \acc_reg[3]  ( .D(n64), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[3]) );
  DFFSR \acc_reg[2]  ( .D(n62), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[2]) );
  DFFSR \acc_reg[1]  ( .D(n60), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[1]) );
  DFFSR \acc_reg[10]  ( .D(n58), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[10])
         );
  DFFSR \acc_reg[11]  ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(acc[11])
         );
  NOR2X1 U80 ( .A(acc[11]), .B(n82), .Y(zro) );
  OAI21X1 U81 ( .A(n83), .B(n84), .C(n85), .Y(n78) );
  OAI21X1 U82 ( .A(n86), .B(n87), .C(en), .Y(n85) );
  OAI21X1 U83 ( .A(n88), .B(n89), .C(n90), .Y(n87) );
  NAND2X1 U84 ( .A(n84), .B(n91), .Y(n89) );
  NOR2X1 U85 ( .A(n92), .B(n93), .Y(n86) );
  INVX1 U86 ( .A(n94), .Y(n83) );
  OAI21X1 U87 ( .A(n91), .B(n88), .C(en), .Y(n94) );
  INVX1 U88 ( .A(n95), .Y(n88) );
  INVX1 U89 ( .A(inc[0]), .Y(n91) );
  NAND2X1 U90 ( .A(n96), .B(n97), .Y(n76) );
  MUX2X1 U91 ( .B(n98), .A(n99), .S(acc[9]), .Y(n96) );
  NAND2X1 U92 ( .A(n100), .B(en), .Y(n99) );
  MUX2X1 U93 ( .B(n101), .A(n102), .S(n103), .Y(n100) );
  MUX2X1 U94 ( .B(n104), .A(n105), .S(n103), .Y(n98) );
  NAND2X1 U95 ( .A(n106), .B(n97), .Y(n74) );
  MUX2X1 U96 ( .B(n107), .A(n108), .S(acc[8]), .Y(n106) );
  NAND2X1 U97 ( .A(n109), .B(en), .Y(n108) );
  MUX2X1 U98 ( .B(n101), .A(n102), .S(n110), .Y(n109) );
  MUX2X1 U99 ( .B(n104), .A(n105), .S(n110), .Y(n107) );
  NAND2X1 U100 ( .A(n111), .B(n97), .Y(n72) );
  MUX2X1 U101 ( .B(n112), .A(n113), .S(acc[7]), .Y(n111) );
  NAND2X1 U102 ( .A(n114), .B(en), .Y(n113) );
  MUX2X1 U103 ( .B(n101), .A(n102), .S(n115), .Y(n114) );
  MUX2X1 U104 ( .B(n104), .A(n105), .S(n115), .Y(n112) );
  NAND2X1 U105 ( .A(n116), .B(n97), .Y(n70) );
  MUX2X1 U106 ( .B(n117), .A(n118), .S(acc[6]), .Y(n116) );
  NAND2X1 U107 ( .A(n119), .B(en), .Y(n118) );
  MUX2X1 U108 ( .B(n101), .A(n102), .S(n120), .Y(n119) );
  MUX2X1 U109 ( .B(n104), .A(n105), .S(n120), .Y(n117) );
  NAND2X1 U110 ( .A(n121), .B(n97), .Y(n68) );
  MUX2X1 U111 ( .B(n122), .A(n123), .S(acc[5]), .Y(n121) );
  NAND2X1 U112 ( .A(n124), .B(en), .Y(n123) );
  MUX2X1 U113 ( .B(n101), .A(n102), .S(n125), .Y(n124) );
  MUX2X1 U114 ( .B(n104), .A(n105), .S(n125), .Y(n122) );
  NAND2X1 U115 ( .A(n126), .B(n97), .Y(n66) );
  MUX2X1 U116 ( .B(n127), .A(n128), .S(acc[4]), .Y(n126) );
  NAND2X1 U117 ( .A(n129), .B(en), .Y(n128) );
  MUX2X1 U118 ( .B(n101), .A(n102), .S(n130), .Y(n129) );
  MUX2X1 U119 ( .B(n104), .A(n105), .S(n130), .Y(n127) );
  OAI21X1 U120 ( .A(en), .B(n131), .C(n132), .Y(n64) );
  AOI21X1 U121 ( .A(n133), .B(n134), .C(n135), .Y(n132) );
  XOR2X1 U122 ( .A(n136), .B(n137), .Y(n134) );
  XOR2X1 U123 ( .A(n138), .B(acc[3]), .Y(n137) );
  OAI21X1 U124 ( .A(en), .B(n139), .C(n140), .Y(n62) );
  AOI21X1 U125 ( .A(n141), .B(n133), .C(n135), .Y(n140) );
  XNOR2X1 U126 ( .A(n142), .B(n143), .Y(n141) );
  XOR2X1 U127 ( .A(n144), .B(n139), .Y(n142) );
  OAI21X1 U128 ( .A(en), .B(n145), .C(n146), .Y(n60) );
  AOI21X1 U129 ( .A(n133), .B(n147), .C(n135), .Y(n146) );
  INVX1 U130 ( .A(n97), .Y(n135) );
  XOR2X1 U131 ( .A(n148), .B(n149), .Y(n147) );
  XOR2X1 U132 ( .A(acc[1]), .B(n150), .Y(n149) );
  INVX1 U133 ( .A(acc[1]), .Y(n145) );
  NAND2X1 U134 ( .A(n151), .B(n97), .Y(n58) );
  NAND3X1 U135 ( .A(n152), .B(n153), .C(n133), .Y(n97) );
  INVX1 U136 ( .A(n92), .Y(n153) );
  MUX2X1 U137 ( .B(n154), .A(n155), .S(acc[10]), .Y(n151) );
  NAND2X1 U138 ( .A(n156), .B(en), .Y(n155) );
  MUX2X1 U139 ( .B(n101), .A(n102), .S(n157), .Y(n156) );
  INVX1 U140 ( .A(n104), .Y(n102) );
  INVX1 U141 ( .A(n105), .Y(n101) );
  MUX2X1 U142 ( .B(n104), .A(n105), .S(n157), .Y(n154) );
  NAND2X1 U143 ( .A(n133), .B(n158), .Y(n105) );
  NAND2X1 U144 ( .A(n133), .B(n159), .Y(n104) );
  INVX1 U145 ( .A(n160), .Y(n133) );
  NAND3X1 U146 ( .A(n95), .B(n90), .C(en), .Y(n160) );
  NAND2X1 U147 ( .A(n92), .B(n93), .Y(n95) );
  INVX1 U148 ( .A(n152), .Y(n93) );
  XOR2X1 U149 ( .A(n161), .B(n162), .Y(n152) );
  MUX2X1 U150 ( .B(n163), .A(n164), .S(en), .Y(n56) );
  NAND2X1 U151 ( .A(n92), .B(n90), .Y(n164) );
  INVX1 U152 ( .A(clr), .Y(n90) );
  XOR2X1 U153 ( .A(n165), .B(n162), .Y(n92) );
  XOR2X1 U154 ( .A(n158), .B(acc[11]), .Y(n162) );
  OAI21X1 U155 ( .A(n166), .B(n159), .C(n167), .Y(n165) );
  OAI21X1 U156 ( .A(n158), .B(n161), .C(acc[11]), .Y(n167) );
  INVX1 U157 ( .A(n161), .Y(n166) );
  OAI21X1 U158 ( .A(n157), .B(n159), .C(n168), .Y(n161) );
  OAI21X1 U159 ( .A(n158), .B(n169), .C(acc[10]), .Y(n168) );
  INVX1 U160 ( .A(n169), .Y(n157) );
  OAI21X1 U161 ( .A(n103), .B(n159), .C(n170), .Y(n169) );
  OAI21X1 U162 ( .A(n158), .B(n171), .C(acc[9]), .Y(n170) );
  INVX1 U163 ( .A(n171), .Y(n103) );
  OAI21X1 U164 ( .A(n110), .B(n159), .C(n172), .Y(n171) );
  OAI21X1 U165 ( .A(n158), .B(n173), .C(acc[8]), .Y(n172) );
  INVX1 U166 ( .A(n173), .Y(n110) );
  OAI21X1 U167 ( .A(n115), .B(n159), .C(n174), .Y(n173) );
  OAI21X1 U168 ( .A(n158), .B(n175), .C(acc[7]), .Y(n174) );
  INVX1 U169 ( .A(n175), .Y(n115) );
  OAI21X1 U170 ( .A(n120), .B(n159), .C(n176), .Y(n175) );
  OAI21X1 U171 ( .A(n158), .B(n177), .C(acc[6]), .Y(n176) );
  INVX1 U172 ( .A(n177), .Y(n120) );
  OAI21X1 U173 ( .A(n125), .B(n159), .C(n178), .Y(n177) );
  OAI21X1 U174 ( .A(n158), .B(n179), .C(acc[5]), .Y(n178) );
  INVX1 U175 ( .A(n179), .Y(n125) );
  OAI21X1 U176 ( .A(n130), .B(n159), .C(n180), .Y(n179) );
  OAI21X1 U177 ( .A(n158), .B(n181), .C(acc[4]), .Y(n180) );
  INVX1 U178 ( .A(n130), .Y(n181) );
  INVX1 U179 ( .A(n159), .Y(n158) );
  AOI21X1 U180 ( .A(n138), .B(n136), .C(n182), .Y(n130) );
  INVX1 U181 ( .A(n183), .Y(n182) );
  OAI21X1 U182 ( .A(n136), .B(n138), .C(acc[3]), .Y(n183) );
  OAI21X1 U183 ( .A(n144), .B(n143), .C(n184), .Y(n136) );
  INVX1 U184 ( .A(n185), .Y(n184) );
  AOI21X1 U185 ( .A(n143), .B(n144), .C(n139), .Y(n185) );
  XOR2X1 U186 ( .A(n186), .B(inc[2]), .Y(n143) );
  NAND2X1 U187 ( .A(inc[1]), .B(inc[0]), .Y(n186) );
  AOI21X1 U188 ( .A(n148), .B(n150), .C(n187), .Y(n144) );
  INVX1 U189 ( .A(n188), .Y(n187) );
  OAI21X1 U190 ( .A(n150), .B(n148), .C(acc[1]), .Y(n188) );
  NOR2X1 U191 ( .A(n84), .B(inc[0]), .Y(n150) );
  INVX1 U192 ( .A(acc[0]), .Y(n84) );
  XOR2X1 U193 ( .A(inc[1]), .B(inc[0]), .Y(n148) );
  OAI21X1 U194 ( .A(inc[3]), .B(n189), .C(n159), .Y(n138) );
  NAND2X1 U195 ( .A(inc[3]), .B(n189), .Y(n159) );
  NAND3X1 U196 ( .A(inc[1]), .B(inc[0]), .C(inc[2]), .Y(n189) );
  NOR2X1 U197 ( .A(n82), .B(n163), .Y(min) );
  NAND3X1 U198 ( .A(n190), .B(n191), .C(n192), .Y(n82) );
  AND2X1 U199 ( .A(n193), .B(n194), .Y(n192) );
  NOR3X1 U200 ( .A(acc[5]), .B(acc[6]), .C(acc[4]), .Y(n194) );
  NOR3X1 U201 ( .A(acc[8]), .B(acc[9]), .C(acc[7]), .Y(n193) );
  NOR2X1 U202 ( .A(acc[1]), .B(n195), .Y(n191) );
  NAND2X1 U203 ( .A(n139), .B(n131), .Y(n195) );
  INVX1 U204 ( .A(acc[3]), .Y(n131) );
  INVX1 U205 ( .A(acc[2]), .Y(n139) );
  NOR2X1 U206 ( .A(acc[10]), .B(acc[0]), .Y(n190) );
  AND2X1 U207 ( .A(n196), .B(n197), .Y(max) );
  NOR2X1 U208 ( .A(n198), .B(n199), .Y(n197) );
  NAND3X1 U209 ( .A(acc[3]), .B(acc[2]), .C(acc[4]), .Y(n199) );
  NAND3X1 U210 ( .A(acc[0]), .B(n163), .C(acc[1]), .Y(n198) );
  INVX1 U211 ( .A(acc[11]), .Y(n163) );
  NOR2X1 U212 ( .A(n200), .B(n201), .Y(n196) );
  NAND3X1 U213 ( .A(acc[9]), .B(acc[8]), .C(acc[10]), .Y(n201) );
  NAND3X1 U214 ( .A(acc[6]), .B(acc[5]), .C(acc[7]), .Y(n200) );
endmodule


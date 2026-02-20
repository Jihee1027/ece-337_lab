module verify_ptl_sp26v4 ( clk, n_rst, wen, ren, din, empty, close, full, dout
 );
  input [7:0] din;
  output [7:0] dout;
  input clk, n_rst, wen, ren;
  output empty, close, full;
  wire   \mem[4][7] , \mem[4][6] , \mem[4][5] , \mem[4][4] , \mem[4][3] ,
         \mem[4][2] , \mem[4][1] , \mem[4][0] , \mem[3][7] , \mem[3][6] ,
         \mem[3][5] , \mem[3][4] , \mem[3][3] , \mem[3][2] , \mem[3][1] ,
         \mem[3][0] , \mem[2][7] , \mem[2][6] , \mem[2][5] , \mem[2][4] ,
         \mem[2][3] , \mem[2][2] , \mem[2][1] , \mem[2][0] , \mem[1][7] ,
         \mem[1][6] , \mem[1][5] , \mem[1][4] , \mem[1][3] , \mem[1][2] ,
         \mem[1][1] , \mem[1][0] , \mem[0][7] , \mem[0][6] , \mem[0][5] ,
         \mem[0][4] , \mem[0][3] , \mem[0][2] , \mem[0][1] , \mem[0][0] , n129,
         n131, n133, n175, n177, n179, n180, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254,
         n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331,
         n332, n333, n334, n335, n336, n337, n338, n339, n340, n341;
  wire   [2:0] wptr;
  wire   [2:0] rptr;
  wire   [2:0] occ;

  DFFSR \wptr_reg[0]  ( .D(n179), .CLK(clk), .R(n_rst), .S(1'b1), .Q(wptr[0])
         );
  DFFSR \wptr_reg[1]  ( .D(n177), .CLK(clk), .R(n_rst), .S(1'b1), .Q(wptr[1])
         );
  DFFSR \wptr_reg[2]  ( .D(n175), .CLK(clk), .R(n_rst), .S(1'b1), .Q(wptr[2])
         );
  DFFSR \mem_reg[4][0]  ( .D(n208), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][0] ) );
  DFFSR \mem_reg[4][7]  ( .D(n207), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][7] ) );
  DFFSR \mem_reg[4][6]  ( .D(n206), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][6] ) );
  DFFSR \mem_reg[4][5]  ( .D(n205), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][5] ) );
  DFFSR \mem_reg[4][4]  ( .D(n204), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][4] ) );
  DFFSR \mem_reg[4][3]  ( .D(n203), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][3] ) );
  DFFSR \mem_reg[4][2]  ( .D(n202), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][2] ) );
  DFFSR \mem_reg[4][1]  ( .D(n201), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[4][1] ) );
  DFFSR \mem_reg[3][0]  ( .D(n187), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][0] ) );
  DFFSR \mem_reg[3][7]  ( .D(n180), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][7] ) );
  DFFSR \mem_reg[3][6]  ( .D(n181), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][6] ) );
  DFFSR \mem_reg[3][5]  ( .D(n182), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][5] ) );
  DFFSR \mem_reg[3][4]  ( .D(n183), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][4] ) );
  DFFSR \mem_reg[3][3]  ( .D(n184), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][3] ) );
  DFFSR \mem_reg[3][2]  ( .D(n185), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][2] ) );
  DFFSR \mem_reg[3][1]  ( .D(n186), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[3][1] ) );
  DFFSR \mem_reg[2][0]  ( .D(n195), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][0] ) );
  DFFSR \mem_reg[2][7]  ( .D(n188), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][7] ) );
  DFFSR \mem_reg[2][6]  ( .D(n189), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][6] ) );
  DFFSR \mem_reg[2][5]  ( .D(n190), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][5] ) );
  DFFSR \mem_reg[2][4]  ( .D(n191), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][4] ) );
  DFFSR \mem_reg[2][3]  ( .D(n192), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][3] ) );
  DFFSR \mem_reg[2][2]  ( .D(n193), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][2] ) );
  DFFSR \mem_reg[2][1]  ( .D(n194), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[2][1] ) );
  DFFSR \mem_reg[1][0]  ( .D(n216), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][0] ) );
  DFFSR \mem_reg[1][7]  ( .D(n215), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][7] ) );
  DFFSR \mem_reg[1][6]  ( .D(n214), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][6] ) );
  DFFSR \mem_reg[1][5]  ( .D(n213), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][5] ) );
  DFFSR \mem_reg[1][4]  ( .D(n212), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][4] ) );
  DFFSR \mem_reg[1][3]  ( .D(n211), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][3] ) );
  DFFSR \mem_reg[1][2]  ( .D(n210), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][2] ) );
  DFFSR \mem_reg[1][1]  ( .D(n209), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[1][1] ) );
  DFFSR \mem_reg[0][0]  ( .D(n224), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][0] ) );
  DFFSR \mem_reg[0][7]  ( .D(n223), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][7] ) );
  DFFSR \mem_reg[0][6]  ( .D(n222), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][6] ) );
  DFFSR \mem_reg[0][5]  ( .D(n221), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][5] ) );
  DFFSR \mem_reg[0][4]  ( .D(n220), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][4] ) );
  DFFSR \mem_reg[0][3]  ( .D(n219), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][3] ) );
  DFFSR \mem_reg[0][2]  ( .D(n218), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][2] ) );
  DFFSR \mem_reg[0][1]  ( .D(n217), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        \mem[0][1] ) );
  DFFSR \rptr_reg[0]  ( .D(n133), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rptr[0])
         );
  DFFSR \rptr_reg[1]  ( .D(n131), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rptr[1])
         );
  DFFSR \rptr_reg[2]  ( .D(n129), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rptr[2])
         );
  DFFSR \occ_reg[0]  ( .D(n200), .CLK(clk), .R(n_rst), .S(1'b1), .Q(occ[0]) );
  DFFSR \occ_reg[1]  ( .D(n199), .CLK(clk), .R(n_rst), .S(1'b1), .Q(occ[1]) );
  DFFSR \occ_reg[2]  ( .D(n198), .CLK(clk), .R(n_rst), .S(1'b1), .Q(occ[2]) );
  MUX2X1 U236 ( .B(n226), .A(n227), .S(n228), .Y(n224) );
  MUX2X1 U237 ( .B(n229), .A(n230), .S(n228), .Y(n223) );
  MUX2X1 U238 ( .B(n231), .A(n232), .S(n228), .Y(n222) );
  MUX2X1 U239 ( .B(n233), .A(n234), .S(n228), .Y(n221) );
  MUX2X1 U240 ( .B(n235), .A(n236), .S(n228), .Y(n220) );
  MUX2X1 U241 ( .B(n237), .A(n238), .S(n228), .Y(n219) );
  MUX2X1 U242 ( .B(n239), .A(n240), .S(n228), .Y(n218) );
  MUX2X1 U243 ( .B(n241), .A(n242), .S(n228), .Y(n217) );
  NAND3X1 U244 ( .A(n243), .B(n244), .C(n245), .Y(n228) );
  MUX2X1 U245 ( .B(n226), .A(n246), .S(n247), .Y(n216) );
  INVX1 U246 ( .A(\mem[1][0] ), .Y(n246) );
  MUX2X1 U247 ( .B(n229), .A(n248), .S(n247), .Y(n215) );
  INVX1 U248 ( .A(\mem[1][7] ), .Y(n248) );
  MUX2X1 U249 ( .B(n231), .A(n249), .S(n247), .Y(n214) );
  INVX1 U250 ( .A(\mem[1][6] ), .Y(n249) );
  MUX2X1 U251 ( .B(n233), .A(n250), .S(n247), .Y(n213) );
  INVX1 U252 ( .A(\mem[1][5] ), .Y(n250) );
  MUX2X1 U253 ( .B(n235), .A(n251), .S(n247), .Y(n212) );
  INVX1 U254 ( .A(\mem[1][4] ), .Y(n251) );
  MUX2X1 U255 ( .B(n237), .A(n252), .S(n247), .Y(n211) );
  INVX1 U256 ( .A(\mem[1][3] ), .Y(n252) );
  MUX2X1 U257 ( .B(n239), .A(n253), .S(n247), .Y(n210) );
  INVX1 U258 ( .A(\mem[1][2] ), .Y(n253) );
  MUX2X1 U259 ( .B(n241), .A(n254), .S(n247), .Y(n209) );
  NAND3X1 U260 ( .A(n243), .B(n244), .C(n255), .Y(n247) );
  INVX1 U261 ( .A(wptr[1]), .Y(n243) );
  INVX1 U262 ( .A(\mem[1][1] ), .Y(n254) );
  MUX2X1 U263 ( .B(n256), .A(n226), .S(n257), .Y(n208) );
  MUX2X1 U264 ( .B(n258), .A(n229), .S(n257), .Y(n207) );
  MUX2X1 U265 ( .B(n259), .A(n231), .S(n257), .Y(n206) );
  MUX2X1 U266 ( .B(n260), .A(n233), .S(n257), .Y(n205) );
  MUX2X1 U267 ( .B(n261), .A(n235), .S(n257), .Y(n204) );
  MUX2X1 U268 ( .B(n262), .A(n237), .S(n257), .Y(n203) );
  MUX2X1 U269 ( .B(n263), .A(n239), .S(n257), .Y(n202) );
  MUX2X1 U270 ( .B(n264), .A(n241), .S(n257), .Y(n201) );
  AND2X1 U271 ( .A(n265), .B(n245), .Y(n257) );
  XOR2X1 U272 ( .A(occ[0]), .B(n266), .Y(n200) );
  MUX2X1 U273 ( .B(n267), .A(n268), .S(occ[1]), .Y(n199) );
  AOI21X1 U274 ( .A(occ[0]), .B(ren), .C(n269), .Y(n268) );
  NAND2X1 U275 ( .A(n270), .B(n266), .Y(n267) );
  XOR2X1 U276 ( .A(ren), .B(occ[0]), .Y(n270) );
  OAI21X1 U277 ( .A(n271), .B(n272), .C(n273), .Y(n198) );
  OAI21X1 U278 ( .A(n269), .B(n274), .C(occ[2]), .Y(n273) );
  MUX2X1 U279 ( .B(n275), .A(n276), .S(occ[1]), .Y(n274) );
  OAI21X1 U280 ( .A(ren), .B(occ[0]), .C(n266), .Y(n269) );
  MUX2X1 U281 ( .B(close), .A(empty), .S(ren), .Y(n272) );
  INVX1 U282 ( .A(n266), .Y(n271) );
  XNOR2X1 U283 ( .A(n277), .B(ren), .Y(n266) );
  MUX2X1 U284 ( .B(n226), .A(n278), .S(n279), .Y(n195) );
  INVX1 U285 ( .A(\mem[2][0] ), .Y(n278) );
  MUX2X1 U286 ( .B(n241), .A(n280), .S(n279), .Y(n194) );
  INVX1 U287 ( .A(\mem[2][1] ), .Y(n280) );
  MUX2X1 U288 ( .B(n239), .A(n281), .S(n279), .Y(n193) );
  INVX1 U289 ( .A(\mem[2][2] ), .Y(n281) );
  MUX2X1 U290 ( .B(n237), .A(n282), .S(n279), .Y(n192) );
  INVX1 U291 ( .A(\mem[2][3] ), .Y(n282) );
  MUX2X1 U292 ( .B(n235), .A(n283), .S(n279), .Y(n191) );
  INVX1 U293 ( .A(\mem[2][4] ), .Y(n283) );
  MUX2X1 U294 ( .B(n233), .A(n284), .S(n279), .Y(n190) );
  INVX1 U295 ( .A(\mem[2][5] ), .Y(n284) );
  MUX2X1 U296 ( .B(n231), .A(n285), .S(n279), .Y(n189) );
  INVX1 U297 ( .A(\mem[2][6] ), .Y(n285) );
  MUX2X1 U298 ( .B(n229), .A(n286), .S(n279), .Y(n188) );
  NAND3X1 U299 ( .A(n245), .B(n244), .C(wptr[1]), .Y(n279) );
  INVX1 U300 ( .A(n287), .Y(n245) );
  INVX1 U301 ( .A(\mem[2][7] ), .Y(n286) );
  MUX2X1 U302 ( .B(n226), .A(n288), .S(n289), .Y(n187) );
  INVX1 U303 ( .A(din[0]), .Y(n226) );
  MUX2X1 U304 ( .B(n241), .A(n290), .S(n289), .Y(n186) );
  INVX1 U305 ( .A(din[1]), .Y(n241) );
  MUX2X1 U306 ( .B(n239), .A(n291), .S(n289), .Y(n185) );
  INVX1 U307 ( .A(din[2]), .Y(n239) );
  MUX2X1 U308 ( .B(n237), .A(n292), .S(n289), .Y(n184) );
  INVX1 U309 ( .A(din[3]), .Y(n237) );
  MUX2X1 U310 ( .B(n235), .A(n293), .S(n289), .Y(n183) );
  INVX1 U311 ( .A(din[4]), .Y(n235) );
  MUX2X1 U312 ( .B(n233), .A(n294), .S(n289), .Y(n182) );
  INVX1 U313 ( .A(din[5]), .Y(n233) );
  MUX2X1 U314 ( .B(n231), .A(n295), .S(n289), .Y(n181) );
  INVX1 U315 ( .A(din[6]), .Y(n231) );
  MUX2X1 U316 ( .B(n229), .A(n296), .S(n289), .Y(n180) );
  INVX1 U317 ( .A(din[7]), .Y(n229) );
  OAI22X1 U318 ( .A(wen), .B(n297), .C(n265), .D(n287), .Y(n179) );
  NAND2X1 U319 ( .A(wen), .B(n297), .Y(n287) );
  NOR2X1 U320 ( .A(n244), .B(wptr[1]), .Y(n265) );
  XOR2X1 U321 ( .A(wptr[1]), .B(n255), .Y(n177) );
  NAND2X1 U322 ( .A(n289), .B(n298), .Y(n175) );
  OAI21X1 U323 ( .A(n277), .B(n299), .C(wptr[2]), .Y(n298) );
  XOR2X1 U324 ( .A(wptr[1]), .B(wptr[0]), .Y(n299) );
  NAND3X1 U325 ( .A(n255), .B(n244), .C(wptr[1]), .Y(n289) );
  INVX1 U326 ( .A(wptr[2]), .Y(n244) );
  NOR2X1 U327 ( .A(n297), .B(n277), .Y(n255) );
  INVX1 U328 ( .A(wen), .Y(n277) );
  INVX1 U329 ( .A(wptr[0]), .Y(n297) );
  MUX2X1 U330 ( .B(n300), .A(n301), .S(ren), .Y(n133) );
  AOI21X1 U331 ( .A(n300), .B(n302), .C(n303), .Y(n301) );
  NAND2X1 U332 ( .A(n304), .B(n305), .Y(n131) );
  MUX2X1 U333 ( .B(rptr[1]), .A(n306), .S(ren), .Y(n304) );
  MUX2X1 U334 ( .B(n307), .A(n308), .S(rptr[2]), .Y(n129) );
  NOR2X1 U335 ( .A(n276), .B(n309), .Y(n308) );
  OR2X1 U336 ( .A(n306), .B(n303), .Y(n309) );
  OR2X1 U337 ( .A(n310), .B(n276), .Y(n307) );
  INVX1 U338 ( .A(ren), .Y(n276) );
  NOR2X1 U339 ( .A(n311), .B(n312), .Y(full) );
  NAND2X1 U340 ( .A(n275), .B(n313), .Y(n312) );
  INVX1 U341 ( .A(n314), .Y(empty) );
  NAND3X1 U342 ( .A(n313), .B(n311), .C(n275), .Y(n314) );
  INVX1 U343 ( .A(occ[0]), .Y(n275) );
  INVX1 U344 ( .A(occ[1]), .Y(n313) );
  OR2X1 U345 ( .A(n315), .B(n316), .Y(dout[7]) );
  OAI22X1 U346 ( .A(n258), .B(n302), .C(n296), .D(n310), .Y(n316) );
  INVX1 U347 ( .A(\mem[3][7] ), .Y(n296) );
  INVX1 U348 ( .A(\mem[4][7] ), .Y(n258) );
  OAI21X1 U349 ( .A(n230), .B(n317), .C(n318), .Y(n315) );
  AOI22X1 U350 ( .A(n306), .B(\mem[1][7] ), .C(n303), .D(\mem[2][7] ), .Y(n318) );
  INVX1 U351 ( .A(\mem[0][7] ), .Y(n230) );
  OR2X1 U352 ( .A(n319), .B(n320), .Y(dout[6]) );
  OAI22X1 U353 ( .A(n259), .B(n302), .C(n295), .D(n310), .Y(n320) );
  INVX1 U354 ( .A(\mem[3][6] ), .Y(n295) );
  INVX1 U355 ( .A(\mem[4][6] ), .Y(n259) );
  OAI21X1 U356 ( .A(n232), .B(n317), .C(n321), .Y(n319) );
  AOI22X1 U357 ( .A(n306), .B(\mem[1][6] ), .C(n303), .D(\mem[2][6] ), .Y(n321) );
  INVX1 U358 ( .A(\mem[0][6] ), .Y(n232) );
  OR2X1 U359 ( .A(n322), .B(n323), .Y(dout[5]) );
  OAI22X1 U360 ( .A(n260), .B(n302), .C(n294), .D(n310), .Y(n323) );
  INVX1 U361 ( .A(\mem[3][5] ), .Y(n294) );
  INVX1 U362 ( .A(\mem[4][5] ), .Y(n260) );
  OAI21X1 U363 ( .A(n234), .B(n317), .C(n324), .Y(n322) );
  AOI22X1 U364 ( .A(n306), .B(\mem[1][5] ), .C(n303), .D(\mem[2][5] ), .Y(n324) );
  INVX1 U365 ( .A(\mem[0][5] ), .Y(n234) );
  OR2X1 U366 ( .A(n325), .B(n326), .Y(dout[4]) );
  OAI22X1 U367 ( .A(n261), .B(n302), .C(n293), .D(n310), .Y(n326) );
  INVX1 U368 ( .A(\mem[3][4] ), .Y(n293) );
  INVX1 U369 ( .A(\mem[4][4] ), .Y(n261) );
  OAI21X1 U370 ( .A(n236), .B(n317), .C(n327), .Y(n325) );
  AOI22X1 U371 ( .A(n306), .B(\mem[1][4] ), .C(n303), .D(\mem[2][4] ), .Y(n327) );
  INVX1 U372 ( .A(\mem[0][4] ), .Y(n236) );
  OR2X1 U373 ( .A(n328), .B(n329), .Y(dout[3]) );
  OAI22X1 U374 ( .A(n262), .B(n302), .C(n292), .D(n310), .Y(n329) );
  INVX1 U375 ( .A(\mem[3][3] ), .Y(n292) );
  INVX1 U376 ( .A(\mem[4][3] ), .Y(n262) );
  OAI21X1 U377 ( .A(n238), .B(n317), .C(n330), .Y(n328) );
  AOI22X1 U378 ( .A(n306), .B(\mem[1][3] ), .C(n303), .D(\mem[2][3] ), .Y(n330) );
  INVX1 U379 ( .A(\mem[0][3] ), .Y(n238) );
  OR2X1 U380 ( .A(n331), .B(n332), .Y(dout[2]) );
  OAI22X1 U381 ( .A(n263), .B(n302), .C(n291), .D(n310), .Y(n332) );
  INVX1 U382 ( .A(\mem[3][2] ), .Y(n291) );
  INVX1 U383 ( .A(\mem[4][2] ), .Y(n263) );
  OAI21X1 U384 ( .A(n240), .B(n317), .C(n333), .Y(n331) );
  AOI22X1 U385 ( .A(n306), .B(\mem[1][2] ), .C(n303), .D(\mem[2][2] ), .Y(n333) );
  INVX1 U386 ( .A(\mem[0][2] ), .Y(n240) );
  OR2X1 U387 ( .A(n334), .B(n335), .Y(dout[1]) );
  OAI22X1 U388 ( .A(n264), .B(n302), .C(n290), .D(n310), .Y(n335) );
  INVX1 U389 ( .A(\mem[3][1] ), .Y(n290) );
  INVX1 U390 ( .A(\mem[4][1] ), .Y(n264) );
  OAI21X1 U391 ( .A(n242), .B(n317), .C(n336), .Y(n334) );
  AOI22X1 U392 ( .A(n306), .B(\mem[1][1] ), .C(n303), .D(\mem[2][1] ), .Y(n336) );
  INVX1 U393 ( .A(\mem[0][1] ), .Y(n242) );
  OR2X1 U394 ( .A(n337), .B(n338), .Y(dout[0]) );
  OAI22X1 U395 ( .A(n256), .B(n302), .C(n288), .D(n310), .Y(n338) );
  NAND2X1 U396 ( .A(rptr[0]), .B(rptr[1]), .Y(n310) );
  INVX1 U397 ( .A(\mem[3][0] ), .Y(n288) );
  INVX1 U398 ( .A(\mem[4][0] ), .Y(n256) );
  OAI21X1 U399 ( .A(n227), .B(n317), .C(n339), .Y(n337) );
  AOI22X1 U400 ( .A(n306), .B(\mem[1][0] ), .C(n303), .D(\mem[2][0] ), .Y(n339) );
  INVX1 U401 ( .A(n305), .Y(n303) );
  NAND2X1 U402 ( .A(rptr[1]), .B(n300), .Y(n305) );
  NOR2X1 U403 ( .A(n300), .B(rptr[1]), .Y(n306) );
  NAND3X1 U404 ( .A(n340), .B(n302), .C(n300), .Y(n317) );
  INVX1 U405 ( .A(rptr[0]), .Y(n300) );
  INVX1 U406 ( .A(rptr[2]), .Y(n302) );
  INVX1 U407 ( .A(rptr[1]), .Y(n340) );
  INVX1 U408 ( .A(\mem[0][0] ), .Y(n227) );
  INVX1 U409 ( .A(n341), .Y(close) );
  NAND3X1 U410 ( .A(occ[0]), .B(n311), .C(occ[1]), .Y(n341) );
  INVX1 U411 ( .A(occ[2]), .Y(n311) );
endmodule


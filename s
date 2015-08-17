`timescale 1ns/10ps



module g07Arbitrator(input sysClk,Breset,
    g07_if.Mstr m0,g07_if.Slave s0, // Master 0
    g07_if.Mstr m1,g07_if.Slave s1, // Master 1
    g07_if.Mstr m2,g07_if.Slave s2, // Master 2
    g07_if.Mstr m3,g07_if.Slave s3, // Master 3
    g07_if.Mstr m4,g07_if.Slave s4, // Master 4
    g07_if.Mstr m5,g07_if.Slave s5, // Master 5
    g07_if.Mstr m6,g07_if.Slave s6, // Master 6
    g07_if.Slave s7,	// Slave 0
    g07_if.Slave s8,	// Slave 1
    g07_if.Slave s9,	// Slave 2
    g07_if.Slave s10,	// Slave 3
    g07_if.Slave s11,	// Slave 4
    g07_if.Slave s12,	// Slave 5
    g07_if.Slave s13,	// Slave 6
    g07_if.Slave s14 	// Slave 7 
  );

reg[2:0] st,nx_st;

parameter[2:0] IDLE=000,mst0=001,mst1=010,mst2=011,mst3=100,mst4=101,mst5=110,mst6=111;
 


reg [63:0]addr_d;

reg tdone_d;
wire [14:0]sel;


assign s0.addr = s0.en?addr_d:s0.addr;
assign s1.addr = s1.en?addr_d:s1.addr;
assign s2.addr = s2.en?addr_d:s2.addr;
assign s3.addr = s3.en?addr_d:s3.addr;
assign s4.addr = s4.en?addr_d:s4.addr;
assign s5.addr = s5.en?addr_d:s5.addr;
assign s6.addr = s6.en?addr_d:s6.addr;
assign s7.addr = s7.en?addr_d:s7.addr;
assign s8.addr = s8.en?addr_d:s8.addr;
assign s9.addr = s9.en?addr_d:s9.addr;
assign s10.addr = s10.en?addr_d:s10.addr;
assign s11.addr = s11.en?addr_d:s11.addr;
assign s12.addr = s12.en?addr_d:s12.addr;
assign s13.addr = s13.en?addr_d:s13.addr;
assign s14.addr = s14.en?addr_d:s14.addr;


assign {s14.en,s13.en,s12.en,s11.en,s10.en,s9.en,s8.en,s7.en,s6.en,s5.en,s4.en,s3.en,s2.en,s1.en,s0.en}=sel;



decoder d(.addr_d(addr_d),.addr_s(sel));
decodertdone dt(.sel(sel),.sltdone(tdone_d),.slaveTdone({s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone}));




always @(negedge sysClk or negedge Breset)
begin
    if(Breset)
      begin
  	st<= #1 IDLE;
  	
 // $display("tdone_d1 %b",tdone_d);	
      end
  
    else
      begin
	st<= #1 nx_st;
	
	
//    $display("tdone_d2 %b",tdone_d);
      end
end

always @(*)
begin
  
	case(st)
	
	IDLE://0
		begin
			case({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b000_0001:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b000_0100:nx_st = mst2;
			7'b000_1000:nx_st = mst3;
			7'b001_0000:nx_st = mst4;
			7'b010_0000:nx_st = mst5;
			7'b100_0000:nx_st = mst6;
		//	7'b000_1011:nx_st = mst3;
		//	7'b101_0011:nx_st = mst4;
		//	7'b100_0111:nx_st = mst6;
		//	7'b001_0111:nx_st = mst4;
			default : nx_st = IDLE;
			endcase	
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			s0.en=0;
			s1.en=0;
			s3.en=0;
		//	$display("nx_st,tdone_d4 %b,%b",nx_st,tdone_d);
		end
	
	mst0://1
		begin	
			    //$display("nx_stmst0,tdone_d4mst0 %b,%b",nx_st,tdone_d);
					addr_d = m0.addrM64;
					
					//if(m0.need)

					  m0.ack = 1;
					//else
					//  nx_st = mst1;
					  
					if(tdone_d)
					begin
					  nx_st = IDLE;
					 
					end
					else
					nx_st = mst0;
		end
	
	mst1://2
		begin
					addr_d = m1.addrM64;
				//	if(m1.need)
					  m1.ack = 1;
				//	else
				//	  nx_st = mst2;
				
					if(tdone_d)
					begin
					nx_st = IDLE;
				//	s0.en= 0;
					
					end
					else
					nx_st = mst1;

		end
	mst2://3
		begin
					addr_d = m2.addrM64;
				//	if(m2.need)
					  m2.ack = 1;
				//	else
				//	  nx_st = mst3;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst2;

		end
	mst3://4
		begin
					addr_d = m3.addrM64;
				//	if(m3.need)
					  m3.ack = 1;
				//	else
				//	  nx_st = mst4;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst3;

		end
	mst4://5
		begin
					addr_d = m4.addrM64;
				//	if(m4.need)
					  m4.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst4;

		end
	mst5://6
		begin
					addr_d = m5.addrM64;
				//	if(m5.need)
					  m5.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
				
					end
					else
					nx_st = mst5;

		end
	mst6://7
		begin
					addr_d = m6.addrM64;
				//	if(m6.need)
					  m6.ack = 1;
				//	else
				//	  nx_st = mst0;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst6;

		end

	endcase
end
			
endmodule

module decoder(addr_d,addr_s);

input [63:0]addr_d;
output reg [14:0]addr_s;

  always_comb
    
    begin
      casez(addr_d) inside
      [64'hfffe7637 : 64'hfffe7643]:addr_s= 15'b000_0000_0000_0001;
      [64'hffffd325 : 64'hffffd382]:addr_s= 15'b000_0000_0000_0010;
      [64'hffff109e : 64'hffff115f]:addr_s= 15'b000_0000_0000_0100;
      [64'hffff428c : 64'hffff438a]:addr_s= 15'b000_0000_0000_1000;
      [64'hfffef204 : 64'hfffef295]:addr_s= 15'b000_0000_0001_0000;
      [64'hfffe740c : 64'hfffe74b1]:addr_s= 15'b000_0000_0010_0000;
      [64'hfffead20 : 64'hfffead52]:addr_s= 15'b000_0000_0100_0000;
      [64'hffff37c8 : 64'hffff38a2]:addr_s= 15'b000_0000_1000_0000;
      [64'hffffd9bc : 64'hffffda14]:addr_s= 15'b000_0001_0000_0000;
      [64'hffffad86 : 64'hffffadc9]:addr_s= 15'b000_0010_0000_0000;
      [64'hffffa294 : 64'hffffa345]:addr_s= 15'b000_0100_0000_0000;
      [64'hfffff7e5 : 64'hfffff89a]:addr_s= 15'b000_1000_0000_0000;
      [64'hffff5e9e : 64'hffff5f50]:addr_s= 15'b001_0000_0000_0000;
      [64'hffffb7b4 : 64'hffffb8a8]:addr_s= 15'b010_0000_0000_0000;
      [64'hffff4a19 : 64'hffff4b0d]:addr_s= 15'b100_0000_0000_0000;
     endcase
    end 
    endmodule


module decodertdone(sel,sltdone,slaveTdone);

input [14:0]sel;
input[14:0]slaveTdone;
output reg sltdone;


always_comb
  
    begin
      
      case(sel)
      15'b1000_0000_0000_000: sltdone =slaveTdone[14];
      15'b0100_0000_0000_000: sltdone =slaveTdone[13];
      15'b0010_0000_0000_000: sltdone =slaveTdone[12];
      15'b0001_0000_0000_000: sltdone =slaveTdone[11];
      15'b0000_1000_0000_000: sltdone =slaveTdone[10];
      15'b0000_0100_0000_000: sltdone =slaveTdone[9];
      15'b0000_0010_0000_000: sltdone =slaveTdone[8];
      15'b0000_0001_0000_000: sltdone =slaveTdone[7];
      15'b0000_0000_1000_000: sltdone =slaveTdone[6];
      15'b0000_0000_0100_000: sltdone =slaveTdone[5];
      15'b0000_0000_0010_000: sltdone =slaveTdone[4];
      15'b0000_0000_0001_000: sltdone =slaveTdone[3];
      15'b0000_0000_0000_100: sltdone =slaveTdone[2];
      15'b0000_0000_0000_010: sltdone =slaveTdone[1];
      15'b0000_0000_0000_001: sltdone =slaveTdone[0];
     endcase      
    
end

endmodule

`timescale 1ns/10ps



module g07Arbitrator(input sysClk,Breset,
    g07_if.Mstr m0,g07_if.Slave s0, // Master 0
    g07_if.Mstr m1,g07_if.Slave s1, // Master 1
    g07_if.Mstr m2,g07_if.Slave s2, // Master 2
    g07_if.Mstr m3,g07_if.Slave s3, // Master 3
    g07_if.Mstr m4,g07_if.Slave s4, // Master 4
    g07_if.Mstr m5,g07_if.Slave s5, // Master 5
    g07_if.Mstr m6,g07_if.Slave s6, // Master 6
    g07_if.Slave s7,	// Slave 0
    g07_if.Slave s8,	// Slave 1
    g07_if.Slave s9,	// Slave 2
    g07_if.Slave s10,	// Slave 3
    g07_if.Slave s11,	// Slave 4
    g07_if.Slave s12,	// Slave 5
    g07_if.Slave s13,	// Slave 6
    g07_if.Slave s14 	// Slave 7 
  );

reg[2:0] st,nx_st;

parameter[2:0] IDLE=000,mst0=001,mst1=010,mst2=011,mst3=100,mst4=101,mst5=110,mst6=111;
 


reg [63:0]addr_d;

reg tdone_d;
wire [14:0]sel;


assign s0.addr = s0.en?addr_d:s0.addr;
assign s1.addr = s1.en?addr_d:s1.addr;
assign s2.addr = s2.en?addr_d:s2.addr;
assign s3.addr = s3.en?addr_d:s3.addr;
assign s4.addr = s4.en?addr_d:s4.addr;
assign s5.addr = s5.en?addr_d:s5.addr;
assign s6.addr = s6.en?addr_d:s6.addr;
assign s7.addr = s7.en?addr_d:s7.addr;
assign s8.addr = s8.en?addr_d:s8.addr;
assign s9.addr = s9.en?addr_d:s9.addr;
assign s10.addr = s10.en?addr_d:s10.addr;
assign s11.addr = s11.en?addr_d:s11.addr;
assign s12.addr = s12.en?addr_d:s12.addr;
assign s13.addr = s13.en?addr_d:s13.addr;
assign s14.addr = s14.en?addr_d:s14.addr;


assign {s14.en,s13.en,s12.en,s11.en,s10.en,s9.en,s8.en,s7.en,s6.en,s5.en,s4.en,s3.en,s2.en,s1.en,s0.en}=sel;



decoder d(.addr_d(addr_d),.addr_s(sel));
decodertdone dt(.sel(sel),.sltdone(tdone_d),.slaveTdone({s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone}));




always @(negedge sysClk or negedge Breset)
begin
    if(Breset)
      begin
  	st<= #1 IDLE;
  	
 // $display("tdone_d1 %b",tdone_d);	
      end
  
    else
      begin
	st<= #1 nx_st;
	
	
//    $display("tdone_d2 %b",tdone_d);
      end
end

always @(*)
begin
  
	case(st)
	
	IDLE://0
		begin
			case({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b000_0001:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b000_0100:nx_st = mst2;
			7'b000_1000:nx_st = mst3;
			7'b001_0000:nx_st = mst4;
			7'b010_0000:nx_st = mst5;
			7'b100_0000:nx_st = mst6;
		//	7'b000_1011:nx_st = mst3;
		//	7'b101_0011:nx_st = mst4;
		//	7'b100_0111:nx_st = mst6;
		//	7'b001_0111:nx_st = mst4;
			default : nx_st = IDLE;
			endcase	
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			s0.en=0;
			s1.en=0;
			s3.en=0;
		//	$display("nx_st,tdone_d4 %b,%b",nx_st,tdone_d);
		end
	
	mst0://1
		begin	
			    //$display("nx_stmst0,tdone_d4mst0 %b,%b",nx_st,tdone_d);
					addr_d = m0.addrM64;
					
					//if(m0.need)

					  m0.ack = 1;
					//else
					//  nx_st = mst1;
					  
					if(tdone_d)
					begin
					  nx_st = IDLE;
					 
					end
					else
					nx_st = mst0;
		end
	
	mst1://2
		begin
					addr_d = m1.addrM64;
				//	if(m1.need)
					  m1.ack = 1;
				//	else
				//	  nx_st = mst2;
				
					if(tdone_d)
					begin
					nx_st = IDLE;
				//	s0.en= 0;
					
					end
					else
					nx_st = mst1;

		end
	mst2://3
		begin
					addr_d = m2.addrM64;
				//	if(m2.need)
					  m2.ack = 1;
				//	else
				//	  nx_st = mst3;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst2;

		end
	mst3://4
		begin
					addr_d = m3.addrM64;
				//	if(m3.need)
					  m3.ack = 1;
				//	else
				//	  nx_st = mst4;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst3;

		end
	mst4://5
		begin
					addr_d = m4.addrM64;
				//	if(m4.need)
					  m4.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst4;

		end
	mst5://6
		begin
					addr_d = m5.addrM64;
				//	if(m5.need)
					  m5.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
				
					end
					else
					nx_st = mst5;

		end
	mst6://7
		begin
					addr_d = m6.addrM64;
				//	if(m6.need)
					  m6.ack = 1;
				//	else
				//	  nx_st = mst0;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst6;

		end

	endcase
end
			
endmodule

module decoder(addr_d,addr_s);

input [63:0]addr_d;
output reg [14:0]addr_s;

  always_comb
    
    begin
      casez(addr_d) inside
      [64'hfffe7637 : 64'hfffe7643]:addr_s= 15'b000_0000_0000_0001;
      [64'hffffd325 : 64'hffffd382]:addr_s= 15'b000_0000_0000_0010;
      [64'hffff109e : 64'hffff115f]:addr_s= 15'b000_0000_0000_0100;
      [64'hffff428c : 64'hffff438a]:addr_s= 15'b000_0000_0000_1000;
      [64'hfffef204 : 64'hfffef295]:addr_s= 15'b000_0000_0001_0000;
      [64'hfffe740c : 64'hfffe74b1]:addr_s= 15'b000_0000_0010_0000;
      [64'hfffead20 : 64'hfffead52]:addr_s= 15'b000_0000_0100_0000;
      [64'hffff37c8 : 64'hffff38a2]:addr_s= 15'b000_0000_1000_0000;
      [64'hffffd9bc : 64'hffffda14]:addr_s= 15'b000_0001_0000_0000;
      [64'hffffad86 : 64'hffffadc9]:addr_s= 15'b000_0010_0000_0000;
      [64'hffffa294 : 64'hffffa345]:addr_s= 15'b000_0100_0000_0000;
      [64'hfffff7e5 : 64'hfffff89a]:addr_s= 15'b000_1000_0000_0000;
      [64'hffff5e9e : 64'hffff5f50]:addr_s= 15'b001_0000_0000_0000;
      [64'hffffb7b4 : 64'hffffb8a8]:addr_s= 15'b010_0000_0000_0000;
      [64'hffff4a19 : 64'hffff4b0d]:addr_s= 15'b100_0000_0000_0000;
     endcase
    end 
    endmodule


module decodertdone(sel,sltdone,slaveTdone);

input [14:0]sel;
input[14:0]slaveTdone;
output reg sltdone;


always_comb
  
    begin
      
      case(sel)
      15'b1000_0000_0000_000: sltdone =slaveTdone[14];
      15'b0100_0000_0000_000: sltdone =slaveTdone[13];
      15'b0010_0000_0000_000: sltdone =slaveTdone[12];
      15'b0001_0000_0000_000: sltdone =slaveTdone[11];
      15'b0000_1000_0000_000: sltdone =slaveTdone[10];
      15'b0000_0100_0000_000: sltdone =slaveTdone[9];
      15'b0000_0010_0000_000: sltdone =slaveTdone[8];
      15'b0000_0001_0000_000: sltdone =slaveTdone[7];
      15'b0000_0000_1000_000: sltdone =slaveTdone[6];
      15'b0000_0000_0100_000: sltdone =slaveTdone[5];
      15'b0000_0000_0010_000: sltdone =slaveTdone[4];
      15'b0000_0000_0001_000: sltdone =slaveTdone[3];
      15'b0000_0000_0000_100: sltdone =slaveTdone[2];
      15'b0000_0000_0000_010: sltdone =slaveTdone[1];
      15'b0000_0000_0000_001: sltdone =slaveTdone[0];
     endcase      
    
end

endmodule

`timescale 1ns/10ps



module g07Arbitrator(input sysClk,Breset,
    g07_if.Mstr m0,g07_if.Slave s0, // Master 0
    g07_if.Mstr m1,g07_if.Slave s1, // Master 1
    g07_if.Mstr m2,g07_if.Slave s2, // Master 2
    g07_if.Mstr m3,g07_if.Slave s3, // Master 3
    g07_if.Mstr m4,g07_if.Slave s4, // Master 4
    g07_if.Mstr m5,g07_if.Slave s5, // Master 5
    g07_if.Mstr m6,g07_if.Slave s6, // Master 6
    g07_if.Slave s7,	// Slave 0
    g07_if.Slave s8,	// Slave 1
    g07_if.Slave s9,	// Slave 2
    g07_if.Slave s10,	// Slave 3
    g07_if.Slave s11,	// Slave 4
    g07_if.Slave s12,	// Slave 5
    g07_if.Slave s13,	// Slave 6
    g07_if.Slave s14 	// Slave 7 
  );

reg[2:0] st,nx_st;

parameter[2:0] IDLE=000,mst0=001,mst1=010,mst2=011,mst3=100,mst4=101,mst5=110,mst6=111;
 


reg [63:0]addr_d;

reg tdone_d;
wire [14:0]sel;


assign s0.addr = s0.en?addr_d:s0.addr;
assign s1.addr = s1.en?addr_d:s1.addr;
assign s2.addr = s2.en?addr_d:s2.addr;
assign s3.addr = s3.en?addr_d:s3.addr;
assign s4.addr = s4.en?addr_d:s4.addr;
assign s5.addr = s5.en?addr_d:s5.addr;
assign s6.addr = s6.en?addr_d:s6.addr;
assign s7.addr = s7.en?addr_d:s7.addr;
assign s8.addr = s8.en?addr_d:s8.addr;
assign s9.addr = s9.en?addr_d:s9.addr;
assign s10.addr = s10.en?addr_d:s10.addr;
assign s11.addr = s11.en?addr_d:s11.addr;
assign s12.addr = s12.en?addr_d:s12.addr;
assign s13.addr = s13.en?addr_d:s13.addr;
assign s14.addr = s14.en?addr_d:s14.addr;


assign {s14.en,s13.en,s12.en,s11.en,s10.en,s9.en,s8.en,s7.en,s6.en,s5.en,s4.en,s3.en,s2.en,s1.en,s0.en}=sel;



decoder d(.addr_d(addr_d),.addr_s(sel));
decodertdone dt(.sel(sel),.sltdone(tdone_d),.slaveTdone({s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone}));




always @(negedge sysClk or negedge Breset)
begin
    if(Breset)
      begin
  	st<= #1 IDLE;
  	
 // $display("tdone_d1 %b",tdone_d);	
      end
  
    else
      begin
	st<= #1 nx_st;
	
	
//    $display("tdone_d2 %b",tdone_d);
      end
end

always @(*)
begin
  
	case(st)
	
	IDLE://0
		begin
			case({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b000_0001:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b000_0100:nx_st = mst2;
			7'b000_1000:nx_st = mst3;
			7'b001_0000:nx_st = mst4;
			7'b010_0000:nx_st = mst5;
			7'b100_0000:nx_st = mst6;
		//	7'b000_1011:nx_st = mst3;
		//	7'b101_0011:nx_st = mst4;
		//	7'b100_0111:nx_st = mst6;
		//	7'b001_0111:nx_st = mst4;
			default : nx_st = IDLE;
			endcase	
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			s0.en=0;
			s1.en=0;
			s3.en=0;
		//	$display("nx_st,tdone_d4 %b,%b",nx_st,tdone_d);
		end
	
	mst0://1
		begin	
			    //$display("nx_stmst0,tdone_d4mst0 %b,%b",nx_st,tdone_d);
					addr_d = m0.addrM64;
					
					//if(m0.need)

					  m0.ack = 1;
					//else
					//  nx_st = mst1;
					  
					if(tdone_d)
					begin
					  nx_st = IDLE;
					 
					end
					else
					nx_st = mst0;
		end
	
	mst1://2
		begin
					addr_d = m1.addrM64;
				//	if(m1.need)
					  m1.ack = 1;
				//	else
				//	  nx_st = mst2;
				
					if(tdone_d)
					begin
					nx_st = IDLE;
				//	s0.en= 0;
					
					end
					else
					nx_st = mst1;

		end
	mst2://3
		begin
					addr_d = m2.addrM64;
				//	if(m2.need)
					  m2.ack = 1;
				//	else
				//	  nx_st = mst3;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst2;

		end
	mst3://4
		begin
					addr_d = m3.addrM64;
				//	if(m3.need)
					  m3.ack = 1;
				//	else
				//	  nx_st = mst4;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst3;

		end
	mst4://5
		begin
					addr_d = m4.addrM64;
				//	if(m4.need)
					  m4.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst4;

		end
	mst5://6
		begin
					addr_d = m5.addrM64;
				//	if(m5.need)
					  m5.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
				
					end
					else
					nx_st = mst5;

		end
	mst6://7
		begin
					addr_d = m6.addrM64;
				//	if(m6.need)
					  m6.ack = 1;
				//	else
				//	  nx_st = mst0;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst6;

		end

	endcase
end
			
endmodule

module decoder(addr_d,addr_s);

input [63:0]addr_d;
output reg [14:0]addr_s;

  always_comb
    
    begin
      casez(addr_d) inside
      [64'hfffe7637 : 64'hfffe7643]:addr_s= 15'b000_0000_0000_0001;
      [64'hffffd325 : 64'hffffd382]:addr_s= 15'b000_0000_0000_0010;
      [64'hffff109e : 64'hffff115f]:addr_s= 15'b000_0000_0000_0100;
      [64'hffff428c : 64'hffff438a]:addr_s= 15'b000_0000_0000_1000;
      [64'hfffef204 : 64'hfffef295]:addr_s= 15'b000_0000_0001_0000;
      [64'hfffe740c : 64'hfffe74b1]:addr_s= 15'b000_0000_0010_0000;
      [64'hfffead20 : 64'hfffead52]:addr_s= 15'b000_0000_0100_0000;
      [64'hffff37c8 : 64'hffff38a2]:addr_s= 15'b000_0000_1000_0000;
      [64'hffffd9bc : 64'hffffda14]:addr_s= 15'b000_0001_0000_0000;
      [64'hffffad86 : 64'hffffadc9]:addr_s= 15'b000_0010_0000_0000;
      [64'hffffa294 : 64'hffffa345]:addr_s= 15'b000_0100_0000_0000;
      [64'hfffff7e5 : 64'hfffff89a]:addr_s= 15'b000_1000_0000_0000;
      [64'hffff5e9e : 64'hffff5f50]:addr_s= 15'b001_0000_0000_0000;
      [64'hffffb7b4 : 64'hffffb8a8]:addr_s= 15'b010_0000_0000_0000;
      [64'hffff4a19 : 64'hffff4b0d]:addr_s= 15'b100_0000_0000_0000;
     endcase
    end 
    endmodule


module decodertdone(sel,sltdone,slaveTdone);

input [14:0]sel;
input[14:0]slaveTdone;
output reg sltdone;


always_comb
  
    begin
      
      case(sel)
      15'b1000_0000_0000_000: sltdone =slaveTdone[14];
      15'b0100_0000_0000_000: sltdone =slaveTdone[13];
      15'b0010_0000_0000_000: sltdone =slaveTdone[12];
      15'b0001_0000_0000_000: sltdone =slaveTdone[11];
      15'b0000_1000_0000_000: sltdone =slaveTdone[10];
      15'b0000_0100_0000_000: sltdone =slaveTdone[9];
      15'b0000_0010_0000_000: sltdone =slaveTdone[8];
      15'b0000_0001_0000_000: sltdone =slaveTdone[7];
      15'b0000_0000_1000_000: sltdone =slaveTdone[6];
      15'b0000_0000_0100_000: sltdone =slaveTdone[5];
      15'b0000_0000_0010_000: sltdone =slaveTdone[4];
      15'b0000_0000_0001_000: sltdone =slaveTdone[3];
      15'b0000_0000_0000_100: sltdone =slaveTdone[2];
      15'b0000_0000_0000_010: sltdone =slaveTdone[1];
      15'b0000_0000_0000_001: sltdone =slaveTdone[0];
     endcase      
    
end

endmodule

`timescale 1ns/10ps



module g07Arbitrator(input sysClk,Breset,
    g07_if.Mstr m0,g07_if.Slave s0, // Master 0
    g07_if.Mstr m1,g07_if.Slave s1, // Master 1
    g07_if.Mstr m2,g07_if.Slave s2, // Master 2
    g07_if.Mstr m3,g07_if.Slave s3, // Master 3
    g07_if.Mstr m4,g07_if.Slave s4, // Master 4
    g07_if.Mstr m5,g07_if.Slave s5, // Master 5
    g07_if.Mstr m6,g07_if.Slave s6, // Master 6
    g07_if.Slave s7,	// Slave 0
    g07_if.Slave s8,	// Slave 1
    g07_if.Slave s9,	// Slave 2
    g07_if.Slave s10,	// Slave 3
    g07_if.Slave s11,	// Slave 4
    g07_if.Slave s12,	// Slave 5
    g07_if.Slave s13,	// Slave 6
    g07_if.Slave s14 	// Slave 7 
  );

reg[2:0] st,nx_st;

parameter[2:0] IDLE=000,mst0=001,mst1=010,mst2=011,mst3=100,mst4=101,mst5=110,mst6=111;
 


reg [63:0]addr_d;

reg tdone_d;
wire [14:0]sel;


assign s0.addr = s0.en?addr_d:s0.addr;
assign s1.addr = s1.en?addr_d:s1.addr;
assign s2.addr = s2.en?addr_d:s2.addr;
assign s3.addr = s3.en?addr_d:s3.addr;
assign s4.addr = s4.en?addr_d:s4.addr;
assign s5.addr = s5.en?addr_d:s5.addr;
assign s6.addr = s6.en?addr_d:s6.addr;
assign s7.addr = s7.en?addr_d:s7.addr;
assign s8.addr = s8.en?addr_d:s8.addr;
assign s9.addr = s9.en?addr_d:s9.addr;
assign s10.addr = s10.en?addr_d:s10.addr;
assign s11.addr = s11.en?addr_d:s11.addr;
assign s12.addr = s12.en?addr_d:s12.addr;
assign s13.addr = s13.en?addr_d:s13.addr;
assign s14.addr = s14.en?addr_d:s14.addr;


assign {s14.en,s13.en,s12.en,s11.en,s10.en,s9.en,s8.en,s7.en,s6.en,s5.en,s4.en,s3.en,s2.en,s1.en,s0.en}=sel;



decoder d(.addr_d(addr_d),.addr_s(sel));
decodertdone dt(.sel(sel),.sltdone(tdone_d),.slaveTdone({s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone}));




always @(negedge sysClk or negedge Breset)
begin
    if(Breset)
      begin
  	st<= #1 IDLE;
  	
 // $display("tdone_d1 %b",tdone_d);	
      end
  
    else
      begin
	st<= #1 nx_st;
	
	
//    $display("tdone_d2 %b",tdone_d);
      end
end

always @(*)
begin
  
	case(st)
	
	IDLE://0
		begin
			case({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b000_0001:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b000_0100:nx_st = mst2;
			7'b000_1000:nx_st = mst3;
			7'b001_0000:nx_st = mst4;
			7'b010_0000:nx_st = mst5;
			7'b100_0000:nx_st = mst6;
		//	7'b000_1011:nx_st = mst3;
		//	7'b101_0011:nx_st = mst4;
		//	7'b100_0111:nx_st = mst6;
		//	7'b001_0111:nx_st = mst4;
			default : nx_st = IDLE;
			endcase	
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			s0.en=0;
			s1.en=0;
			s3.en=0;
		//	$display("nx_st,tdone_d4 %b,%b",nx_st,tdone_d);
		end
	
	mst0://1
		begin	
			    //$display("nx_stmst0,tdone_d4mst0 %b,%b",nx_st,tdone_d);
					addr_d = m0.addrM64;
					
					//if(m0.need)

					  m0.ack = 1;
					//else
					//  nx_st = mst1;
					  
					if(tdone_d)
					begin
					  nx_st = IDLE;
					 
					end
					else
					nx_st = mst0;
		end
	
	mst1://2
		begin
					addr_d = m1.addrM64;
				//	if(m1.need)
					  m1.ack = 1;
				//	else
				//	  nx_st = mst2;
				
					if(tdone_d)
					begin
					nx_st = IDLE;
				//	s0.en= 0;
					
					end
					else
					nx_st = mst1;

		end
	mst2://3
		begin
					addr_d = m2.addrM64;
				//	if(m2.need)
					  m2.ack = 1;
				//	else
				//	  nx_st = mst3;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst2;

		end
	mst3://4
		begin
					addr_d = m3.addrM64;
				//	if(m3.need)
					  m3.ack = 1;
				//	else
				//	  nx_st = mst4;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst3;

		end
	mst4://5
		begin
					addr_d = m4.addrM64;
				//	if(m4.need)
					  m4.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst4;

		end
	mst5://6
		begin
					addr_d = m5.addrM64;
				//	if(m5.need)
					  m5.ack = 1;
				//	else
				//	  nx_st = mst5;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
				
					end
					else
					nx_st = mst5;

		end
	mst6://7
		begin
					addr_d = m6.addrM64;
				//	if(m6.need)
					  m6.ack = 1;
				//	else
				//	  nx_st = mst0;
					  
					if(tdone_d)
					begin
					nx_st = IDLE;
					
					end
					else
					nx_st = mst6;

		end

	endcase
end
			
endmodule

module decoder(addr_d,addr_s);

input [63:0]addr_d;
output reg [14:0]addr_s;

  always_comb
    
    begin
      casez(addr_d) inside
      [64'hfffe7637 : 64'hfffe7643]:addr_s= 15'b000_0000_0000_0001;
      [64'hffffd325 : 64'hffffd382]:addr_s= 15'b000_0000_0000_0010;
      [64'hffff109e : 64'hffff115f]:addr_s= 15'b000_0000_0000_0100;
      [64'hffff428c : 64'hffff438a]:addr_s= 15'b000_0000_0000_1000;
      [64'hfffef204 : 64'hfffef295]:addr_s= 15'b000_0000_0001_0000;
      [64'hfffe740c : 64'hfffe74b1]:addr_s= 15'b000_0000_0010_0000;
      [64'hfffead20 : 64'hfffead52]:addr_s= 15'b000_0000_0100_0000;
      [64'hffff37c8 : 64'hffff38a2]:addr_s= 15'b000_0000_1000_0000;
      [64'hffffd9bc : 64'hffffda14]:addr_s= 15'b000_0001_0000_0000;
      [64'hffffad86 : 64'hffffadc9]:addr_s= 15'b000_0010_0000_0000;
      [64'hffffa294 : 64'hffffa345]:addr_s= 15'b000_0100_0000_0000;
      [64'hfffff7e5 : 64'hfffff89a]:addr_s= 15'b000_1000_0000_0000;
      [64'hffff5e9e : 64'hffff5f50]:addr_s= 15'b001_0000_0000_0000;
      [64'hffffb7b4 : 64'hffffb8a8]:addr_s= 15'b010_0000_0000_0000;
      [64'hffff4a19 : 64'hffff4b0d]:addr_s= 15'b100_0000_0000_0000;
     endcase
    end 
    endmodule


module decodertdone(sel,sltdone,slaveTdone);

input [14:0]sel;
input[14:0]slaveTdone;
output reg sltdone;


always_comb
  
    begin
      
      case(sel)
      15'b1000_0000_0000_000: sltdone =slaveTdone[14];
      15'b0100_0000_0000_000: sltdone =slaveTdone[13];
      15'b0010_0000_0000_000: sltdone =slaveTdone[12];
      15'b0001_0000_0000_000: sltdone =slaveTdone[11];
      15'b0000_1000_0000_000: sltdone =slaveTdone[10];
      15'b0000_0100_0000_000: sltdone =slaveTdone[9];
      15'b0000_0010_0000_000: sltdone =slaveTdone[8];
      15'b0000_0001_0000_000: sltdone =slaveTdone[7];
      15'b0000_0000_1000_000: sltdone =slaveTdone[6];
      15'b0000_0000_0100_000: sltdone =slaveTdone[5];
      15'b0000_0000_0010_000: sltdone =slaveTdone[4];
      15'b0000_0000_0001_000: sltdone =slaveTdone[3];
      15'b0000_0000_0000_100: sltdone =slaveTdone[2];
      15'b0000_0000_0000_010: sltdone =slaveTdone[1];
      15'b0000_0000_0000_001: sltdone =slaveTdone[0];
     endcase      
    
end

endmodule


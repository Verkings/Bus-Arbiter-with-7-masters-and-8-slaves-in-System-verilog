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

reg tdone,sltdone;
reg [14:0]sel,addr_s,slaveTdone;


assign slaveTdone = {s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone};


always @(negedge sysClk or negedge Breset)
begin
    if(Breset)
      begin
  	st<= #1 IDLE;
  	

      end
  
    else
      begin
	st<= #1 nx_st;
	
	
	

      end
end

always @(*)
begin
      
	case(st)
	
	IDLE://0
		begin
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b000_0001:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b000_0100:nx_st = mst2;
			7'b000_1000:nx_st = mst3;
			7'b001_0000:nx_st = mst4;
			7'b010_0000:nx_st = mst5;
			7'b100_0000:nx_st = mst6;
			
			7'b??1_????:nx_st = mst4;
			7'b??0_1???:nx_st = mst3;
			7'b1?0_0???:nx_st = mst6;
			7'b0?0_0??1:nx_st = mst0;
			7'b0?0_0?10:nx_st = mst1;
			7'b010_0?00:nx_st = mst5;
			
			
			/*
			7'b001_0010:nx_st = mst4;
			7'b001_0011:nx_st = mst4;
			7'b000_1011:nx_st = mst3;
			7'b001_1011:nx_st = mst4;
			7'b010_0111:nx_st = mst0;
			7'b010_0110:nx_st = mst1;
			7'b010_1100:nx_st = mst3;
			7'b010_0100:nx_st = mst2;
			7'b010_0010:nx_st = mst1;
			7'b011_0000:nx_st = mst4;
			7'b010_1110:nx_st = mst3;
			7'b110_0110:nx_st = mst6;
			7'b011_0110:nx_st = mst4;
			7'b110_0111:nx_st = mst6;
			7'b011_1111:nx_st = mst4;
			7'b010_1111:nx_st = mst3;
			7'b011_1101:nx_st = mst4;
			7'b010_1101:nx_st = mst3;
			7'b010_0101:nx_st = mst0;
			7'b011_0101:nx_st = mst4;
			7'b011_1000:nx_st = mst5; // 4
			7'b101_1000:nx_st = mst4;
			7'b100_1010:nx_st = mst3;
			7'b100_0010:nx_st = mst6;
			7'b000_0011:nx_st = mst0;
			7'b001_1010:nx_st = mst4;
			7'b000_1010:nx_st = mst3;
			7'b000_1001:nx_st = mst3;
			7'b100_0011:nx_st = mst6;
			7'b101_1100:nx_st = mst4;
			7'b100_1100:nx_st = mst3;
			7'b101_0100:nx_st = mst4;
			7'b111_1100:nx_st = mst4;
			7'b110_1101:nx_st = mst3;
			7'b100_0001:nx_st = mst6;
			7'b001_0110:nx_st = mst4;
			7'b000_0110:nx_st = mst1;
			7'b111_0100:nx_st = mst4;
			7'b110_0100:nx_st = mst6;
			7'b010_0001:nx_st = mst0;
			7'b010_1000:nx_st = mst3;
			7'b111_0000:nx_st = mst4;
			7'b110_0000:nx_st = mst6;
			7'b011_0010:nx_st = mst4;
			7'b101_0000:nx_st = mst4;
			7'b101_0010:nx_st = mst4;
			7'b001_1001:nx_st = mst4;
			7'b001_0001:nx_st = mst4;
			7'b100_0101:nx_st = mst6;
			7'b000_1101:nx_st = mst3;
			7'b010_1011:nx_st = mst3;
			7'b010_0011:nx_st = mst0;
			7'b011_1010:nx_st = mst4;
			7'b0101_010:nx_st = mst3;
			7'b1000_110:nx_st = mst6;
			7'b011_1100:nx_st = mst4;
			7'b111_1101:nx_st = mst4;
			7'b110_1111:nx_st = mst3;
			7'b111_1111:nx_st = mst4;
			7'b111_0111:nx_st = mst4;
			7'b011_0111:nx_st = mst4;
			7'b100_1001:nx_st = mst3;
			7'b000_1111:nx_st = mst3;
			7'b000_0111:nx_st = mst0;
			7'b001_1110:nx_st = mst4;
			7'b000_1110:nx_st = mst3;
			7'b010_1001:nx_st = mst3;
			7'b101_1010:nx_st = mst4;
			7'b111_1010:nx_st = mst4;
			7'b110_1010:nx_st = mst3;
			7'b111_0010:nx_st = mst4;
			7'b110_0010:nx_st = mst6;
			7'b111_1000:nx_st = mst4;
			7'b110_0011:nx_st = mst6;
			*/
			
			
			default : nx_st = IDLE;
			endcase	
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			
		
		end
	
	mst0://1
		begin	
				//	addr_d = m0.addrM64;
					
					m0.ack = 1;
				
					  
					if(|slaveTdone)begin
					  nx_st = IDLE;
					   m0.ack = 0; 
				  {s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					  end
					else
					nx_st = mst0;
		end
	
	mst1://2
		begin
				//	addr_d = m1.addrM64;
				
					  m1.ack = 1;
				
				
					if(|slaveTdone)
					  begin
					 m1.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					nx_st = IDLE;
					
					
					  end
					else
					nx_st = mst1;

		end
	mst2://3
		begin
				//	addr_d = m2.addrM64;
				
					  m2.ack = 1;
				
					  
					if(|slaveTdone)
					begin
					nx_st = IDLE;
					 m2.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					
					else
					nx_st = mst2;

		end
	mst3://4
		begin
				//	addr_d = m3.addrM64;
				
					  m3.ack = 1;
				
					  
					if(|slaveTdone)
					begin
					nx_st = IDLE;
					 m3.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					nx_st = mst3;

		end
	mst4://5
		begin
				//	addr_d = m4.addrM64;
					
					  m4.ack = 1;
				
					  
					if(|slaveTdone)
					begin
					nx_st = IDLE;
					m4.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					nx_st = mst4;

		end
	mst5://6
		begin
				//	addr_d = m5.addrM64;
				
					  m5.ack = 1;
				
					  
					if(|slaveTdone)
					begin
					nx_st = IDLE;
					 m5.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					nx_st = mst5;

		end
	mst6://7
		begin
				//	addr_d = m6.addrM64;
				
					 m6.ack = 1;
				
					  
					if(|slaveTdone)
					begin
					nx_st = IDLE;
					 m6.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					nx_st = mst6;
					

		end

	endcase
	
      case({m6.ack,m5.ack,m4.ack,m3.ack,m2.ack,m1.ack,m0.ack})
      7'b000_0001:addr_d = m0.addrM64;
      7'b000_0010:addr_d = m1.addrM64;
      7'b000_0100:addr_d = m2.addrM64;
      7'b000_1000:addr_d = m3.addrM64;
      7'b001_0000:addr_d = m4.addrM64;
      7'b010_0000:addr_d = m5.addrM64;
      7'b100_0000:addr_d = m6.addrM64;
      default : addr_d =0; 
                 
      endcase
      
      
           
      casez(addr_d) inside
      [64'hfffe7637 : 64'hfffe7643]:begin s0.addr= addr_d;s0.en = 1;end //sltdone = slaveTdone[0];end
      [64'hffffd325 : 64'hffffd382]:begin s1.addr= addr_d;s1.en = 1;end //sltdone = slaveTdone[1];end
      [64'hffff109e : 64'hffff115f]:begin s2.addr= addr_d;s2.en = 1;end //sltdone = slaveTdone[2];end
      [64'hffff428c : 64'hffff438a]:begin s3.addr= addr_d;s3.en = 1;end //sltdone = slaveTdone[3];end
      [64'hfffef204 : 64'hfffef295]:begin s4.addr= addr_d;s4.en = 1;end //sltdone = slaveTdone[4];end
      [64'hfffe740c : 64'hfffe74b1]:begin s5.addr= addr_d;s5.en = 1;end //sltdone = slaveTdone[5];end
      [64'hfffead20 : 64'hfffead52]:begin s6.addr= addr_d;s6.en = 1;end //sltdone = slaveTdone[6];end
      [64'hffff37c8 : 64'hffff38a2]:begin s7.addr= addr_d;s7.en = 1;end //sltdone = slaveTdone[7];end
      [64'hffffd9bc : 64'hffffda14]:begin s8.addr= addr_d;s8.en = 1;end //sltdone = slaveTdone[8];end
      [64'hffffad86 : 64'hffffadc9]:begin s9.addr= addr_d;s9.en = 1;end //sltdone = slaveTdone[9];end
      [64'hffffa294 : 64'hffffa345]:begin s10.addr= addr_d;s10.en = 1;end //sltdone = slaveTdone[10];end
      [64'hfffff7e5 : 64'hfffff89a]:begin s11.addr= addr_d;s11.en = 1;end //sltdone = slaveTdone[11];end
      [64'hffff5e9e : 64'hffff5f50]:begin s12.addr= addr_d;s12.en = 1;end //sltdone = slaveTdone[12];end
      [64'hffffb7b4 : 64'hffffb8a8]:begin s13.addr= addr_d;s13.en = 1;end //sltdone = slaveTdone[13];end
      [64'hffff4a19 : 64'hffff4b0d]:begin s14.addr= addr_d;s14.en = 1;end //sltdone = slaveTdone[14];end
      
    
     endcase
     
     
    
end
			
endmodule

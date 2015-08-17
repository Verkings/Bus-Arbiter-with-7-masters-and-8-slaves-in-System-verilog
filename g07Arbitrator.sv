`timescale 1ns/10ps



module g07Arbitrator(g07_if.CLKS c1,
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
 
reg [63:0]addr_d,data_mts,data_stm,data_stm_d;

reg tdone,sltdone;
reg [14:0]sel,addr_s,slaveTdone;

reg[6:0]counter,cnt0,cnt1,cnt2,cnt3,cnt4,cnt5,cnt6;
reg[6:0]counter_d,cnt0_d,cnt1_d,cnt2_d,cnt3_d,cnt4_d,cnt5_d,cnt6_d;

assign slaveTdone = {s14.Tdone,s13.Tdone,s12.Tdone,s11.Tdone,s10.Tdone,s9.Tdone,s8.Tdone,s7.Tdone,s6.Tdone,s5.Tdone,s4.Tdone,s3.Tdone,s2.Tdone,s1.Tdone,s0.Tdone};


always @(negedge c1.sysClk or posedge c1.Breset)
begin
    if(c1.Breset)
      begin
  	st<= #1 IDLE;
  	cnt0_d <= 0;
	cnt1_d <= 0;
	cnt2_d <= 0;
	cnt3_d <= 0;
	cnt4_d <= 0;
	cnt5_d <= 0;
	cnt6_d <= 0;
	
	
	counter_d <= 0;

      end
  
    else
      begin
	st<= #1 nx_st;
	
	data_stm_d <= data_stm;
	
	
	if(counter_d==99)
	begin
	counter_d <= 0;
	cnt0_d <= 0;
	cnt1_d <= 0;
	cnt2_d <= 0;
	cnt3_d <= 0;
	cnt4_d <= 0;
	cnt5_d <= 0;
	cnt6_d <= 0;
	end
	else
	begin
	
	
	
	counter_d <= counter;
	cnt0_d <= cnt0;
	cnt1_d <= cnt1;
	cnt2_d <= cnt2;
	cnt3_d <= cnt3;
	cnt4_d <= cnt4;
	cnt5_d <= cnt5;
	cnt6_d <= cnt6;
	
	end
	

	
	

	end
end

always @(*)
begin

if(c1.Breset)
begin
cnt0=0;
cnt1=0;
cnt2=0;
cnt3=0;
cnt4=0;
cnt5=0;
cnt6=0;
counter = 0;
s0.addr = 0; s1.addr = 0; s2.addr = 0; s3.addr = 0; s4.addr = 0; s5.addr = 0; s6.addr = 0;
	s7.addr = 0; s8.addr = 0; s9.addr = 0; s10.addr = 0; s11.addr = 0; s12.addr = 0; s13.addr = 0; s14.addr = 0;
{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
s0.SbusIn = 0; s1.SbusIn = 0; s2.SbusIn = 0; s3.SbusIn = 0; s4.SbusIn = 0; s5.SbusIn = 0; s6.SbusIn = 0;
		s7.SbusIn = 0; s8.SbusIn = 0; s9.SbusIn = 0; s10.SbusIn = 0; s11.SbusIn = 0; s12.SbusIn = 0; s13.SbusIn = 0; s14.SbusIn = 0;
		{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
		m0.MinData = 0; m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
		
		
		nx_st = IDLE;
		data_mts = 0;
		data_stm = 0;
end

else
  begin
	s0.addr = 0; s1.addr = 0; s2.addr = 0; s3.addr = 0; s4.addr = 0; s5.addr = 0; s6.addr = 0;
	s7.addr = 0; s8.addr = 0; s9.addr = 0; s10.addr = 0; s11.addr = 0; s12.addr = 0; s13.addr = 0; s14.addr = 0;
	{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
	s0.SbusIn = 0; s1.SbusIn = 0; s2.SbusIn = 0; s3.SbusIn = 0; s4.SbusIn = 0; s5.SbusIn = 0; s6.SbusIn = 0;
	s7.SbusIn = 0; s8.SbusIn = 0; s9.SbusIn = 0; s10.SbusIn = 0; s11.SbusIn = 0; s12.SbusIn = 0; s13.SbusIn = 0; s14.SbusIn = 0;
	{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
	m0.MinData = 0; m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
	
	
	nx_st = IDLE;
	data_mts = 0;
	data_stm = data_stm;
	
	
	
      if(counter_d == 99)
      begin
      	cnt0 = 0;
	cnt1 = 0;
	cnt2 = 0;
	cnt3 = 0;
	cnt4 = 0;
	cnt5 = 0;
	cnt6 = 0;
	counter=0;
	  end
      else
	begin
	cnt0 = cnt0_d;
	cnt1 = cnt1_d;
	cnt2 = cnt2_d;
	cnt3 = cnt3_d;
	cnt4 = cnt4_d;
	cnt5 = cnt5_d;
	cnt6 = cnt6_d;
	counter = counter_d;
	
	
	case(st)
	
	IDLE://0
		begin

			if({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need}==0)
			begin
			nx_st=IDLE;

			end
			else if(cnt4_d <= 24)
			begin
			
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b??1_????:nx_st = mst4;
			7'b??0_1???:nx_st = mst3;
			7'b1?0_0???:nx_st = mst6;
			7'b0?0_0??1:nx_st = mst0;
			7'b0?0_0?10:nx_st = mst1;
			7'b010_0000:nx_st = mst5;
			7'b0?0_0100:nx_st = mst2;
			default: nx_st = IDLE;
			endcase
			
			end
			
			else if (cnt3_d <= 18)
			begin
			
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b001_0000:nx_st = mst4;
			7'b???_1???:nx_st = mst3;
			7'b1??_0???:nx_st = mst6;
			7'b0??_0??1:nx_st = mst0;
			7'b0??_0?10:nx_st = mst1;
			7'b0??_0100:nx_st = mst2;
			7'b01?_0000:nx_st = mst5;
			default: nx_st = IDLE;
			
			endcase
			
			
			end
			
			else if (cnt6_d <= 15)
			begin
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b001_?000:nx_st = mst4;
			7'b000_1000:nx_st = mst3;
			7'b1??_????:nx_st = mst6;
			7'b0??_???1:nx_st = mst0;
			7'b0??_??10:nx_st = mst1;
			7'b01?_?000:nx_st = mst5;
			7'b0??_?100:nx_st = mst2;
			default: nx_st = IDLE;
			endcase
			
			end
			
			else if (cnt0_d <=14)
			begin
			
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b?01_?000:nx_st = mst4;
			7'b?00_1000:nx_st = mst3;
			7'b100_0000:nx_st = mst6;
			7'b???_???1:nx_st = mst0;
			7'b???_??10:nx_st = mst1;
			7'b???_?100:nx_st = mst2;
			7'b?1?_?000:nx_st = mst5;
			default: nx_st = IDLE;
			
			endcase
			end
			
			else if (cnt1_d <= 12)
			begin
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b?01_?00?:nx_st = mst4;
			7'b?00_100?:nx_st = mst3;
			7'b100_000?:nx_st = mst6;
			7'b000_0001:nx_st = mst0;
			7'b???_??1?:nx_st = mst1;
			7'b?1?_?00?:nx_st = mst5;
			7'b???_?10?:nx_st = mst2;
			default: nx_st = IDLE;
			
			endcase
			
			end
			
// 			else if (cnt2_d == cnt5_d)
			else if (cnt5_d <= 5)
			begin
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			7'b?01_?0??:nx_st = mst4;
			7'b?00_10??:nx_st = mst3;
			7'b100_00??:nx_st = mst6;
			7'b000_00?1:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b?1?_????:nx_st = mst5;
			7'b?0?_?1??:nx_st = mst2;
			default: nx_st = IDLE;
			endcase
			
			end
			else if (cnt2_d <= 40)
			begin
			
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b?01_?0??:nx_st = mst4;
			7'b?00_10??:nx_st = mst3;
			7'b100_00??:nx_st = mst6;
			7'b000_00?1:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b?1?_?0??:nx_st = mst5;
			7'b???_?1??:nx_st = mst2;
			default: nx_st = IDLE;
			
			endcase
			
			end
			
			else 
			

			
			begin
			
			
			casez({m6.need,m5.need,m4.need,m3.need,m2.need,m1.need,m0.need})
			
			7'b?01_?0??:nx_st = mst4;
			7'b?00_10??:nx_st = mst3;
			7'b100_00??:nx_st = mst6;
			7'b000_00?1:nx_st = mst0;
			7'b000_0010:nx_st = mst1;
			7'b?1?_?0??:nx_st = mst5;
			7'b???_?1??:nx_st = mst2;
			default: nx_st = IDLE;
			
			endcase
			
			end
			
			{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}=0;
			
		
		end
	
	mst0://1
		begin	
				
					
					{m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={1'b1,6'b0};
					m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
					m0.MinData = data_stm_d;
					
					
					
					if(|slaveTdone)
					begin
				
					cnt0=cnt0_d+1;

					counter = counter_d +1 ;
					nx_st = IDLE;
					m0.ack = 0; 
					
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end

					else
					begin
					nx_st = mst0;
					cnt0 = cnt0_d;
					counter = counter_d;
					end
		end
	
	mst1://2
		begin
				
				
					  {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={1'b0,1'b1,5'b0};
					  m0.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
					  m1.MinData = data_stm_d;
					  
					
					  
					if(|slaveTdone)
					  begin
					
					cnt1=cnt1_d+1;

					 
					  counter = counter_d +1 ;
					  m1.ack = 0; 
					  {s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					  nx_st = IDLE;
					  end
					else
					begin
					nx_st = mst1;
					cnt1 = cnt1_d;
					counter = counter_d;
					end

		end
	mst2://3
		begin
				
					  {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={1'b0,1'b0,1'b1,4'b0};
					  m1.MinData = 0; m0.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
					  m2.MinData = data_stm_d;
					  
					 
					  
					if(|slaveTdone)
					begin
					
					cnt2=cnt2_d+1;

					
					  counter = counter_d +1 ;
					nx_st = IDLE;
					 m2.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					
					else
					begin
					nx_st = mst2;
					cnt2=cnt2_d;
					counter = counter_d;
					end
	  
		end
	mst3://4
		begin
				
					  {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={3'b0,1'b1,3'b0};
					  m1.MinData = 0; m2.MinData = 0; m0.MinData = 0; m4.MinData = 0; m5.MinData = 0; m6.MinData = 0;
					  m3.ack = 1;
					  m3.MinData = data_stm_d;
					  
					
					  
					if(|slaveTdone)
					begin
				
					cnt3=cnt3_d+1;

					  
					  counter = counter_d +1 ;
					nx_st = IDLE;
					 m3.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					begin
					nx_st = mst3;
					cnt3=cnt3_d;
					counter = counter_d;
					end

		end
	mst4://5
		begin
				
					
					  {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={4'b0,1'b1,2'b0};
					  m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m0.MinData = 0; m5.MinData = 0; m6.MinData = 0;
					  m4.MinData = data_stm_d;
					  
					  
					  
					if(|slaveTdone)
					begin
					
					cnt4=cnt4_d+1;

					counter = counter_d +1 ;
					nx_st = IDLE;
					m4.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					begin
					nx_st = mst4;
					cnt4 = cnt4_d;
					counter = counter_d;
					end

		end
	mst5://6
		begin
				
					  {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={5'b0,1'b1,1'b0};
					  
					  m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m0.MinData = 0; m6.MinData = 0;
					  m5.MinData = data_stm_d;
					  
				
					  
					if(|slaveTdone)
					begin
					
					cnt5=cnt5_d+1;

					counter = counter_d +1 ;
					nx_st = IDLE;
					 m5.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					begin
					nx_st = mst5;
					cnt5 = cnt5_d;
					counter = counter_d;
					end

		end
	mst6://7
		begin
				
				
					 {m0.ack,m1.ack,m2.ack,m3.ack,m4.ack,m5.ack,m6.ack}={6'b0,1'b1};
					 m1.MinData = 0; m2.MinData = 0; m3.MinData = 0; m4.MinData = 0; m5.MinData = 0; m0.MinData = 0;
					 m6.MinData = data_stm_d;
					 
					
					 
					if(|slaveTdone)
					begin
				
					 cnt6=cnt6_d+1;

					 counter = counter_d +1 ;
					nx_st = IDLE;
					 m6.ack = 0; 
					{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
					end
					else
					begin
					nx_st = mst6;
					cnt6 = cnt6_d;
					counter = counter_d;
					end

		end

	endcase
     end	  
      case({m6.ack,m5.ack,m4.ack,m3.ack,m2.ack,m1.ack,m0.ack})
      7'b000_0001:begin addr_d = m0.addrM64;data_mts = m0.DoutM;end
      7'b000_0010:begin addr_d = m1.addrM64;data_mts = m1.DoutM;end
      7'b000_0100:begin addr_d = m2.addrM64;data_mts = m2.DoutM;end
      7'b000_1000:begin addr_d = m3.addrM64;data_mts = m3.DoutM;end
      7'b001_0000:begin addr_d = m4.addrM64;data_mts = m4.DoutM;end
      7'b010_0000:begin addr_d = m5.addrM64;data_mts = m5.DoutM;end
      7'b100_0000:begin addr_d = m6.addrM64;data_mts = m6.DoutM;end
      default : begin
		addr_d =0; 
		data_mts = 0;
		end
                 
      endcase
      
      
           
      case(addr_d[19:0]) inside
      [20'he7637 : 20'he7643]:begin s0.addr= addr_d; s0.en = 1; s0.SbusIn = data_mts; data_stm = s0.dbus_out;end 
      [20'hfd325 : 20'hfd382]:begin s1.addr= addr_d; s1.en = 1; s1.SbusIn = data_mts; data_stm = s1.dbus_out;end 
      [20'hf109e : 20'hf115f]:begin s2.addr= addr_d; s2.en = 1; s2.SbusIn = data_mts; data_stm = s2.dbus_out;end
      [20'hf428c : 20'hf438a]:begin s3.addr= addr_d; s3.en = 1; s3.SbusIn = data_mts; data_stm = s3.dbus_out;end 
      [20'hef204 : 20'hef295]:begin s4.addr= addr_d; s4.en = 1; s4.SbusIn = data_mts; data_stm = s4.dbus_out;end 
      [20'he740c : 20'he74b1]:begin s5.addr= addr_d; s5.en = 1; s5.SbusIn = data_mts; data_stm = s5.dbus_out;end 
      [20'head20 : 20'head52]:begin s6.addr= addr_d; s6.en = 1; s6.SbusIn = data_mts; data_stm = s6.dbus_out;end 
      [20'hf37c8 : 20'hf38a2]:begin s7.addr= addr_d; s7.en = 1; s7.SbusIn = data_mts; data_stm = s7.dbus_out;end 
      [20'hfd9bc : 20'hfda14]:begin s8.addr= addr_d; s8.en = 1; s8.SbusIn = data_mts; data_stm = s8.dbus_out;end 
      [20'hfad86 : 20'hfadc9]:begin s9.addr= addr_d; s9.en = 1; s9.SbusIn = data_mts; data_stm = s9.dbus_out;end 
      [20'hfa294 : 20'hfa345]:begin s10.addr= addr_d;s10.en = 1;s10.SbusIn = data_mts;data_stm = s10.dbus_out;end 
      [20'hff7e5 : 20'hff89a]:begin s11.addr= addr_d;s11.en = 1;s11.SbusIn = data_mts;data_stm = s11.dbus_out;end
      [20'hf5e9e : 20'hf5f50]:begin s12.addr= addr_d;s12.en = 1;s12.SbusIn = data_mts;data_stm = s12.dbus_out;end 
      [20'hfb7b4 : 20'hfb8a8]:begin s13.addr= addr_d;s13.en = 1;s13.SbusIn = data_mts;data_stm = s13.dbus_out;end 
      [20'hf4a19 : 20'hf4b0d]:begin s14.addr= addr_d;s14.en = 1;s14.SbusIn = data_mts;data_stm = s14.dbus_out;end
      default: begin
		s0.addr = 0; s1.addr = 0; s2.addr = 0; s3.addr = 0; s4.addr = 0; s5.addr = 0; s6.addr = 0;
		s7.addr = 0; s8.addr = 0; s9.addr = 0; s10.addr = 0; s11.addr = 0; s12.addr = 0; s13.addr = 0; s14.addr = 0;
		{s0.en,s1.en,s2.en,s3.en,s4.en,s5.en,s6.en,s7.en,s8.en,s9.en,s10.en,s11.en,s12.en,s13.en,s14.en}=0;
		s0.SbusIn = 0; s1.SbusIn = 0; s2.SbusIn = 0; s3.SbusIn = 0; s4.SbusIn = 0; s5.SbusIn = 0; s6.SbusIn = 0;
		s7.SbusIn = 0; s8.SbusIn = 0; s9.SbusIn = 0; s10.SbusIn = 0; s11.SbusIn = 0; s12.SbusIn = 0; s13.SbusIn = 0; s14.SbusIn = 0;
		data_stm = 0;
	       end
             
     endcase

  end
end			
endmodule

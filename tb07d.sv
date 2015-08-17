`timescale 1ns/10ps
// Interface definition
interface g07_if (input sysClk, input Breset);
  logic need,ack;
  logic [63:0] addr,addrM64;
  logic [63:0] SbusIn,dbus_out,MinData,DoutM;
  logic en,Tdone;

  modport CLKS(input sysClk,input Breset);

  modport Mstr(
        input need, output ack,
        input addrM64, output DoutM, input MinData,
        input Tdone
  );

  modport Slave(
        output addr, output SbusIn, input dbus_out,
        output en, output Tdone
  );

endinterface

module tbg07();
  logic sysClk,Breset;
class Master;
  logic [63:0] addrM64;
  rand logic [63:0] DoutM;
  virtual g07_if intf;
  int target;
  int tpercent;
  int NumWon;
  int InXfr,InXfrNext;
  int NumXfr;
  int targetSlave;
  logic [63:0] targetAddr;
  task CheckGrant;
    begin
      InXfr = InXfrNext;
      if(!InXfr && intf.need===1 && intf.ack===1) begin
        NumWon=NumWon+1;
        intf.need=0;
        InXfrNext=1;
      end
      if(InXfr===1) NumXfr=NumXfr+1;
      if(intf.Tdone===1 && InXfr) begin
        InXfrNext=0;
      end
    end
  endtask
  task startInterval;
    begin
      NumWon=0;
      InXfr=0;
      InXfrNext=0;
      NumXfr=0;
      intf.need=0;
    end
  endtask
  task pickRandomTarget;
    begin
      target = $urandom_range(14,0);
      randomize(addrM64) with { addrM64 >= slvs[target].AddrLow && addrM64 <= slvs[target].AddrHigh;};
    end
  endtask
endclass

class Slave;
  rand logic [63:0] dbus_out;
  virtual g07_if intf;
  logic [63:0] AddrLow;
  logic [63:0] AddrHigh;
  task setAddress(input logic [63:0] a,input logic [63:0] b);
    begin
    AddrLow=a;
    AddrHigh=b;
    end
  endtask
  task setSlaveData;
    begin
      intf.dbus_out=dbus_out;
    end
  endtask
  task xfrIt(input Master mst);
    int ix;
    begin
      ix=0;
      while((!intf.en) && ix++ < 500) ##1;
      if(ix >= 500) begin
        die("didn't get slave enable 'en'","");
      end
      repeat($urandom_range(1,5)) begin 
        ##1 #1;
        if(mst.intf.addrM64 !== this.intf.addr) begin
          die("Address didn't get to the slave","");
        end
        if(mst.intf.DoutM !== this.intf.SbusIn) begin
          die("Data to slave didn't work","");
        end
        if(mst.intf.MinData !== this.intf.dbus_out) begin
          die("Data from slave didn't work","");
        end
        mst.NumXfr=mst.NumXfr+1;
      end
      intf.Tdone=1;
      ##1 #1 intf.Tdone=0;
      mst.InXfr=0;
     mst.InXfrNext=0;
    end
  endtask
endclass

  logic debug=1;
    logic sadness=0;
  int totaldone;
  reg allreq=0;
  Master msts[];
  Slave  slvs[];
  g07_if mif00(sysClk,Breset);
  Master mc00;
  Slave msc00;
  g07_if mif01(sysClk,Breset);
  Master mc01;
  Slave msc01;
  g07_if mif02(sysClk,Breset);
  Master mc02;
  Slave msc02;
  g07_if mif03(sysClk,Breset);
  Master mc03;
  Slave msc03;
  g07_if mif04(sysClk,Breset);
  Master mc04;
  Slave msc04;
  g07_if mif05(sysClk,Breset);
  Master mc05;
  Slave msc05;
  g07_if mif06(sysClk,Breset);
  Master mc06;
  Slave msc06;
  g07_if sif00(sysClk,Breset);
  Slave sc00;
  g07_if sif01(sysClk,Breset);
  Slave sc01;
  g07_if sif02(sysClk,Breset);
  Slave sc02;
  g07_if sif03(sysClk,Breset);
  Slave sc03;
  g07_if sif04(sysClk,Breset);
  Slave sc04;
  g07_if sif05(sysClk,Breset);
  Slave sc05;
  g07_if sif06(sysClk,Breset);
  Slave sc06;
  g07_if sif07(sysClk,Breset);
  Slave sc07;
  int slaveTarget=999;
  int winningMaster=999;

  default clocking cb07 @(negedge(sysClk));
  endclocking

  initial begin
    sysClk=0;
    forever #5 sysClk=~sysClk;
  end

  initial begin
    Breset=0;
    msts=new[7];
    slvs=new[7+8];
    mc00=new;
    mc00.intf = mif00;
    msts[0]=mc00;
    msc00=new;
    msc00.intf = mif00;
    mc00.tpercent=15;
    msc00.intf.Tdone=0;
    slvs[0]=msc00;
    msc00.setAddress(64'hfffe7637,64'hfffe7643);
    mc01=new;
    mc01.intf = mif01;
    msts[1]=mc01;
    msc01=new;
    msc01.intf = mif01;
    mc01.tpercent=13;
    msc01.intf.Tdone=0;
    slvs[1]=msc01;
    msc01.setAddress(64'hffffd325,64'hffffd382);
    mc02=new;
    mc02.intf = mif02;
    msts[2]=mc02;
    msc02=new;
    msc02.intf = mif02;
    mc02.tpercent=6;
    msc02.intf.Tdone=0;
    slvs[2]=msc02;
    msc02.setAddress(64'hffff109e,64'hffff115f);
    mc03=new;
    mc03.intf = mif03;
    msts[3]=mc03;
    msc03=new;
    msc03.intf = mif03;
    mc03.tpercent=19;
    msc03.intf.Tdone=0;
    slvs[3]=msc03;
    msc03.setAddress(64'hffff428c,64'hffff438a);
    mc04=new;
    mc04.intf = mif04;
    msts[4]=mc04;
    msc04=new;
    msc04.intf = mif04;
    mc04.tpercent=25;
    msc04.intf.Tdone=0;
    slvs[4]=msc04;
    msc04.setAddress(64'hfffef204,64'hfffef295);
    mc05=new;
    mc05.intf = mif05;
    msts[5]=mc05;
    msc05=new;
    msc05.intf = mif05;
    mc05.tpercent=6;
    msc05.intf.Tdone=0;
    slvs[5]=msc05;
    msc05.setAddress(64'hfffe740c,64'hfffe74b1);
    mc06=new;
    mc06.intf = mif06;
    msts[6]=mc06;
    msc06=new;
    msc06.intf = mif06;
    mc06.tpercent=16;
    msc06.intf.Tdone=0;
    slvs[6]=msc06;
    msc06.setAddress(64'hfffead20,64'hfffead52);
    sc00=new;
    sc00.intf = sif00;
    sc00.setAddress(64'hffff37c8,64'hffff38a2);
    sc00.intf.Tdone=0;
    slvs[0+7]=sc00;
    sc01=new;
    sc01.intf = sif01;
    sc01.setAddress(64'hffffd9bc,64'hffffda14);
    sc01.intf.Tdone=0;
    slvs[1+7]=sc01;
    sc02=new;
    sc02.intf = sif02;
    sc02.setAddress(64'hffffad86,64'hffffadc9);
    sc02.intf.Tdone=0;
    slvs[2+7]=sc02;
    sc03=new;
    sc03.intf = sif03;
    sc03.setAddress(64'hffffa294,64'hffffa345);
    sc03.intf.Tdone=0;
    slvs[3+7]=sc03;
    sc04=new;
    sc04.intf = sif04;
    sc04.setAddress(64'hfffff7e5,64'hfffff89a);
    sc04.intf.Tdone=0;
    slvs[4+7]=sc04;
    sc05=new;
    sc05.intf = sif05;
    sc05.setAddress(64'hffff5e9e,64'hffff5f50);
    sc05.intf.Tdone=0;
    slvs[5+7]=sc05;
    sc06=new;
    sc06.intf = sif06;
    sc06.setAddress(64'hffffb7b4,64'hffffb8a8);
    sc06.intf.Tdone=0;
    slvs[6+7]=sc06;
    sc07=new;
    sc07.intf = sif07;
    sc07.setAddress(64'hffff4a19,64'hffff4b0d);
    sc07.intf.Tdone=0;
    slvs[7+7]=sc07;
    cleanInterval;
    #0.1 Breset=1;
    if(debug) begin
      $dumpfile("tbg07.vpd");
      $dumpvars(9,tbg07);
    end
    ##5 #1 Breset=0;
    ##2 #1; 
    cleanInterval;
    repeat(100) anInterval(0);
    stats;
    cleanInterval;
    allreq=1;
    repeat(100) anInterval(1);
    stats;
    if(sadness) die("You are off by more than 2 percent","");
    $display("I think it worked");
    $finish;
    ##5000 die("Ran out of time","Out of time");
    $finish;
  end

  g07Arbitrator arb(sysClk,Breset,
    mif00.Mstr,mif00.Slave, // Master 0
    mif01.Mstr,mif01.Slave, // Master 1
    mif02.Mstr,mif02.Slave, // Master 2
    mif03.Mstr,mif03.Slave, // Master 3
    mif04.Mstr,mif04.Slave, // Master 4
    mif05.Mstr,mif05.Slave, // Master 5
    mif06.Mstr,mif06.Slave, // Master 6
    sif00.Slave,	// Slave 0
    sif01.Slave,	// Slave 1
    sif02.Slave,	// Slave 2
    sif03.Slave,	// Slave 3
    sif04.Slave,	// Slave 4
    sif05.Slave,	// Slave 5
    sif06.Slave,	// Slave 6
    sif07.Slave 	// Slave 7
  );

  task die(input string e0,input string em);
    begin
      $display("\n\n\n=============== Error ==============\n");
      $display(e0);
      $error(em);
      $display("\n\n\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n");
      #10 $finish;
    end
  endtask
  task cleanInterval;
    int ix;
    begin
      totaldone=0;
      for(ix=0; ix < 7; ix=ix+1) begin
        msts[ix].startInterval;
      end
    end
  endtask
  task stats;
    int iq;
    real perWon;
    begin
      for(iq=0; iq < 7; iq=iq+1) begin
        totaldone += msts[iq].NumWon;
      end
      if(totaldone < 50) begin
        $display("Saw %d arbitrations",totaldone);
        die("Too few arbitrations done","");
      end
      $display("\n%d won in 10 sets",totaldone);
      $display("\n\tMst\tSim\t\tGoal");
      for(iq=0; iq < 7; iq=iq+1) begin
        perWon = msts[iq].NumWon;
        perWon = perWon/totaldone;
        perWon = perWon*100.0;
        $display("%d	%5.2f	%d	%5.2f",iq,perWon,msts[iq].tpercent,perWon-msts[iq].tpercent);
        if( (perWon-msts[iq].tpercent)< -2.0) begin
          sadness=1;
          $display("You lost it on %d",iq);
        end
      end
    end
  endtask;
  function logic isBusy(input int sn);
    int ix;
    begin
      if(sn > 998) begin
        for(ix=0; ix < 7; ix=ix+1) begin
          $display("Mstr %d InXfr %b",ix,msts[ix].InXfr);
        end
      end
      for(ix=0; ix < 7; ix=ix+1) begin
//        msts[ix].CheckGrant;
        if(msts[ix].InXfr) begin
          if(sn > 998) $display("Busy Master %d",ix);
          return 1;
        end
      end
      return 0;
    end
  endfunction
  function logic isResp;
    int ix;
    begin
      for(ix=0; ix < 7; ix=ix+1) begin
        if(msts[ix].intf.need===1 && msts[ix].intf.ack===1) begin
          slaveTarget=msts[ix].targetSlave;
          winningMaster=ix;
          msts[ix].CheckGrant;
          return 1'b1;
        end
      end
      return 1'b0;
    end
  endfunction
  task setReqs;
    int ix;
    int ixp,ixnp;
    begin
      for(ix=0; ix < 7; ix=ix+1) begin
        ixp=msts[ix].tpercent;
        ixnp=100-ixp;
        if(msts[ix].intf.need===0) begin
          msts[ix].targetSlave=$urandom_range(0,14);
          msts[ix].targetAddr = pickSlaveAddr(msts[ix].targetSlave);
          msts[ix].intf.addrM64 = msts[ix].targetAddr;
        end
        if(allreq) msts[ix].intf.need=1;
        else if(msts[ix].intf.need==0) randcase
          ixp: begin
            msts[ix].intf.need=1;
            msts[ix].targetSlave=$urandom_range(0,14);
            msts[ix].targetAddr = pickSlaveAddr(msts[ix].targetSlave);
            msts[ix].intf.addrM64 = msts[ix].targetAddr;
          end
          ixnp: msts[ix].intf.need=0;
        endcase
      end
    end
  endtask
  function logic ReqSet;
    int ix;
    begin
      for(ix=0; ix < 7; ix=ix+1) begin
        if(msts[ix].intf.need===1) return 1;
      end
    end
    ReqSet=0;
  endfunction
  function [63:0] pickSlaveAddr(input int sn);
    logic [63:0] wk;
    begin
      wk=$urandom_range(slvs[sn].AddrLow,slvs[sn].AddrHigh);
      pickSlaveAddr=wk;
    end
  endfunction
  task anInterval(input int tnum);
    int ix;
    int icnt;
    begin
      ##1 #1;
      ix=0;
      while(isBusy(ix) && ix < 1000) ##1 #1 ix=ix+1;
      if(ix >= 1000) die("Requests not Clearing","Clearing");
      icnt=0;
      ##1 #1;
      while(icnt < 500 || ReqSet() ) begin
        if(icnt < 500 ) setReqs;
        if(ReqSet()) begin
          for( ix=0; (ix < 1000) && (!isResp()); ix=ix+1) ##1 #1;
          if(ix >= 1000) die("Response didn't happen","response");
          icnt=icnt+1;
	  msts[winningMaster].intf.need=0;
          slvs[slaveTarget].xfrIt(msts[winningMaster]);
        end
      end
    end
  endtask

endmodule

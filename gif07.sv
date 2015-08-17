`timescale 1ns/10ps
// Interface definition
interface g07_if (input sysClk, input Breset);
  logic need,ack;
  logic [63:0] addr,addrM64;
  logic [63:0] SbusIn,dbus_out,MinData,DoutM;
  logic en,Tdone,Tdone_mstr;
  modport CLKS(input sysClk,input Breset);

  modport Mstr(
        input need, output ack,
        input addrM64, input DoutM, output MinData,
        output Tdone_mstr
  );

  modport MstrR(
        output need, input ack,
        output addrM64, output DoutM, input MinData,
        input Tdone
  );

  modport Slave(
        output addr, output SbusIn, input dbus_out,
        output en, output Tdone
  );

  modport SlaveR(
        input addr, input SbusIn, output dbus_out,
        input en, input Tdone
  );

endinterface


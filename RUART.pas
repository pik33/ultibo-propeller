unit RUART;

{$mode objfpc}{$H+}

interface

uses
  PReg;



procedure UART_Init(baud_rate : LongWord);

function UART_Status : Boolean;

function UART_Read : Byte;

procedure UART_Write(UW_Value : Byte);





implementation







procedure UART_Init(baud_rate : LongWord);
var
  Value : LongWord;



  procedure Wait_150; assembler; nostackframe;
  asm
   //Wait for a short period of time in a loop
   mov r0,#150
  .LWait:
   sub r0,#1
   cmp r0,#0
   bne .LWait
  end;  { procedure Wait_150 }



begin

  // Enable UART
  PREG_Write(AUX_BASE+AUX_ENABLES,1);

  // disable interrupts
  PREG_Write(AUX_BASE+AUX_MU_IER_REG,0);

  // disable transmit/receive
  PREG_Write(AUX_BASE+AUX_MU_CNTL_REG,0);

  // set 8 bits communication
  PREG_Write(AUX_BASE+AUX_MU_LCR_REG,3);

  // set the RTS line high
  PREG_Write(AUX_BASE+AUX_MU_MCR_REG,0);

  // leave disable interrupts
  PREG_Write(AUX_BASE+AUX_MU_IER_REG,0);

  // clear the input and output buffers
  PREG_Write(AUX_BASE+AUX_MU_IIR_REG,$C6);



  // ((250,000,000/115200)/8)-1 = 270
  // set BAUD = 270
  Value:=((250000000 div baud_rate) div 8) -1;

  PREG_Write(AUX_BASE+AUX_MU_BAUD_REG,Value);


  // Set GPIO line 14 for transmission (TXD)
  Value:=PREG_Read(GPIO_BASE+GPIO_GPFSEL1);
  Value:=Value and not $7000;
  Value:=Value or $2000;
  PREG_Write(GPIO_BASE+GPIO_GPFSEL1,Value);



  // Set GPIO line 15 for receiving (RXD)
  Value:=PREG_Read(GPIO_BASE+GPIO_GPFSEL1);
  Value:=Value and not $38000;
  Value:=Value or $10000;
  PREG_Write(GPIO_BASE+GPIO_GPFSEL1,Value);



  // disable GPIO pull-up/down
  PREG_Write(GPIO_BASE+GPIO_GPPUD,0);

  Wait_150;


  // Assert clock lines (14 & 15)
  // GPIO Pin Pull-up/down Enable Clock 0
  PREG_Write(GPIO_BASE+GPIO_GPPUDCLK0,MASK_GPIO_14 or MASK_GPIO_15);


  Wait_150;


  // clear clock lines
  PREG_Write(GPIO_BASE+GPIO_GPPUDCLK0,0);


  // enable bits 0 and 1 in CONTROL
  PREG_Write(AUX_BASE+AUX_MU_CNTL_REG,3);


end; { procedure UART_Init }




function UART_Status : Boolean;
var
  UR_Value : LongWord;
begin

  UR_Value:=PREG_Read(AUX_BASE+AUX_MU_LSR_REG);

  // This bit is set if the receive FIFO
  // holds at least 1 symbol.
  if (UR_Value and $00000001)=0 then
    Result:=false
  else
    Result:=true;

end; { function UART_Status }








function UART_Read : Byte;
var
  UR_Value : LongWord;
begin

  UR_Value:=PREG_Read(AUX_BASE+AUX_MU_LSR_REG);

  // This bit is set if the receive FIFO
  // holds at least 1 symbol.
  while (UR_Value and $00000001)=0 do
    UR_Value:=PREG_Read(AUX_BASE+AUX_MU_LSR_REG);

  UR_Value:=PREG_Read(AUX_BASE+AUX_MU_IO_REG);

  Result:=UR_Value and $FF;

end; { function UART_Read }







procedure UART_Write(UW_Value : Byte);
var
  LW_UW_Value : LongWord;
begin

  LW_UW_Value:=PREG_Read(AUX_BASE+AUX_MU_LSR_REG);

  // This bit is set if the transmit FIFO can accept
  // at least one byte.
  while (LW_UW_Value and $20)=0 do
    LW_UW_Value:=PREG_Read(AUX_BASE+AUX_MU_LSR_REG);


  LW_UW_Value:=UW_Value;
  PREG_Write(AUX_BASE+AUX_MU_IO_REG,LW_UW_Value);

end; { procedure UART_Write }




end.


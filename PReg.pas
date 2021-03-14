unit PReg;

{
Copyright (C) 2016 - Ronald Daleske

Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)

}


{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString}
{$inline on}   {Allow use of Inline procedures}



interface

uses
  Platform;





const

  // Bus Address
  PERIPHERAL_BASE = $20000000; // Peripheral Base Address for RPI A, B, A+, B+
  // PERIPHERAL_BASE = $7E000000; // Peripheral Base Address RPI 2 and 3


  // GPIO
  GPIO_BASE      = PERIPHERAL_BASE+$200000; // GPIO Base Address
  GPIO_GPFSEL0   =      $0; // GPIO Function Select 0
  GPIO_GPFSEL1   =      $4; // GPIO Function Select 1
  GPIO_GPFSEL2   =      $8; // GPIO Function Select 2
  GPIO_GPFSEL3   =      $C; // GPIO Function Select 3
  GPIO_GPFSEL4   =     $10; // GPIO Function Select 4
  GPIO_GPFSEL5   =     $14; // GPIO Function Select 5
  GPIO_GPSET0    =     $1C; // GPIO Pin Output Set 0
  GPIO_GPSET1    =     $20; // GPIO Pin Output Set 1
  GPIO_GPCLR0    =     $28; // GPIO Pin Output Clear 0
  GPIO_GPCLR1    =     $2C; // GPIO Pin Output Clear 1
  GPIO_GPLEV0    =     $34; // GPIO Pin Level 0
  GPIO_GPLEV1    =     $38; // GPIO Pin Level 1
  GPIO_GPEDS0    =     $40; // GPIO Pin Event Detect Status 0
  GPIO_GPEDS1    =     $44; // GPIO Pin Event Detect Status 1
  GPIO_GPREN0    =     $4C; // GPIO Pin Rising Edge Detect Enable 0
  GPIO_GPREN1    =     $50; // GPIO Pin Rising Edge Detect Enable 1
  GPIO_GPFEN0    =     $58; // GPIO Pin Falling Edge Detect Enable 0
  GPIO_GPFEN1    =     $5C; // GPIO Pin Falling Edge Detect Enable 1
  GPIO_GPHEN0    =     $64; // GPIO Pin High Detect Enable 0
  GPIO_GPHEN1    =     $68; // GPIO Pin High Detect Enable 1
  GPIO_GPLEN0    =     $70; // GPIO Pin Low Detect Enable 0
  GPIO_GPLEN1    =     $74; // GPIO Pin Low Detect Enable 1
  GPIO_GPAREN0   =     $7C; // GPIO Pin Async. Rising Edge Detect 0
  GPIO_GPAREN1   =     $80; // GPIO Pin Async. Rising Edge Detect 1
  GPIO_GPAFEN0   =     $88; // GPIO Pin Async. Falling Edge Detect 0
  GPIO_GPAFEN1   =     $8C; // GPIO Pin Async. Falling Edge Detect 1
  GPIO_GPPUD     =     $94; // GPIO Pin Pull-up/down Enable
  GPIO_GPPUDCLK0 =     $98; // GPIO Pin Pull-up/down Enable Clock 0
  GPIO_GPPUDCLK1 =     $9C; // GPIO Pin Pull-up/down Enable Clock 1
  GPIO_TEST      =     $B0; // GPIO Test

  GPIO_FSEL0_IN   = $0; // GPIO Function Select: GPIO Pin X0 Is An Input
  GPIO_FSEL0_OUT  = $1; // GPIO Function Select: GPIO Pin X0 Is An Output
  GPIO_FSEL0_ALT0 = $4; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 0
  GPIO_FSEL0_ALT1 = $5; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 1
  GPIO_FSEL0_ALT2 = $6; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 2
  GPIO_FSEL0_ALT3 = $7; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 3
  GPIO_FSEL0_ALT4 = $3; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 4
  GPIO_FSEL0_ALT5 = $2; // GPIO Function Select: GPIO Pin X0 Takes Alternate Function 5
  GPIO_FSEL0_CLR  = $7; // GPIO Function Select: GPIO Pin X0 Clear Bits

  GPIO_FSEL1_IN   =  $0; // GPIO Function Select: GPIO Pin X1 Is An Input
  GPIO_FSEL1_OUT  =  $8; // GPIO Function Select: GPIO Pin X1 Is An Output
  GPIO_FSEL1_ALT0 = $20; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 0
  GPIO_FSEL1_ALT1 = $28; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 1
  GPIO_FSEL1_ALT2 = $30; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 2
  GPIO_FSEL1_ALT3 = $38; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 3
  GPIO_FSEL1_ALT4 = $18; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 4
  GPIO_FSEL1_ALT5 = $10; // GPIO Function Select: GPIO Pin X1 Takes Alternate Function 5
  GPIO_FSEL1_CLR  = $38; // GPIO Function Select: GPIO Pin X1 Clear Bits

  GPIO_FSEL2_IN   =   $0; // GPIO Function Select: GPIO Pin X2 Is An Input
  GPIO_FSEL2_OUT  =  $40; // GPIO Function Select: GPIO Pin X2 Is An Output
  GPIO_FSEL2_ALT0 = $100; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 0
  GPIO_FSEL2_ALT1 = $140; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 1
  GPIO_FSEL2_ALT2 = $180; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 2
  GPIO_FSEL2_ALT3 = $1C0; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 3
  GPIO_FSEL2_ALT4 =  $C0; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 4
  GPIO_FSEL2_ALT5 =  $80; // GPIO Function Select: GPIO Pin X2 Takes Alternate Function 5
  GPIO_FSEL2_CLR  = $1C0; // GPIO Function Select: GPIO Pin X2 Clear Bits

  GPIO_FSEL3_IN   =   $0; // GPIO Function Select: GPIO Pin X3 Is An Input
  GPIO_FSEL3_OUT  = $200; // GPIO Function Select: GPIO Pin X3 Is An Output
  GPIO_FSEL3_ALT0 = $800; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 0
  GPIO_FSEL3_ALT1 = $A00; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 1
  GPIO_FSEL3_ALT2 = $C00; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 2
  GPIO_FSEL3_ALT3 = $E00; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 3
  GPIO_FSEL3_ALT4 = $600; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 4
  GPIO_FSEL3_ALT5 = $400; // GPIO Function Select: GPIO Pin X3 Takes Alternate Function 5
  GPIO_FSEL3_CLR  = $E00; // GPIO Function Select: GPIO Pin X3 Clear Bits

  GPIO_FSEL4_IN   =    $0; // GPIO Function Select: GPIO Pin X4 Is An Input
  GPIO_FSEL4_OUT  = $1000; // GPIO Function Select: GPIO Pin X4 Is An Output
  GPIO_FSEL4_ALT0 = $4000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 0
  GPIO_FSEL4_ALT1 = $5000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 1
  GPIO_FSEL4_ALT2 = $6000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 2
  GPIO_FSEL4_ALT3 = $7000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 3
  GPIO_FSEL4_ALT4 = $3000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 4
  GPIO_FSEL4_ALT5 = $2000; // GPIO Function Select: GPIO Pin X4 Takes Alternate Function 5
  GPIO_FSEL4_CLR  = $7000; // GPIO Function Select: GPIO Pin X4 Clear Bits

  GPIO_FSEL5_IN   =     $0; // GPIO Function Select: GPIO Pin X5 Is An Input
  GPIO_FSEL5_OUT  =  $8000; // GPIO Function Select: GPIO Pin X5 Is An Output
  GPIO_FSEL5_ALT0 = $20000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 0
  GPIO_FSEL5_ALT1 = $28000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 1
  GPIO_FSEL5_ALT2 = $30000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 2
  GPIO_FSEL5_ALT3 = $38000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 3
  GPIO_FSEL5_ALT4 = $18000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 4
  GPIO_FSEL5_ALT5 = $10000; // GPIO Function Select: GPIO Pin X5 Takes Alternate Function 5
  GPIO_FSEL5_CLR  = $38000; // GPIO Function Select: GPIO Pin X5 Clear Bits

  GPIO_FSEL6_IN   =      $0; // GPIO Function Select: GPIO Pin X6 Is An Input
  GPIO_FSEL6_OUT  =  $40000; // GPIO Function Select: GPIO Pin X6 Is An Output
  GPIO_FSEL6_ALT0 = $100000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 0
  GPIO_FSEL6_ALT1 = $140000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 1
  GPIO_FSEL6_ALT2 = $180000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 2
  GPIO_FSEL6_ALT3 = $1C0000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 3
  GPIO_FSEL6_ALT4 =  $C0000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 4
  GPIO_FSEL6_ALT5 =  $80000; // GPIO Function Select: GPIO Pin X6 Takes Alternate Function 5
  GPIO_FSEL6_CLR  = $1C0000; // GPIO Function Select: GPIO Pin X6 Clear Bits

  GPIO_FSEL7_IN   =      $0; // GPIO Function Select: GPIO Pin X7 Is An Input
  GPIO_FSEL7_OUT  = $200000; // GPIO Function Select: GPIO Pin X7 Is An Output
  GPIO_FSEL7_ALT0 = $800000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 0
  GPIO_FSEL7_ALT1 = $A00000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 1
  GPIO_FSEL7_ALT2 = $C00000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 2
  GPIO_FSEL7_ALT3 = $E00000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 3
  GPIO_FSEL7_ALT4 = $600000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 4
  GPIO_FSEL7_ALT5 = $400000; // GPIO Function Select: GPIO Pin X7 Takes Alternate Function 5
  GPIO_FSEL7_CLR  = $E00000; // GPIO Function Select: GPIO Pin X7 Clear Bits

  GPIO_FSEL8_IN   =       $0; // GPIO Function Select: GPIO Pin X8 Is An Input
  GPIO_FSEL8_OUT  = $1000000; // GPIO Function Select: GPIO Pin X8 Is An Output
  GPIO_FSEL8_ALT0 = $4000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 0
  GPIO_FSEL8_ALT1 = $5000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 1
  GPIO_FSEL8_ALT2 = $6000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 2
  GPIO_FSEL8_ALT3 = $7000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 3
  GPIO_FSEL8_ALT4 = $3000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 4
  GPIO_FSEL8_ALT5 = $2000000; // GPIO Function Select: GPIO Pin X8 Takes Alternate Function 5
  GPIO_FSEL8_CLR  = $7000000; // GPIO Function Select: GPIO Pin X8 Clear Bits

  GPIO_FSEL9_IN   =        $0; // GPIO Function Select: GPIO Pin X9 Is An Input
  GPIO_FSEL9_OUT  =  $8000000; // GPIO Function Select: GPIO Pin X9 Is An Output
  GPIO_FSEL9_ALT0 = $20000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 0
  GPIO_FSEL9_ALT1 = $28000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 1
  GPIO_FSEL9_ALT2 = $30000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 2
  GPIO_FSEL9_ALT3 = $38000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 3
  GPIO_FSEL9_ALT4 = $18000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 4
  GPIO_FSEL9_ALT5 = $10000000; // GPIO Function Select: GPIO Pin X9 Takes Alternate Function 5
  GPIO_FSEL9_CLR  = $38000000; // GPIO Function Select: GPIO Pin X9 Clear Bits


  MASK_GPIO_0  =        $1; // GPIO Pin 0: 0
  MASK_GPIO_1  =        $2; // GPIO Pin 0: 1
  MASK_GPIO_2  =        $4; // GPIO Pin 0: 2
  MASK_GPIO_3  =        $8; // GPIO Pin 0: 3
  MASK_GPIO_4  =       $10; // GPIO Pin 0: 4
  MASK_GPIO_5  =       $20; // GPIO Pin 0: 5
  MASK_GPIO_6  =       $40; // GPIO Pin 0: 6
  MASK_GPIO_7  =       $80; // GPIO Pin 0: 7
  MASK_GPIO_8  =      $100; // GPIO Pin 0: 8
  MASK_GPIO_9  =      $200; // GPIO Pin 0: 9
  MASK_GPIO_10 =      $400; // GPIO Pin 0: 10
  MASK_GPIO_11 =      $800; // GPIO Pin 0: 11
  MASK_GPIO_12 =     $1000; // GPIO Pin 0: 12
  MASK_GPIO_13 =     $2000; // GPIO Pin 0: 13
  MASK_GPIO_14 =     $4000; // GPIO Pin 0: 14
  MASK_GPIO_15 =     $8000; // GPIO Pin 0: 15
  MASK_GPIO_16 =    $10000; // GPIO Pin 0: 16
  MASK_GPIO_17 =    $20000; // GPIO Pin 0: 17
  MASK_GPIO_18 =    $40000; // GPIO Pin 0: 18
  MASK_GPIO_19 =    $80000; // GPIO Pin 0: 19
  MASK_GPIO_20 =   $100000; // GPIO Pin 0: 20
  MASK_GPIO_21 =   $200000; // GPIO Pin 0: 21
  MASK_GPIO_22 =   $400000; // GPIO Pin 0: 22
  MASK_GPIO_23 =   $800000; // GPIO Pin 0: 23
  MASK_GPIO_24 =  $1000000; // GPIO Pin 0: 24
  MASK_GPIO_25 =  $2000000; // GPIO Pin 0: 25
  MASK_GPIO_26 =  $4000000; // GPIO Pin 0: 26
  MASK_GPIO_27 =  $8000000; // GPIO Pin 0: 27
  MASK_GPIO_28 = $10000000; // GPIO Pin 0: 28
  MASK_GPIO_29 = $20000000; // GPIO Pin 0: 29
  MASK_GPIO_30 = $40000000; // GPIO Pin 0: 30
  MASK_GPIO_31 = $80000000; // GPIO Pin 0: 31

  MASK_GPIO_32 =        $1; // GPIO Pin 1: 32
  MASK_GPIO_33 =        $2; // GPIO Pin 1: 33
  MASK_GPIO_34 =        $4; // GPIO Pin 1: 34
  MASK_GPIO_35 =        $8; // GPIO Pin 1: 35
  MASK_GPIO_36 =       $10; // GPIO Pin 1: 36
  MASK_GPIO_37 =       $20; // GPIO Pin 1: 37
  MASK_GPIO_38 =       $40; // GPIO Pin 1: 38
  MASK_GPIO_39 =       $80; // GPIO Pin 1: 39
  MASK_GPIO_40 =      $100; // GPIO Pin 1: 40
  MASK_GPIO_41 =      $200; // GPIO Pin 1: 41
  MASK_GPIO_42 =      $400; // GPIO Pin 1: 42
  MASK_GPIO_43 =      $800; // GPIO Pin 1: 43
  MASK_GPIO_44 =     $1000; // GPIO Pin 1: 44
  MASK_GPIO_45 =     $2000; // GPIO Pin 1: 45
  MASK_GPIO_46 =     $4000; // GPIO Pin 1: 46
  MASK_GPIO_47 =     $8000; // GPIO Pin 1: 47
  MASK_GPIO_48 =    $10000; // GPIO Pin 1: 48
  MASK_GPIO_49 =    $20000; // GPIO Pin 1: 49
  MASK_GPIO_50 =    $40000; // GPIO Pin 1: 50
  MASK_GPIO_51 =    $80000; // GPIO Pin 1: 51
  MASK_GPIO_52 =   $100000; // GPIO Pin 1: 52
  MASK_GPIO_53 =   $200000; // GPIO Pin 1: 53


  // Auxiliary peripherals Register Map


  AUX_BASE        = PERIPHERAL_BASE+$215000; // AUX BASE

  AUX_ENABLES     = $004; // Auxiliary enables, Size 3
  AUX_MU_IO_REG   = $040; // Mini Uart I/O Data, Size 8
  AUX_MU_IER_REG  = $044; // Mini Uart Interrupt Enable, Size 8
  AUX_MU_IIR_REG  = $048; // Mini Uart Interrupt Identify, Size 8
  AUX_MU_LCR_REG  = $04C; // Mini Uart Line Control, Size 8
  AUX_MU_MCR_REG  = $050; // Mini Uart Modem Control, Size 8

  AUX_MU_LSR_REG  = $054; // Mini Uart Line Status, Size 8

  AUX_MU_MSR_REG  = $058; // Mini Uart Modem Status, Size 8
  AUX_MU_SCRATCH  = $05C; // Mini Uart Scratch, Size 8

  AUX_MU_CNTL_REG = $060; // Mini Uart Extra Control, Size 8
  AUX_MU_STAT_REG = $064; // Mini Uart Extra Status, Size 32
  AUX_MU_BAUD_REG = $068; // Mini Uart Baudrate, Size 16




procedure PREG_Write(Reg,Value:LongWord); inline;

function PREG_Read(Reg:LongWord):LongWord; inline;




implementation







procedure PREG_Write(Reg,Value:LongWord); inline;
begin

  {Memory Barrier}
  DataMemoryBarrier; {Before the First Write}

  {Write Value}
  PLongWord(Reg)^:=Value;

end; { procedure UART_Write }





function PREG_Read(Reg:LongWord):LongWord; inline;
begin

  {Read Value}
  Result:=PLongWord(Reg)^;

  {Memory Barrier}
  DataMemoryBarrier; {After the Last Read}

end; { function UART_Read }





end.


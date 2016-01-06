
/* Serial Port 0 USART Memory Map */
#define UART0_BASE          0x44E09000
#define UART0_FCR          0x44E09008
#define UART0_LCR           0x44E0900C
#define UART0_LSR_UART      0x44E09014
#define UART0_SSR           0x44E09044
#define UART0_SYSC          0x44E09054
#define UART0_SYSS          0x44E09058

#define UART0_LSR_THRE      (1 << 5)
#define UART0_LSR_TEMT      (1 << 6)
#define UART0_SYSC_SOFTRESET 0x00000002
#define UART0_SYSS_RESETDONE 0x00000001
#define UART0_FCR_TX_FIFO_CLEAR 0x00000004

/* Control Register C1 Co-processor */
#define C1CTL_V             0x00002000 // Exception base address control (normal or high)
#define C1CTL_I             0x00001000 // Instruction Cache Enable
#define C1CTL_Z             0x00000800 // Program flow prediction
#define C1CTL_C             0x00000004 // Data Cache Enable

/* Interrupt Vector Table */
#define IVT_START           0x4030CE00	// Interrupt Vector start address
#define IVT_END             0x4030CE20	// Interrupt Vector end address
#define IVH_START           0x4030CE24	// Interrupt Handler start address
#define IVH_END	            0x4030CE40	// Interrupt Handler end address
#define IRQH_ADDR           0x4030CE38	// IRQ interrupt handler address

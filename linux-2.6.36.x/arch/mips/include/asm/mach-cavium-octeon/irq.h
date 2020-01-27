/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Copyright (C) 2004-2008 Cavium Networks
 */
#ifndef __OCTEON_IRQ_H__
#define __OCTEON_IRQ_H__

#define NR_IRQS OCTEON_IRQ_LAST
#define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0

/* 0 - 7 represent the i8259 master */
#define OCTEON_IRQ_I8259M0	0
#define OCTEON_IRQ_I8259M1	1
#define OCTEON_IRQ_I8259M2	2
#define OCTEON_IRQ_I8259M3	3
#define OCTEON_IRQ_I8259M4	4
#define OCTEON_IRQ_I8259M5	5
#define OCTEON_IRQ_I8259M6	6
#define OCTEON_IRQ_I8259M7	7
/* 8 - 15 represent the i8259 slave */
#define OCTEON_IRQ_I8259S0	8
#define OCTEON_IRQ_I8259S1	9
#define OCTEON_IRQ_I8259S2	10
#define OCTEON_IRQ_I8259S3	11
#define OCTEON_IRQ_I8259S4	12
#define OCTEON_IRQ_I8259S5	13
#define OCTEON_IRQ_I8259S6	14
#define OCTEON_IRQ_I8259S7	15
/* 16 - 23 represent the 8 MIPS standard interrupt sources */
#define OCTEON_IRQ_SW0		16
#define OCTEON_IRQ_SW1		17
#define OCTEON_IRQ_CIU0		18
#define OCTEON_IRQ_CIU1		19
#define OCTEON_IRQ_CIU4		20
#define OCTEON_IRQ_5		21
#define OCTEON_IRQ_PERF		22
#define OCTEON_IRQ_TIMER	23
/* 24 - 87 represent the sources in CIU_INTX_EN0 */
#define OCTEON_IRQ_WORKQ0	24
#define OCTEON_IRQ_WORKQ1	25
#define OCTEON_IRQ_WORKQ2	26
#define OCTEON_IRQ_WORKQ3	27
#define OCTEON_IRQ_WORKQ4	28
#define OCTEON_IRQ_WORKQ5	29
#define OCTEON_IRQ_WORKQ6	30
#define OCTEON_IRQ_WORKQ7	31
#define OCTEON_IRQ_WORKQ8	32
#define OCTEON_IRQ_WORKQ9	33
#define OCTEON_IRQ_WORKQ10	34
#define OCTEON_IRQ_WORKQ11	35
#define OCTEON_IRQ_WORKQ12	36
#define OCTEON_IRQ_WORKQ13	37
#define OCTEON_IRQ_WORKQ14	38
#define OCTEON_IRQ_WORKQ15	39
#define OCTEON_IRQ_GPIO0	40
#define OCTEON_IRQ_GPIO1	41
#define OCTEON_IRQ_GPIO2	42
#define OCTEON_IRQ_GPIO3	43
#define OCTEON_IRQ_GPIO4	44
#define OCTEON_IRQ_GPIO5	45
#define OCTEON_IRQ_GPIO6	46
#define OCTEON_IRQ_GPIO7	47
#define OCTEON_IRQ_GPIO8	48
#define OCTEON_IRQ_GPIO9	49
#define OCTEON_IRQ_GPIO10	50
#define OCTEON_IRQ_GPIO11	51
#define OCTEON_IRQ_GPIO12	52
#define OCTEON_IRQ_GPIO13	53
#define OCTEON_IRQ_GPIO14	54
#define OCTEON_IRQ_GPIO15	55
#define OCTEON_IRQ_MBOX0	56
#define OCTEON_IRQ_MBOX1	57
#define OCTEON_IRQ_UART0	58
#define OCTEON_IRQ_UART1	59
#define OCTEON_IRQ_PCI_INT0	60
#define OCTEON_IRQ_PCI_INT1	61
#define OCTEON_IRQ_PCI_INT2	62
#define OCTEON_IRQ_PCI_INT3	63
#define OCTEON_IRQ_PCI_MSI0	64
#define OCTEON_IRQ_PCI_MSI1	65
#define OCTEON_IRQ_PCI_MSI2	66
#define OCTEON_IRQ_PCI_MSI3	67
#define OCTEON_IRQ_RESERVED68	68	/* Summary of CIU_INT_SUM1 */
#define OCTEON_IRQ_TWSI		69
#define OCTEON_IRQ_RML		70
#define OCTEON_IRQ_TRACE	71
#define OCTEON_IRQ_GMX_DRP0	72
#define OCTEON_IRQ_GMX_DRP1	73
#define OCTEON_IRQ_IPD_DRP	74
#define OCTEON_IRQ_KEY_ZERO	75
#define OCTEON_IRQ_TIMER0	76
#define OCTEON_IRQ_TIMER1	77
#define OCTEON_IRQ_TIMER2	78
#define OCTEON_IRQ_TIMER3	79
#define OCTEON_IRQ_USB0		80
#define OCTEON_IRQ_PCM		81
#define OCTEON_IRQ_MPI		82
#define OCTEON_IRQ_TWSI2	83
#define OCTEON_IRQ_POWIQ	84
#define OCTEON_IRQ_IPDPPTHR	85
#define OCTEON_IRQ_MII0		86
#define OCTEON_IRQ_BOOTDMA	87
/* 88 - 151 represent the sources in CIU_INTX_EN1 */
#define OCTEON_IRQ_WDOG0	88
#define OCTEON_IRQ_WDOG1	89
#define OCTEON_IRQ_WDOG2	90
#define OCTEON_IRQ_WDOG3	91
#define OCTEON_IRQ_WDOG4	92
#define OCTEON_IRQ_WDOG5	93
#define OCTEON_IRQ_WDOG6	94
#define OCTEON_IRQ_WDOG7	95
#define OCTEON_IRQ_WDOG8	96
#define OCTEON_IRQ_WDOG9	97
#define OCTEON_IRQ_WDOG10	98
#define OCTEON_IRQ_WDOG11	99
#define OCTEON_IRQ_WDOG12	100
#define OCTEON_IRQ_WDOG13	101
#define OCTEON_IRQ_WDOG14	102
#define OCTEON_IRQ_WDOG15	103
#define OCTEON_IRQ_UART2	104
#define OCTEON_IRQ_USB1		105
#define OCTEON_IRQ_MII1		106
#define OCTEON_IRQ_RESERVED107	107
#define OCTEON_IRQ_RESERVED108	108
#define OCTEON_IRQ_RESERVED109	109
#define OCTEON_IRQ_RESERVED110	110
#define OCTEON_IRQ_RESERVED111	111
#define OCTEON_IRQ_RESERVED112	112
#define OCTEON_IRQ_RESERVED113	113
#define OCTEON_IRQ_RESERVED114	114
#define OCTEON_IRQ_RESERVED115	115
#define OCTEON_IRQ_RESERVED116	116
#define OCTEON_IRQ_RESERVED117	117
#define OCTEON_IRQ_RESERVED118	118
#define OCTEON_IRQ_RESERVED119	119
#define OCTEON_IRQ_RESERVED120	120
#define OCTEON_IRQ_RESERVED121	121
#define OCTEON_IRQ_RESERVED122	122
#define OCTEON_IRQ_RESERVED123	123
#define OCTEON_IRQ_RESERVED124	124
#define OCTEON_IRQ_RESERVED125	125
#define OCTEON_IRQ_RESERVED126	126
#define OCTEON_IRQ_RESERVED127	127
#define OCTEON_IRQ_RESERVED128	128
#define OCTEON_IRQ_RESERVED129	129
#define OCTEON_IRQ_RESERVED130	130
#define OCTEON_IRQ_RESERVED131	131
#define OCTEON_IRQ_RESERVED132	132
#define OCTEON_IRQ_RESERVED133	133
#define OCTEON_IRQ_RESERVED134	134
#define OCTEON_IRQ_RESERVED135	135
#define OCTEON_IRQ_RESERVED136	136
#define OCTEON_IRQ_RESERVED137	137
#define OCTEON_IRQ_RESERVED138	138
#define OCTEON_IRQ_RESERVED139	139
#define OCTEON_IRQ_RESERVED140	140
#define OCTEON_IRQ_RESERVED141	141
#define OCTEON_IRQ_RESERVED142	142
#define OCTEON_IRQ_RESERVED143	143
#define OCTEON_IRQ_RESERVED144	144
#define OCTEON_IRQ_RESERVED145	145
#define OCTEON_IRQ_RESERVED146	146
#define OCTEON_IRQ_RESERVED147	147
#define OCTEON_IRQ_RESERVED148	148
#define OCTEON_IRQ_RESERVED149	149
#define OCTEON_IRQ_RESERVED150	150
#define OCTEON_IRQ_RESERVED151	151

#ifdef CONFIG_PCI_MSI
/* 152 - 215 represent the MSI interrupts 0-63 */
#define OCTEON_IRQ_MSI_BIT0	152
#define OCTEON_IRQ_MSI_LAST	(OCTEON_IRQ_MSI_BIT0 + 255)

#define OCTEON_IRQ_LAST		(OCTEON_IRQ_MSI_LAST + 1)
#else
#define OCTEON_IRQ_LAST         152
#endif

#endif
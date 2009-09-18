#include <p33FJ256GP710.h>
#include "ecan.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <adc.h>


mID canTxMessage;
mID canRxMessage;
unsigned char random=0;


/* Define ECAN Message Buffers */
ECAN1MSGBUF ecan1msgBuf __attribute__((space(dma),aligned(ECAN1_MSG_BUF_LENGTH*16)));

void __attribute__ ((interrupt, no_auto_psv)) _U2RXInterrupt(void)
{
	char a;
	a=U2RXREG;//grab char
	U2TXREG=a;
	__builtin_btg((unsigned int*)&LATE,0x02);
	IFS1bits.U2RXIF = 0;
}

void __attribute__ ((interrupt, no_auto_psv)) _U2TXInterrupt(void)
{
	IFS1bits.U2TXIF = 0;
	__builtin_btg((unsigned int*)&LATE,0x03);
}

void __attribute__ ((interrupt, no_auto_psv)) _U1TXInterrupt(void)
{
	IFS0bits.U1TXIF = 0;
	__builtin_btg((unsigned int*)&LATE,0x00);
}

void __attribute__ ((interrupt, no_auto_psv)) _U1RXInterrupt(void)
{
	char a;
	a=U1RXREG;
	U1TXREG=a;
	__builtin_btg((unsigned int*)&LATE,0x01);
	IFS0bits.U1RXIF = 0;
}

/* Timer2 ISR*/
void __attribute__((__interrupt__, __shadow__)) _T2Interrupt(void)
{
	/* Interrupt Service Routine code goes here */
	__builtin_btg((unsigned int*)&LATE,0x04);
	IFS0bits.T2IF = 0; //Clear Time2 interrupt flag
}
	
/* Timer3 ISR*/
void __attribute__((__interrupt__, __shadow__)) _T3Interrupt(void)
{
	//	__builtin_btg((unsigned int*)&LATE,0x04);
	IFS0bits.T3IF = 0; //Clear Time3 interrupt flag
	__builtin_btg((unsigned int*)&LATE,0x05);
}


void __attribute__((interrupt,no_auto_psv))_C1Interrupt(void)  
{
	/* check to see if the interrupt is caused by receive */     	 
    if(C1INTFbits.RBIF)
    {
	    /* check to see if buffer 1 is full */
	    if(C1RXFUL1bits.RXFUL1)
	    {			
			/* set the buffer full flag and the buffer received flag */
			canRxMessage.buffer_status=CAN_BUF_FULL;
			canRxMessage.buffer=1;	
		}		
		/* check to see if buffer 2 is full */
		else if(C1RXFUL1bits.RXFUL2)
		{
			/* set the buffer full flag and the buffer received flag */
			canRxMessage.buffer_status=CAN_BUF_FULL;
			canRxMessage.buffer=2;					
		}
		/* check to see if buffer 3 is full */
		else if(C1RXFUL1bits.RXFUL3)
		{
			/* set the buffer full flag and the buffer received flag */
			canRxMessage.buffer_status=CAN_BUF_FULL;
			canRxMessage.buffer=3;					
		}
		else;
		/* clear flag */
		C1INTFbits.RBIF = 0;
	}
	else if(C1INTFbits.TBIF)
    {
	   sendECAN(&canTxMessage);
	    /* clear flag */
		C1INTFbits.TBIF = 0;	    
	}
	else;
	
	/* clear interrupt flag */
	IFS2bits.C1IF=0;
}


void make_canmesg()
{
	/* configure and send a message */
	canTxMessage.message_type=CAN_MSG_DATA;
	//canTxMessage.message_type=CAN_MSG_RTR;
	canTxMessage.frame_type=CAN_FRAME_EXT;
	//canTxMessage.frame_type=CAN_FRAME_STD;
	canTxMessage.buffer=0;
	canTxMessage.id=0x123;
	canTxMessage.data[0]=random;
	canTxMessage.data[1]=random;
	canTxMessage.data[2]=random;
	canTxMessage.data[3]=random;
	canTxMessage.data[4]=random;
	canTxMessage.data[5]=random;
	canTxMessage.data[6]=random;
	canTxMessage.data[7]=random;
	canTxMessage.data_length=8;
}

int main(void)
{
	
	init();
	LATE=0x000A;

	make_canmesg();

	/* send a CAN message */
	sendECAN(&canTxMessage);
	
	while(1)
	{	
	__builtin_btg((unsigned int*)&LATE,0x07);
	make_canmesg();
	random+=11;
	}	
	
}	


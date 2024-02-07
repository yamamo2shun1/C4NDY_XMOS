#include <platform.h>
#include <stdio.h>

in port sw = on tile[0] : XS1_PORT_4E;

out port led1_3 = on tile[0] : XS1_PORT_4F;
out port led4 = on tile[1] : XS1_PORT_1K;

void main_tile0(streaming chanend c)
{
	printf("hello from tile 0\n");

	int count = 0;

	unsigned long sw_state = 0;
	int sw2_state = 0;

	while (1)
	{
		sw :> sw_state;
		sw2_state = (sw_state >> 3) & 0x01;
		printf("tile0 (SW2 = 0x%lX)\n", sw_state);

		c <: ((sw_state >> 2) & 0x01);

		led1_3 <: (count < 3 ? (0x02 << count) : 0x00);

		if (sw2_state == 1)
		{
			count = (count + 1) % 4;
			delay_milliseconds(100);
		}
		else
		{
			count--;
			if (count < 0)
			{
				count = 3;
			}
			delay_milliseconds(200);
		}
	}
}

void main_tile1(streaming chanend c)
{
	printf("hello from tile 1\n");

	int sw3_state = 0;
	
	while (1)
	{
		c :> sw3_state;
		printf("tile1 (SW3 = %d)\n", sw3_state);
		
		led4 <: ~sw3_state;
	}
}


int main(void)
{
	streaming chan c;

	par {
		on tile[0]: main_tile0(c);
		on tile[1]: main_tile1(c);
	}

	return 0;
}

#include <platform.h>
#include <stdio.h>
#include "i2c.h"

port i2c_scl = on tile[1] : XS1_PORT_1A;
port i2c_sda = on tile[1] : XS1_PORT_1B;

uint8_t read(client interface i2c_master_if i2c)
{
	i2c_regop_res_t result;

	uint8_t val = i2c.read_reg(0x39, 0x92, result);
	if (result != I2C_REGOP_SUCCESS)
	{
		printf("I2C read reg failed.\n");

		return 0;
	}

	printf("local id = 0x%02X\n", val);

	return val;
}

void my_loop(client interface i2c_master_if i2c)
{
	uint8_t id = read(i2c);
	printf("ID = 0x%02X", id);
	
	while (1)
	{
	}

}

void main_tile0(void)
{
	printf("hello from tile 0\n");

	while (1)
	{
	}
}

void main_tile1(void)
{
	printf("hello from tile 1\n");

	i2c_master_if i2c[1];

	par
	{
		i2c_master(i2c, 1, i2c_scl, i2c_sda, 100);

		my_loop(i2c[0]);
	}
}

int main(void)
{
	par {
		on tile[0]: main_tile0();
		on tile[1]: main_tile1();
	}

	return 0;
}

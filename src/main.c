/**
  ******************************************************************************
  * @author  Eduard S.
  * @version V1.0.0
  * @date    23-December-2014
  * @brief   Main Program body.
  *          Initialization of the GPIOs.
  ******************************************************************************
  */

#include "stm32f4_discovery.h"
#include "init_gpio.h"
#include "global_vars.h"


inline void SetLed(uint16_t pin, uint8_t state)
{
  if (state == 0x1)
  {
    GPIO_SetBits(GPIOB, pin);
  }
  else if (state == 0x0)
  {
    GPIO_ResetBits(GPIOB, pin);
  }
}

int main(void) {
	/* PE{8..15} */
	config_gpio_data();
	/* PD{0..15} */
	config_gpio_addr();
	/* PC{0..2} */
	config_gpio_sig();
	/* PA0 */
	config_gpio_dbg();
	config_PC0_int();

	/* Set initial cartridge settings */
	rom_bank = 0x01;
	ram_bank = 0x00;
	ram_enable = 0x00;
	rom_ram_mode = 0x00;

	no_show_logo = 1;
	while (1) {
	  SetLed(GPIO_Pin_2, state1);
	}
}


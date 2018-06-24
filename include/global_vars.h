/*
 * global_vars.h
 *
 *  Created on: Jun 24, 2018
 *      Author: sam
 */

#ifndef SRC_GLOBAL_VARS_H_
#define SRC_GLOBAL_VARS_H_

/* Global variables, defined in stm32f4xx_it.c */
extern uint8_t no_show_logo;

extern uint8_t rom_bank;
extern uint8_t ram_bank;
extern uint8_t ram_enable;
extern uint8_t rom_ram_mode;
extern uint8_t *ram;

extern volatile uint8_t state1;

#endif /* SRC_GLOBAL_VARS_H_ */

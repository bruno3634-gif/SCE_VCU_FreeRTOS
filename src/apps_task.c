/*******************************************************************************
  MPLAB Harmony Application Source File

  Company:
    Microchip Technology Inc.

  File Name:
    apps_task.c

  Summary:
    This file contains the source code for the MPLAB Harmony application.

  Description:
    This file contains the source code for the MPLAB Harmony application.  It
    implements the logic of the application's state machine and it may call
    API routines of other MPLAB Harmony modules in the system, such as drivers,
    system services, and middleware.  However, it does not call any of the
    system interfaces (such as the "Initialize" and "Tasks" functions) of any of
    the modules in the system or make any assumptions about when those functions
    are called.  That is the responsibility of the configuration-specific system
    files.
 *******************************************************************************/

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <stdio.h>

#include "apps_task.h"
#include "peripheral/adchs/plib_adchs.h"
#ifndef FREERTOS_H
    #include"FreeRTOS.h"
#endif
#include "semphr.h"

// *****************************************************************************
// *****************************************************************************
// Section: Global Data Definitions
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Application Data

  Summary:
    Holds application data

  Description:
    This structure holds the application's data.

  Remarks:
    This structure should be initialized by the APPS_TASK_Initialize function.

    Application strings and buffers are be defined outside this structure.
*/

APPS_TASK_DATA apps_taskData;

static SemaphoreHandle_t ADC0_SEMAPHORE;
static SemaphoreHandle_t ADC3_SEMAPHORE;

// *****************************************************************************
// *****************************************************************************
// Section: Application Callback Functions
// *****************************************************************************
// *****************************************************************************

/* TODO:  Add any necessary callback functions.
*/



void ADC0_callback(unsigned int status, unsigned int channel) {
    xSemaphoreGiveFromISR(ADC0_SEMAPHORE,NULL);
}

void ADC3_callback(unsigned int status, unsigned int channel) {
    xSemaphoreGiveFromISR(ADC3_SEMAPHORE,NULL);
}

// *****************************************************************************
// *****************************************************************************
// Section: Application Local Functions
// *****************************************************************************
// *****************************************************************************


/* TODO:  Add any necessary local functions.
*/


// *****************************************************************************
// *****************************************************************************
// Section: Application Initialization and State Machine Functions
// *****************************************************************************
// *****************************************************************************

/*******************************************************************************
  Function:
    void APPS_TASK_Initialize ( void )

  Remarks:
    See prototype in apps_task.h.
 */

void APPS_TASK_Initialize ( void )
{
    /* Place the App state machine in its initial state. */
    apps_taskData.state = APPS_TASK_STATE_INIT;



    /* TODO: Initialize your application's state machine and other
     * parameters.
     */
    
    ADCHS_CallbackRegister(ADCHS_CH0,ADC0_callback,(uintptr_t)NULL);
    ADCHS_CallbackRegister(ADCHS_CH3,ADC3_callback,(uintptr_t)NULL);
    vSemaphoreCreateBinary(ADC3_SEMAPHORE);
    vSemaphoreCreateBinary(ADC0_SEMAPHORE);
    
}


/******************************************************************************
  Function:
    void APPS_TASK_Tasks ( void )

  Remarks:
    See prototype in apps_task.h.
 */

void APPS_TASK_Tasks ( void )
{

    /* Check the application's current state. */
    switch ( apps_taskData.state )
    {
        /* Application's initial state. */
        case APPS_TASK_STATE_INIT:
        {
            bool appInitialized = true;


            if (appInitialized)
            {

                apps_taskData.state = APPS_TASK_STATE_SERVICE_TASKS;
            }
            break;
        }

        case APPS_TASK_STATE_SERVICE_TASKS:
        {

            break;
        }

        /* TODO: implement your application state machine.*/
        ADCHS_ChannelConversionStart(ADCHS_CH0);
        
        //uint16_t adcResult_0 = 0;
        if (xSemaphoreTake(ADC0_SEMAPHORE, portMAX_DELAY) == pdTRUE) {
        // Task unblocks here when semaphore is given
            //adcResult_0 = ADCHS_ChannelResultGet(ADCHS_CH0);
        }
        if (xSemaphoreTake(ADC3_SEMAPHORE, portMAX_DELAY) == pdTRUE) {
        // Task unblocks here when semaphore is given
            //adcResult_0 = ADCHS_ChannelResultGet(ADCHS_CH0);
        }
        uint16_t adc0value = ADCHS_ChannelResultGet(ADCHS_CH0);
        uint16_t adc3value = ADCHS_ChannelResultGet(ADCHS_CH3);
        
        float voltage0 = adc0value * 1024 / 3.3;
        float voltage3 = adc3value * 1024 / 3.3;
        
        printf("APPS 1: %f      APPS 3: %f",voltage0,voltage3); 
        
        /* The default state should never be executed. */
        default:
        {
            /* TODO: Handle error in application's state machine. */
            break;
        }
    }
}


/*******************************************************************************
 End of File
 */

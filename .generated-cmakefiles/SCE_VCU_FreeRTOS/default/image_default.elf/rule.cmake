function(assemble_rule target)
    set(inputVar "${ASSEMBLER_PRE};-g;-mprocessor=32MK1024MCM064;-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK;-Wa,--defsym=__MPLAB_BUILD=1,${MP_EXTRA_AS_POST},-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK,;-mdfp=/home/pedroferreira/.mchp_packs/Microchip/PIC32MK-MC_DFP/1.11.151")
    string(REGEX REPLACE "[,]+" "," noDoubleCommas "${inputVar}")
    string(REGEX REPLACE ",$" "" noDanglingCommas "${noDoubleCommas}")
    target_compile_options(${target} PRIVATE "${noDanglingCommas}")
endfunction()
function(assembleWithPreprocess_rule target)
    set(inputVar "${MP_EXTRA_AS_PRE};-g;-mprocessor=32MK1024MCM064;-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK;-DXPRJ_default=default;-Wa,--defsym=__MPLAB_BUILD=1,${MP_EXTRA_AS_POST},-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK,")
    string(REGEX REPLACE "[,]+" "," noDoubleCommas "${inputVar}")
    string(REGEX REPLACE ",$" "" noDanglingCommas "${noDoubleCommas}")
    target_compile_options(${target} PRIVATE "${noDanglingCommas}")
endfunction()
function(compile_rule target)
    set(inputVar "${CC_PRE};-g;-x;c;-c;-mprocessor=32MK1024MCM064;-ffunction-sections;-fdata-sections;-O1;-fno-common;-I../../../../src;-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK;-Werror;-Wall;${INSTRUMENTED_TRACE_OPTIONS};${FUNCTION_LEVEL_PROFILING_OPTIONS};-DXPRJ_default=default;-mdfp=/home/pedroferreira/.mchp_packs/Microchip/PIC32MK-MC_DFP/1.11.151;${CMSIS_PACK_INCLUDE}")
    string(REGEX REPLACE "[,]+" "," noDoubleCommas "${inputVar}")
    string(REGEX REPLACE ",$" "" noDanglingCommas "${noDoubleCommas}")
    target_compile_options(${target} PRIVATE "${noDanglingCommas}")
endfunction()
function(compile_cpp_rule target)
    set(inputVar "${CC_PRE};-g;-mprocessor=32MK1024MCM064;-frtti;-fexceptions;-fno-check-new;-fenforce-eh-specs;-ffunction-sections;-O1;-fno-common;-I../../../../src;-I../../../../src/config/default;-I../../../../src/third_party/rtos/FreeRTOS/Source/include;-I../../../../src/third_party/rtos/FreeRTOS/Source/portable/MPLAB/PIC32MK;${INSTRUMENTED_TRACE_OPTIONS};${FUNCTION_LEVEL_PROFILING_OPTIONS};-DXPRJ_default=default;-mdfp=/home/pedroferreira/.mchp_packs/Microchip/PIC32MK-MC_DFP/1.11.151;${CMSIS_PACK_INCLUDE}")
    string(REGEX REPLACE "[,]+" "," noDoubleCommas "${inputVar}")
    string(REGEX REPLACE ",$" "" noDanglingCommas "${noDoubleCommas}")
    target_compile_options(${target} PRIVATE "${noDanglingCommas}")
endfunction()
function(link_rule target)
    set(inputVar "${MP_EXTRA_LD_PRE};-g;-mprocessor=32MK1024MCM064;${INSTRUMENTED_TRACE_OPTIONS};${FUNCTION_LEVEL_PROFILING_OPTIONS};-DXPRJ_default=default;-Wl,--defsym=__MPLAB_BUILD=1,${MP_EXTRA_LD_POST},${MP_LINKER_FILE_OPTION},--defsym=_min_heap_size=512,,--no-code-in-dinit,,--no-dinit-in-serial-mem,,--memorysummary,memoryfile.xml;-mdfp=/home/pedroferreira/.mchp_packs/Microchip/PIC32MK-MC_DFP/1.11.151")
    string(REGEX REPLACE "[,]+" "," noDoubleCommas "${inputVar}")
    string(REGEX REPLACE ",$" "" noDanglingCommas "${noDoubleCommas}")
    target_link_options(${target} PRIVATE "${noDanglingCommas}")
endfunction()

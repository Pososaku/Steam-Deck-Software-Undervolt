#!/bin/bash
set -eu

status=$(</home/deck/.local/bin/statusadj.txt)
allow=$(</home/deck/.local/bin/allowadj.txt)
experimental=$(</home/deck/.local/bin/experimentaladj.txt)

# https://github.com/NGnius/PowerTools/issues/84#issuecomment-1482736698
# https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf
# Expect your UV to be 3-5x your set curve value. IE: -5 = -15mv to -25mv
# Имейте в виду, что в этом файле вы заедете значения кривой, а не mV напрямую.
# Помините, что значения кривой которые вы выставляете будут в 3-5 больше при переводе в mV. Пример: -5 = от -15 мВ до -25 мВ (значения приблизительные!)

if [[ $allow = "1" ]]
then
    if [[ $experimental = "1" ]]
    then
        echo "0" > /home/deck/.local/bin/experimentaladj.txt

        # EXPERIMENTAL SECTION
        # Put experimental settings here - these
        # will never be restored at next startup
        
        #       !ОБЯЗАТЕЛЬНО К ПРОЧТЕНИЮ!
        
        #Секция ЭКСПЕРИМЕНТАЛЬНОГО андервольта. Данная секция отлично подходит для ПОДБОРА безопасных значений.
        #Значения из этой секции будут деактивированы после перезагрузки.
        
        #Лимит -100

        #Устанавливайте значения кривой здесь:
        /home/deck/.local/bin/curve.sh -y --core0 -15 --core1 -15 --core2 -15 --core3 -15


        
        echo "Experimental on" > /home/deck/.local/bin/statusadj.txt
    else
        # Fail safe to avoid repeated crashes at startup
        if [[ $status = "Applying undervolt" ]]
        then
            echo "WARNING: Last apply failed or still in progress - skipping"
        else
            echo "Applying undervolt" > /home/deck/.local/bin/statusadj.txt

            # UNDERVOLT-ON SECTION
            # Put verified settings here.
            # WARNING: when service is enabled these will be restored
            # at next startup and can make your device unaccessible until you
            # repair/reimage your deck!
            
            #       !ОБЯЗАТЕЛЬНО К ПРОЧТЕНИЮ!
            
            #СЕКЦИЯ ПОСТОЯННОГО АНДЕРВОЛЬТА. 
            #Подходит ТОЛЬКО ДЛЯ ПРОВЕРЕННЫХ ЗНАЧЕНИЙ! Иначе может потребоваться переустановка Steam OS.
            #Значения используемые в этой секции ОСТАЮТСЯ после перезагрузки.
            #Непроверенные или небезопасные значения могут помешать вам загрузиться в ОС.
            
            #Лимит -100

            #Устанавливайте значения кривой здесь:
            /home/deck/.local/bin/curve.sh -y --core0 -5 --core1 -5 --core2 -5 --core3 -5


            
            sleep 10
            # Only update status if still applying...
            status=$(</home/deck/.local/bin/statusadj.txt)
            if [[ $status = "Applying undervolt" ]]
            then
                echo "Undervolt on" > /home/deck/.local/bin/statusadj.txt
            fi
        fi
    fi
else

    #НЕ ИЗМЕНЯТЬ ЗНАЧЕНИЯ!
    #Пожалуйста не трогайте эту секцию!
    
    /home/deck/.local/bin/curve.sh -y --core0 0 --core1 0 --core2 0 --core3 0
    
    echo "Undervolt off" > /home/deck/.local/bin/statusadj.txt
fi

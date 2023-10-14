## RU SECTION

Данный репозиторий предоставляет легкую возможность эффективно андерольтить Steam Deck. Андервольт возможен как на все ядра сразу так и на каждое отдельно

Форк [RyzenAdj](https://github.com/FlyGoat/RyzenAdj) и [KyleGospo](https://github.com/KyleGospo/Steam-Deck-Software-Undervolt).

> [!WARNING]
> Несмотря на то, что данное ПО сильно снижает риски связанные с окирпичиванием Steam Deck, оно все еще может нарушить работу вашей ОС и самого устройства. Никто Вам не даст гарантий что оно не повредит ваш Steam Deck. У вас должно быть полное понимание того что Вы >изменяете и зачем.
>Используйте на свой риск и соблюдайте осторожность.
>Предназначено для опытных пользователей!

## Установка:
1. Скачать [архив](https://github.com/Pososaku/Steam-Deck-Software-Undervolt/archive/refs/heads/main.zip) и распаковать.
2. Перейти в папку ``Steam-Deck-Software-Undervolt-main`` и находясь внутри папки кликнуть правой кнопкой мыши на пустое пространство. В появившемся меню выбрать "Open Terminal Here".
3. Ввести в терминале: `sudo ./install.sh`

Запустится скрипт установки в котором вам нужно будет выбрать метод андервольта. Их всего два:

* coall - метод, при котором значения кривой применяется сразу ко всем ядрам.
* coper - метод, при котором значения кривой можно подобрать к каждому ядру отдельно.

Для удаления - по аналогии выше, но вместо `install.sh`, запустить `uninstall.sh`

## Использование:
Для изменения параметров андервольта необходимо перейти в папку `/home/deck/.local/bin` (папка .local по умолчанию скрыта)

Для изменения значений андервольта необходимо открыть файл:

* Если вы используете метод для всех ядер(coall) то `set-ryzenadj-tweaks.sh`

* Если вы используете метод для каждого ядра(coper) то `set-ryzenadj-curve.sh`

Далее уже ориентироваться в нем опираясь на комментарии в самом файле.


* Для запуска андервольта с экспериментальными параметрами - запустить  `/home/deck/.local/bin/experimental.sh`

* Для запуска андервольта с постоянными параметрами - запустить `/home/deck/.local/bin/on.sh`

* Для сброса значений андервольта - запустить `/home/deck/.local/bin/off.sh`

Узнать статус андервольта можно в файле `/home/deck/.local/bin/statusadj.txt`

## EN SECTION

# Steam Deck Software Undervolt
This repository offers an easy way to undervolt a Steam Deck as safely as possible and without entering the BIOS or disabling read-only using [RyzenAdj](https://github.com/FlyGoat/RyzenAdj) and systemd targets based on [Chris Down's guide](https://chrisdown.name/2017/10/29/adding-power-related-targets-to-systemd.html). 

A precompiled version of RyzenAdj is provided for your convenience, built on my Steam Deck.

## Warning

As with any undervolt exercise caution, while this project greatly reduces the risk of bricking your deck, it does not in any way guarantee you won't damage your hardware. Use at your own risk.

## Installation
#### All core method
Clone this repository, with the repository root folder as current folder make the script `install.sh` executeable with `chmod +x install.sh`and run it with root privileges: `sudo ./install.sh`

When `Select undervolt method: (all/curve)` pops up during installation, enter `all`.

It will install a new service `set-ryzenadj-tweaks.service`, create some additional service activation rules, and copy a bunch of files to the `/home/deck/.local/bin` folder.


Undervolt amount can be changed by editing `/home/deck/.local/bin/set-ryzenadj-tweaks.sh`

By default a `-5` [curve optimization](https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf) is applied *(via `-set-coall`)*, in the 'undervolt-on' section which should be stable on most hardware.

A much more ambitious `-15` curve optimization is applied in the `experimental` section. This setting might be stable but it might also cause a crash/hang if applied.

#### Per core method
The installation is identical to the All core method, but when selecting the undervolt method you need to enter `curve`.

It will install a new service `set-ryzenadj-curve.service` and create some additional service activation rules.

Undervolt amount can be changed by editing `/home/deck/.local/bin/set-ryzenadj-curve.sh`

By default a `-5`/`-5`/`-5`/`-5` is applied *(via `-set-coper`)*, in the 'undervolt-on' section 

`-15`/`-15`/`-15`/`-15` per core curve optimization is applied in the `experimental` section.

## Activation

By default no undervolt is applied until you run either the `on.sh` or the `experimental.sh` scripts:

#### The on, off, and experimental scripts
Add `on.sh`, `off.sh`, and `experimental.sh` from the `/home/deck/.local/bin` folder as non-steam apps and run them from game mode to control undervolt status.
* `on.sh` enables undervolt in the `undervolt-on` section. This setting will be restored if you restart your deck unless you have run the `off.sh` script before restart.
* `experimental.sh` enables undervolt in the `experimental` section. The experimental setting is applied only once and is not restored if you restart your steam deck.
* `off.sh` disables undervolt.

## Uninstall
If you don't want to undervolt anymore you can uninstall the service `set-ryzenadj-tweaks.service`, the additional service activation roles, and delete the files from `/home/deck/.local/bin` via the uninstall.sh script.
With the repository root folder as current folder make the script `uninstall.sh` executable with `chmod +x uninstall.sh` and run it with root privileges: `sudo ./uninstall.sh`

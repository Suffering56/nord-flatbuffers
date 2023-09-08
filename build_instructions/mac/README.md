sudo # Инструкция по сборке flatc под linux

К сожалению собрать flatc под мак с винды у меня не вышло
(хотя вроде как и такое можно https://github.com/sickcodes/Docker-OSX, но мой процессор сказал что не умеет в некоторые функции wsl). 
Поэтому собиралось все на полноценном маке и инструкция будет именно об этом.

1) Устанавливаем cmake (на версиях 3.25 и 3.26 все работало успешно) вот отсюда:
https://cmake.org/install/

2) Так же нам потребуются сами сходники flatbuffers поэтому клонируем репозиторий с flatbuffers куда нам удобно.

3) Делаем директорию с исходниками фб активной: `cd /path/to/flatbuffers/repo`

4) Запускаем сборку cmake `sudo /Applications/Cmake/Content/bin/cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release`
Вообще по идее cmake должен был добавиться в path, но у нас не добавился и поэтому в команде указан полный путь к cmake.

5) Далее собираем flatc с помощью команды: `sudo make`

6) Готово. Скомпиленный flatc будет ждать нас в корне репозитория `/path/to/flatbuffers/repo`

PS: внезапно выяснилось, что flatc, собранный на одной версии MAC OS и запущенный на другой
может не работать.
В моем случае были вот такие ошибки:
- zsh: bad CPU type in executable ./flatc_mac (появлялась при любом вызове flatc)
Помогла пересборка flatc на другой машине (в моем там была MAC OS X 13.0)
- dyld: Symbol not found: __ZNKSt3__115basic_stringbufIcNS_11char_traitsIcEENS_9allocatorIcEEE3strEv
Referenced from: ../schemas/utils/flatc_mac (which was built for Mac OS X 13.0)
Expected in: /usr/lib/libc++.1.dylib (эта ошибка вылезала только при сборке java классов из fbs)
Помогла пересборка flatc (из под все той же MAC OS X 13.0) с параметром
`set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0" CACHE STRING "Minimum OS X deployment version" FORCE)`
который нужно добавить в файл CMakeLists.txt (по идее в любое место, я добавлял где-то на 30й строке).
Инфа взята отсюда: https://zhuanlan.zhihu.com/p/611063584

# nodes-checker
Программа для проверки вкладки "Node" в политиках информационной безопасности разрабатываемых для межсетевых экранов.

Сам скрипт - файл nodes-checker.ps1
Файл образец для проверки работоспособности - TEST.xlsx

## Как использовать скрипт
1. Скачайте скрипт и положите куда хотите.
2. Откройте его с помощью Powershell ISE и измените путь к проверяемому файлу в переменной $path. Например, если файл с политикой лежит 
в папке "D:\TEST\detector\TEST.xlsx" то переменная $path будет выглядеть так $path="D:\TEST\detector\TEST.xlsx".

ВАЖНО!
В переменной $path указывается абсолютный путь к файлу.

# Путь к обрабатываемому файлу C:\EXCEL POWERSHELL\test2.xlsx ПОСЛЕДНЯЯ ВЕРСИЯ!!!
# ВАЖНО! Поиск на вкладке Policy ведется начиная с ячейки B4. На вкладке Policy поиск ведется по столбцам D и F.
Write-Host (" ")
Write-Host ("--------------------НАЧАЛО РАБОТЫ-----------------------------")
$StartTime = Get-Date
Write-Host (" ")

$letter = "ABCDEFG"

$path="D:\TEST\detector\TEST.xlsx"															    #Путь и имя файла Excel 
$excelSheets = Get-Childitem -Path $path


$excel = New-Object -comobject Excel.Application                                        
$excel.visible = $true																

$workbook = $excel.Workbooks.Open($path)

$SheetNamePolicy = "Policy"	
$WorkSheetPolicy = $workbook.Worksheets.Item($SheetNamePolicy)

$rowMaxPlocy = ($WorkSheetPolicy.usedRange.rows).count									    
$columnMaxPolicy = ($WorkSheetPolicy.usedRange.columns).count									

Write-Host ("Максимальный номер используемой на листе Policy строки:" +$rowMaxPlocy)
Write-Host ("Максимальный номер используемого на листе Policy столбца:" +$columnMaxPolicy)
Write-Host (" ")

$SheetNameNode = "Node"	
$WorkSheetNode = $workbook.Worksheets.Item($SheetNameNode)

$rowMaxNode = ($WorkSheetNode.usedRange.rows).count
$columnMaxNode = ($WorkSheetNode.usedRange.columns).count

$Find = 0									

Write-Host ("Максимальный номер используемой на листе Node строки:" +$rowMaxNode)
Write-Host ("Максимальный номер используемого на листе Node столбца:" +$columnMaxNode)
Write-Host (" ")

function CheckNodeSheetValue ($matches) {

    $xlWhole = 1
    $LookAt = $xlWhole

    $t = "B" + $rowMaxNode 

    $Find = 0


    $Range = $WorkSheetNode.Range("B3","$t")
  
    $Search = $Range.find($matches, [Type]::Missing, [Type]::Missing, 1)
    
    if ($Search) {
        $WorkSheetNode.Cells.Item($Search.Row,$Search.Column).Interior.ColorIndex = 4
    
        $Find = 1
        return $Find
    } 
                
    if (!$Search) {
        $Find = 0
        return $Find
    }

}

for ($CurRowPolicy=1; $CurRowPolicy -le $rowMaxPlocy; $CurRowPolicy++) {     
                           
    for ($CurColumnPloicy=1; $CurColumnPloicy -le $columnMaxPolicy; $CurColumnPloicy++) {  

        if (($CurColumnPloicy -eq "4") -or ($CurColumnPloicy -eq "6")) {

            $ValueOfCurPolicyCell = $WorkSheetPolicy.Cells.Item($CurRowPolicy,$CurColumnPloicy).text
                                     
            $SplitPolicyString = $ValueOfCurPolicyCell.Split("`n")                                    
            $ArrayCount = $SplitPolicyString.Count                                                    

                if ($ArrayCount -eq 1) { 
                    
                    if ($SplitPolicyString[0] -match "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$") {
                        $Find =  CheckNodeSheetValue ($matches[0])

                        switch ($Find) {

                        {$Find -eq 1} { 

                            }

                        {$Find -eq 0} { 
                            Write-Host "Значение" $matches[0] "с вкладки Policy, из яйчейки с адресом "$letter[$CurColumnPloicy-1]$CurRowPolicy " не найдено на вкладке Node! Красим яйчейку в красный цвет "
                            $WorkSheetPolicy.Cells.Item($CurRowPolicy,$CurColumnPloicy).Interior.ColorIndex = 3
                            }

                        }
                    }

                    elseif ($SplitPolicyString[0] -match "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b") {

                        $Find =  CheckNodeSheetValue ($matches[0])

                        switch ($Find) {

                        {$Find -eq 1} { 
 
                            }

                        {$Find -eq 0} { 
                            Write-Host "Значение" $matches[0] "с вкладки Policy, из яйчейки с адресом "$letter[$CurColumnPloicy-1]$CurRowPolicy " не найдено на вкладке Node! Красим яйчейку в красный цвет "
                            $WorkSheetPolicy.Cells.Item($CurRowPolicy,$CurColumnPloicy).Interior.ColorIndex = 3
                            }

                        }

                    }
                
                }   
                                                                                         
                elseif ($ArrayCount -gt 1) {    
                    for ($i=0; $i -le $ArrayCount; $i++) {
                    
                        if ($SplitPolicyString[$i] -match "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$") {
                        $Find =  CheckNodeSheetValue ($matches[0])
                        
                            switch ($Find) {

                                {$Find -eq 1} { 
                                    }

                                {$Find -eq 0} { 
                                    Write-Host "Значение" $matches[0] "с вкладки Policy, из яйчейки с адресом "$letter[$CurColumnPloicy-1]$CurRowPolicy " не найдено на вкладке Node! Красим яйчейку в красный цвет "
                                    $WorkSheetPolicy.Cells.Item($CurRowPolicy,$CurColumnPloicy).Interior.ColorIndex = 3
                                    }

                            }

                        }

                        elseif ($SplitPolicyString[$i] -match "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b") {
                            $Find =  CheckNodeSheetValue ($matches[0])
                        
                            switch ($Find) {

                                {$Find -eq 1} { 
 
                                    }

                                {$Find -eq 0} {
                                    Write-Host "Значение" $matches[0] "с вкладки Policy, из яйчейки с адресом "$letter[$CurColumnPloicy-1]$CurRowPolicy " не найдено на вкладке Node! Красим яйчейку в красный цвет "
                                    $WorkSheetPolicy.Cells.Item($CurRowPolicy,$CurColumnPloicy).Interior.ColorIndex = 3
                                    }
                            }                 
                        }                                                                                  

                    }                                                                                     
            
                }                                                                                             
         
        }                                                                                             
    }
}      

Write-Host (" ")
Write-Host ("--------------------------------------------------------------------------------------КОНЕЦ РАБОТЫ--------------------------------------------------------------------------------------")
$FinishTime = Get-Date
Write-Host ("Время начала работы: " +$StartTime)
Write-Host ("Время завершения работы скрипта: " +$FinishTime)
Write-Host ("----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
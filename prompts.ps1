#Written by: Kenneth B Shinn Jr. Student Number: #001222768
#Clears powershell command line
Clear-Host
Do 
{
    #Prompts user to enter a number to run this script.
    $Num = Read-Host "Press a number from 1 - 5  to generate file output.
    
    1. Generate Daily Log
    2. Generate List of all Files
    3. CPU and Memory Report
    4. Processes Report
    5. Exit
    
    Please make your selection now:"
    #Try Statement begins here
    Try 
    {
            #Switch begins here
            Switch ( $Num )  
            {
                1 
                {
                    'Daily Log Generated'
                   
                    #Checks to see if the file DailyLog Does not Exist. If the file does not exit it will run Get-ChildItem and then loops back into the script menu. ErrorAction Perimeter has been set for Try-Catch Statement
                    if (-not (Test-Path -Path '.\DailyLog.txt' -PathType Leaf )) {
                    Get-ChildItem -File *.log -ErrorAction Stop | Sort-Object | Format-table -AutoSize  | Out-File -FilePath Dailylog.txt}
                    #Dailylog.txt does exist, it will reference the variables above and create a new Dailylog.txt and then loop back into the script menu
                    else{$Output | Out-file -FilePath .\Dailylog.txt}                   
                   
                    #Variables for the else statement
                    #Reads content from existing file with the name Dailylog.txt"
                    $content = Get-Content -Path .\Dailylog.txt
                    #Create a new array in which to work
                    $Output = @() 
                    #Run Get-Child Items on current directory to generate new report
                    $Output += Get-ChildItem -File *.log -ErrorAction Stop | Sort-Object | Format-table -AutoSize
                    #Writes Previous Version of Dailylog.txt first then adds the output from the latest attempt of Get-ChildItem
                    $Output += $content  
                                       
                  
               }
               2 
               {
                   'File List Generated'
                   #Performs a Get-Child Item on the current directory for all files, Sorts them in ascending order and writes it to a file called C916Contents.txt 
                   Get-ChildItem -File * -ErrorAction Stop | Out-File -FilePath C916contents.txt
                     
              } 
              3 
              {
                  'CPU and Memory Info Displayed'
                
                 #Variables for Get-Counter
                 $Counters = @(
                 "\Processor(_total)\% processor time",
                 "\memory\% committed bytes in use"
                   )
                  #Performs a Get-Counter using the Counters Variable above to get 4 Samples of Processor Time and Memory % Committed in bytes every 5 Seconds and writes it to the screen
                  Get-Counter -Counter $Counters -MaxSamples 4 -SampleInterval 5 -ErrorAction Stop | Out-Host

              }
              4
              {
                  'Running Processes Generated'
                  #Performs a Get-Process to display all processes currently on the screen, then sorts them in decending and outputs the information to Grid-View. 
                  Get-Process | Sort-Object CPU -descending -ErrorAction Stop | Out-GridView
             }
         }   
     }
 
 Catch [System.OutOfMemoryException]
 {
    $ErrorMessage = System.OutOfMemoryException
 }
 }
 #Pressing 5 Will exit the Switch loop and end the script.
 Until ($Num -eq 5) 
 #A little thank you message for running the script 
 Write-Host "Thank you for using out tool!" 
 

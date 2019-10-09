#vSphere – VM CPU Report

 

$myCol = @()

 

$vcNames = Read-Host -Prompt 'Input your VCSA Server Here'

$vmNames = Read-Host -Prompt 'Input your VM Name Here'

 

Connect-VIServer -Server $vcNames

 

            foreach($vm in (Get-VM -name $vmNames)){

 

                $VMView = $vm | Get-View

 

                $VMSummary = "" | Select ClusterName,HostName,VMName,VMSockets,VMCores,CPUSockets,CPUCores

 

                $VMSummary.ClusterName = $cluster.Name

 

                $VMSummary.HostName = $vmhost.Name

 

                $VMSummary.VMName = $vm.Name

 

                $VMSummary.VMSockets = $VMView.Config.Hardware.NumCpu

 

                $VMSummary.VMCores = $VMView.Config.Hardware.NumCoresPerSocket

 

                $myCol += $VMSummary

 

            }

 

 

$myCol | Export-Csv -Path C:\temp\CPU_Results01.csv

#VM – Datastore Report

# Specify to vCenter

$vCenter = Read-Host -Prompt 'Enter your vCenter here'

 

connect-viserver -server $vCenter

 

# Specify VM name

$vm = Read-Host -Prompt 'Enter VM Name here'

 

get-datastore -vm $vm | Select Name, FreeSpaceGB, CapacityGB, @{N='CanonicalName';E={$_.ExtensionData.Info.Vmfs.Extent[0].DiskName}}

#VM – Datastore Report
# Specify to vCenter that the VM is being hosted on. You can also point to a ESXi host. 

$vCenter = Read-Host -Prompt 'Enter your vCenter here'

connect-viserver -server $vCenter

# Specify VM name that you are checking the storage against
$vm = Read-Host -Prompt 'Enter VM Name here'

get-datastore -vm $vm | Select Name, FreeSpaceGB, CapacityGB, @{N='CanonicalName';E={$_.ExtensionData.Info.Vmfs.Extent[0].DiskName}}

#vSphere – CPU

 

# Get all VMs

$vmNames = Read-Host -Prompt 'Input your VM Name Here'


# Loop through each VM found

foreach ($vm in (Get-VM -name $vmNames)) {


    # Get VM details

    $vmname = $vm.name;

    $totalcores = [string]$vm.numcpu

    $corespersocket = [string]((get-view $vm).config.hardware.numcorespersocket);

    $sockets = [string]([int]($totalcores / $corespersocket));

    $powerstate = [string]$vm.powerstate;


    # Build CSV output

    $out = $vmname + "," + $totalcores + "," + $sockets + "," + $corespersocket + "," + $powerstate;


    # Output to file

    $out >> c:\temp\vms.csv;


}

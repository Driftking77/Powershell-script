# Variables
$resourceGroupName = "PZI-GXIN-P-RGP-PRIHE-P001" 
$storageAccountName = "pcinslprihep001" 
$containerName = "dbbackuptoday" 
$filePath = "C:\Users\dsingh322\Downloads\mitdback.bak"  
$blobName = "dbbackup\mitdback.bak"                   


Connect-AzAccount

# Get the storage account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageContext = $storageAccount.Context

# Upload the file to the Blob container
Write-Output "Uploading $filePath to container $containerName as $blobName..."
Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $storageContext
Write-Output "File uploaded successfully!"
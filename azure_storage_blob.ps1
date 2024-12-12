# Variables
$resourceGroupName = "rg-1" 
$storageAccountName = "st-1" 
$containerName = "backup" 
$filePath = "C:\Users\Downloads\mitdback.bak"  
$blobName = "backup\mitdback.bak"                   


Connect-AzAccount

# Get the storage account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageContext = $storageAccount.Context

# Upload the file to the Blob container
Write-Output "Uploading $filePath to container $containerName as $blobName..."
Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $storageContext
Write-Output "File uploaded successfully!"
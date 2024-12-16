# Variables
$resourceGroupName = "RG1"   # Replace with your Resource Group name
$storageAccountName = "ST1" # Replace with your Storage Account name
$containerName = "dbbackuptoday"           # Replace with your Blob container name
$filePath = "D:\Daily_DB_Backup_PROD\dbbackup.bak"         # Replace with the file you want to upload
$blobName = "dbbackupmit\dbbackup.bak"                   # The name you want for the file in the Blob container

# Authenticate to Azure (if not already done)
Connect-AzAccount

# Get the storage account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageContext = $storageAccount.Context

# Upload the file to the Blob container
Write-Output "Uploading $filePath to container $containerName as $blobName..."
Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $storageContext
Write-Output "File uploaded successfully!"
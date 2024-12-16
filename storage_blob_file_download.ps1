# Variables
$resourceGroupName = "RG1"   # Replace with your Resource Group name
$storageAccountName = "ST1"   # Replace with your Storage Account name
$containerName = "backupmsql"    # Replace with your Blob container name
$blobName = "exportbackup-1202-183333\BackupConfigDetails.txt" # Name of the file in the container
$destinationPath = "D:\mysql\BackupConfigDetails.txt" # Local path to save the file

# Authenticate to Azure
Connect-AzAccount

# Get the storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value

# Create a storage context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Download the file
Get-AzStorageBlobContent -Container $containerName -Blob $blobName -Destination $destinationPath -Context $storageContext

Write-Host "File downloaded successfully to $destinationPath"

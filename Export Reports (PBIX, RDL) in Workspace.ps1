Connect-PowerBIServiceAccount

$groupId = "YOUR WORKSPACE ID"
$restURL = "https://api.powerbi.com/v1.0/myorg/groups/$groupId/reports"
$restResponse = Invoke-PowerBIRestMethod -Url $restURL -Method GET | ConvertFrom-Json

$OutFolder = "C:\New Folder\" 

foreach ($item in $restResponse.value) {
    $OutFile = $OutFolder + $item.name + ($(if ($item.reportType -eq "PowerBIReport") {".pbix"} elseif ($item.reportType -eq "PaginatedReport") {".rdl"} else {""}))

    if ($OutFile -ne $OutFolder + $item.name) {
        Invoke-PowerBIRestMethod -Method GET -Url "https://api.powerbi.com/v1.0/myorg/groups/$groupId/reports/$($item.id)/Export" -OutFile $OutFile
    }
}
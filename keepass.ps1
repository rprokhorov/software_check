$URLPage = 'https://keepass.info/download.html'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
($result.Links | Where-Object {$_.outerHTML -like '*keepass 2*MSI*'}).outerHTML -match 'keepass 2[0-9\.]+ MSI' | Out-Null
$script:Version = $Matches[0] -replace '[a-z -]'
$script:FileName = $script:FileName -replace '%version%', $script:version
$DownloadURL = ($result.Links | Where-Object {$_.outerHTML -like '*keepass 2*MSI*'}).href
$result = [PSCustomObject]@{
    TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
    Product = 'KeePass'
    Version = $version
    Searchlink = $URLPage
    Download_link_x86 = $DownLoadURL
    Download_link_x64 = $DownLoadURL
    icon = "https://raw.githubusercontent.com/rprokhorov/LikePatchMyPC/master/Applications/KeePass/icon.png"
    LocalizedDescription = @{
        ru = "KeePass Password Safe — кроссплатформенная свободная программа для хранения паролей, распространяемая по лицензии GPL. Программа разработана Домиником Райхлом, изначально только для операционной системы Windows."
        en = "KeePass - the free, open source, light-weight and easy-to-use password manager."
    }
    Publisher = 'Dominik Reichl'
}

$result | ConvertTo-Json
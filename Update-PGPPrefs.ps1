###

#$Path2PGPPrefs = $env:appdata +"\PGP Corporation\PGP\PGPprefs.xml"
$Path2PGPPrefs = ".\PGPprefs.xml" #Testing
$SearchStrings = @("passthroughInboundSMIME","mailSmimeDecryptWithAnyKey","annotateMessages")
$XMLTextContent = Get-Content -Path $Path2PGPPrefs
$falseSetting = "<false></false>"
$trueSetting = "<true></true>"


ForEach($sString in $SearchStrings){

    $strposarr = Select-String -Path $Path2PGPPrefs -Pattern $sString

    Write-Host "### Looking for Setting: "$sString" ###"
    Write-Host "### "$strposarr.count" occurences found. ###"

    ForEach($strpos in $strposarr){

        if($sString -eq "annotateMessages"){
            $XMLTextContent[$strpos.linenumber] = $XMLTextContent[$strpos.linenumber] -replace $trueSetting,$falseSetting
        }
        else{
            $XMLTextContent[$strpos.linenumber] = $XMLTextContent[$strpos.linenumber] -replace $falseSetting,$trueSetting
        }
        $XMLTextContent|Set-Content -Path $Path2PGPPrefs        
        Write-Host "### Configured setting in Line:" $strpos.linenumber" ###"
    }
}
Write-Host -ForegroundColor green  "Done!"
Write-Host -ForegroundColor green "=> You can now close this window and start Symantec Encryption Desktop again."

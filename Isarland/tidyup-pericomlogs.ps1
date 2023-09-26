<#
    description:

        LÃ¶scht die Pericom-Logfiles auf den Pack-PCs,
        wenn die DateigrÃ¶ÃŸe $size Ã¼berschritten wird.
        Script wird per GPO bei jedem Systemstart ausgefÃ¼hrt.

    author: flo.alt@fa-netz.de
    version:  0.1

#>

## set variables

    $pathtofile = "C:\Program Files\Pericom_PrintPos\log\service_out.log"
    $size = 10       # [MB]
    $logdir = "C:\Windows\Logs\tidyup-pericomlogs"
    $logfile = $logdir + "\tidyup-" + (Get-Date -Format "yyyyMMdd") + ".log"
    $logcount = 30

# prepare logfile

    if (!(Test-Path $logdir)) {mkdir $logdir}
    $now = (Get-Date -Format "dd.MM.yyyy HH:mm:ss")
    Write-Output "`n---- Starting $now ----`n" >> $logfile

    # delete logfiles (keep $logcount files)

    Get-ChildItem $logdir -Filter *.log | Sort-Object LastWriteTime -Descending | Select-Object -Skip $logcount | Remove-Item -Force


## define the function

    function tidyupsize {

        $item = Get-ChildItem -Path $pathtofile
        if ( $item.Length/1MB -gt $size ) {
            Get-Service -DisplayName "Pericom PrintPOS" | Stop-Service
            Remove-Item $pathtofile
            Write-Output "OK: Removing $pathtofile" >> $logfile
            Get-Service -DisplayName "Pericom PrintPOS" | Start-Service
        } else {
            Write-Output "INFO: Filesize did not exceed $size. Nothing to do." >> $logfile
        }

    }



## check if file exist:

    if (!(Test-Path $pathtofile)) { Write-Output "ERROR: File not found." >> $logfile }


## here we go:

    tidyupsize
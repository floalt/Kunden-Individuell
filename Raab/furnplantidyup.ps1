<#
    description:

        Bereinigt das Datenverzeichnis von Furnplan
        Bei Furnplan-Updates werden alte Daten nicht gelöscht sondern archiviert.
        Somit entsteht ein "Müllhaufen", der hiermit regelmäßig abgetragen wird

    author: flo.alt@fa-netz.de
    version:  0.1

#>

# Set parameters

    $furnpath_1 = "D:\furnplan"
    $filter_1 = "old_20*"

    $furnpath_2 = "D:\furnplan\setup\updates"
    $filter_2 = "furnplan Handel_20*"

    $keep = 2   # how many old copys to keep



function tidyup {

    $items = Get-ChildItem -Path $tidypath -Filter $filter | Sort-Object Name -Descending
    $counts = $items.Count

    $c = $counts - 1   # remember: arrays start at [0] and not at [1]
    $e = $keep - 1

    while ($c -gt $e) {
        Write-Host "Deleting:" $items[$c].FullName
        Remove-Item -Recurse $items[$c].FullName
        $c = $c -1
    }
}


# delete the files

    $tidypath = $furnpath_1
    $filter = $filter_1

    tidyup

    $tidypath = $furnpath_2
    $filter = $filter_2

    tidyup
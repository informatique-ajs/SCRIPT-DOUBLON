$cheminRecherche = "C:\Users\tbury"

$cheminSortieHtml = "C:\Users\tbury\Desktop\doublons.html"



$fichiers = Get-ChildItem $cheminRecherche -Recurse -File -ErrorAction SilentlyContinue |

  Where-Object {

    $_.FullName -notmatch 'thumb' -or

    $_.FullName -notmatch 'nt' -or

    $_.FullName -notmatch 'user'

  }



$totalFichiers = $fichiers.Count

$compteur = 0

$hashTable = @{}



$fichiers | ForEach-Object {

$compteur++

if ($compteur % 100 -eq 0) {

$pourcentage = [math]::Round(($compteur / $totalFichiers) * 100, 2)

Write-Progress -Activity "Analyse des fichiers" -Status "$pourcentage% complete" -PercentComplete $pourcentage

}



try {

    $hash = (Get-FileHash $_.FullName -Algorithm MD5 -ErrorAction Stop).Hash

    if ($hashTable.ContainsKey($hash)) {

      $hashTable[$hash] += $_.FullName

    } else {

      $hashTable[$hash] = @($_.FullName)

    }

  } catch {}

}





Write-Progress -Activity "Analyse des fichiers" -Completed

Write-Host "Analyse terminée. Préparation du rapport..."



$doublons = $hashTable.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }

$totalGroupes = $doublons.Count

$compteurGroupes = 0


# Création du contenu HTML de base

$contenuHtml = @"

<!DOCTYPE html>

<html>

<head>

  <title>Rapport des fichiers en double</title>

	

	<p>Nombre total de groupes de fichiers en double : $totalGroupes</p>

	

  <style>

    body { font-family: Arial, sans-serif; }

    table { border-collapse: collapse; width: 100%; }

    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }

    th { background-color: #f2f2f2; }

    tr:nth-child(even) { background-color: #f9f9f9; }

    tr:hover { background-color: #f5f5f5; }

  </style>

</head>

<body>

  <h1>Rapport des fichiers en double</h1>

  <table>

    <tr>

      <th>Nombre de doublons</th>

      <th>Fichiers</th>

    </tr>

"@



# Ajout des données dans le tableau HTML

foreach ($groupe in $doublons) {

  $compteurGroupes++

  $pourcentageRapport = [math]::Round(($compteurGroupes / $totalGroupes) * 100, 2)

  Write-Progress -Activity "Préparation du rapport" -Status "$pourcentageRapport% complete" -PercentComplete $pourcentageRapport



  $nombreDoublons = $groupe.Value.Count

  $contenuHtml += "<tr><td>$nombreDoublons</td><td>"

  foreach ($fichier in $groupe.Value) {

    $contenuHtml += "$fichier<br>"

  }

  $contenuHtml += "</td></tr>"

}



# Fermeture du tableau et du corps HTML

$contenuHtml += @"

  </table>

 

</body>

</html>

"@



# Enregistrement du contenu dans le fichier HTML

$contenuHtml | Out-File -FilePath $cheminSortieHtml -Encoding utf8



Write-Progress -Activity "Préparation du rapport" -Completed


Write-Host "L'analyse est terminée. Le rapport HTML a été enregistré dans $cheminSortieHtml"
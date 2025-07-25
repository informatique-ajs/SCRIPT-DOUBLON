Sortie
------

Le script génère un fichier HTML contenant :

*   Le nombre total de groupes de fichiers en double
    
*   Un tableau avec :
    
    *   Le nombre de doublons par groupe
        
    *   La liste complète des chemins des fichiers identiques
        

Exemple de rapport
------------------

Nombre total de groupes de fichiers en double : 15  
┌─────────────────────┬─────────────────────────────────────┐  
│ Nombre de doublons  │ Fichiers                            │  
├─────────────────────┼─────────────────────────────────────┤  
│ 3                   │ C:\Users\tbury\image1.jpg           │  
│                     │ C:\Users\tbury\Photos\image1.jpg    │  
│                     │ C:\Users\tbury\Backup\image1.jpg    │  
└─────────────────────┴─────────────────────────────────────┘   


Filtres appliqués
-----------------

Le script exclut automatiquement les fichiers dont le chemin contient :

*   thumb (fichiers de miniatures)
    
*   nt (fichiers système Windows NT)
    
*   user (certains fichiers utilisateur temporaires)
    

Prérequis
---------

*   Windows PowerShell 5.0 ou supérieur
    
*   Droits de lecture sur le répertoire à analyser
    
*   Espace disque suffisant pour le fichier de rapport
    

Performances
------------

*   Affichage de la progression tous les 100 fichiers traités
    
*   Optimisé pour les gros volumes de fichiers
    
*   Gestion mémoire efficace avec table de hachage
    

Remarques importantes
---------------------

*   L'analyse peut prendre du temps selon le nombre de fichiers
    
*   Les fichiers inaccessibles sont ignorés silencieusement
    
*   Le rapport HTML est encodé en UTF-8 pour supporter les caractères spéciaux
    
*   Seuls les fichiers réellement identiques (même contenu) sont détectés comme doublons
    

Personnalisation
----------------

Vous pouvez modifier les filtres d'exclusion en ajustant cette ligne :

powershell

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Where-Object { $_.FullName -notmatch 'thumb' -or $_.FullName -notmatch 'nt' -or $_.FullName -notmatch 'user' }   `

Support
-------

Ce script a été testé sur Windows 10/11 avec PowerShell 5.1 et versions supérieures.
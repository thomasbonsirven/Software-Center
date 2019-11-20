<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Setup SoftwareCenter
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '400,526'
$Form.text                       = "Setup Software Centre"
$Form.TopMost                    = $false

$BoxChooseLanguage               = New-Object system.Windows.Forms.Groupbox
$BoxChooseLanguage.height        = 110
$BoxChooseLanguage.width         = 340
$BoxChooseLanguage.text          = "Your language"
$BoxChooseLanguage.location      = New-Object System.Drawing.Point(31,70)

$DorpdownLanguage                = New-Object system.Windows.Forms.ComboBox
$DorpdownLanguage.text           = "Choose"
$DorpdownLanguage.width          = 163
$DorpdownLanguage.height         = 20
@('French','English') | ForEach-Object {[void] $DorpdownLanguage.Items.Add($_)}
$DorpdownLanguage.location       = New-Object System.Drawing.Point(20,31)
$DorpdownLanguage.Font           = 'Microsoft Sans Serif,10'

$BoxBDDChoice                    = New-Object system.Windows.Forms.Groupbox
$BoxBDDChoice.height             = 110
$BoxBDDChoice.width              = 340
$BoxBDDChoice.text               = "Database"
$BoxBDDChoice.location           = New-Object System.Drawing.Point(31,185)

$RadioSQLITE                     = New-Object system.Windows.Forms.RadioButton
$RadioSQLITE.text                = "SQLite ( Local Database )"
$RadioSQLITE.AutoSize            = $true
$RadioSQLITE.width               = 104
$RadioSQLITE.height              = 20
$RadioSQLITE.location            = New-Object System.Drawing.Point(10,31)
$RadioSQLITE.Font                = 'Microsoft Sans Serif,10'

$RadioMySQL                      = New-Object system.Windows.Forms.RadioButton
$RadioMySQL.text                 = "MySQL ( Local or Web/Cloud )"
$RadioMySQL.AutoSize             = $true
$RadioMySQL.enabled              = $false
$RadioMySQL.width                = 104
$RadioMySQL.height               = 20
$RadioMySQL.location             = New-Object System.Drawing.Point(10,51)
$RadioMySQL.Font                 = 'Microsoft Sans Serif,10,style=Strikeout'

$BoxInstallDir                   = New-Object system.Windows.Forms.Groupbox
$BoxInstallDir.height            = 110
$BoxInstallDir.width             = 340
$BoxInstallDir.text              = "Installation Directory"
$BoxInstallDir.location          = New-Object System.Drawing.Point(31,300)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 168
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(6,27)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$InstallDirBrowse                = New-Object system.Windows.Forms.Button
$InstallDirBrowse.text           = "Browse"
$InstallDirBrowse.width          = 60
$InstallDirBrowse.height         = 30
$InstallDirBrowse.location       = New-Object System.Drawing.Point(49,59)
$InstallDirBrowse.Font           = 'Microsoft Sans Serif,10'

$ButInstallation                 = New-Object system.Windows.Forms.Button
$ButInstallation.text            = "Install"
$ButInstallation.width           = 60
$ButInstallation.height          = 30
$ButInstallation.location        = New-Object System.Drawing.Point(18,481)
$ButInstallation.Font            = 'Microsoft Sans Serif,10'

$Title                           = New-Object system.Windows.Forms.Label
$Title.text                      = "Setup Software Center Server"
$Title.AutoSize                  = $true
$Title.width                     = 25
$Title.height                    = 10
$Title.location                  = New-Object System.Drawing.Point(64,19)
$Title.Font                      = 'Microsoft Sans Serif,15'

$Form.controls.AddRange(@($BoxChooseLanguage,$BoxBDDChoice,$BoxInstallDir,$ButInstallation,$Title))
$BoxChooseLanguage.controls.AddRange(@($DorpdownLanguage))
$BoxBDDChoice.controls.AddRange(@($RadioSQLITE,$RadioMySQL))
$BoxInstallDir.controls.AddRange(@($TextBox1,$InstallDirBrowse))

$ButInstallation.Add_Click({ CheckandInstall })
$InstallDirBrowse.Add_Click({ Browser })




Function Select-FolderDialog
{
    param([string]$Description="Select Folder",[string]$RootFolder="Desktop")

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
     Out-Null     

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Error "Operation cancelled by user."
        }
    }

function Browser { 
$TextBox1.Text = Select-FolderDialog
}










function CheckandInstall { 


if ($RadioSQLITE.Checked -eq$true){
           $BDD = "bdd=database.sqlite" }
if ($RadioMySQL.Checked -eq$true){
           $BDD = "mysql="}
if ( ($RadioSQLITE.Checked -eq$false) -and ($RadioMySQL.Checked -eq$false) ) {
    Write-host The Database is required !
    $BoxBDDChoice.ForeColor          = "#ff0000"

    }
    
    







#Set the destination path
$DestPath = $TextBox1.Text
$Lang = $DorpdownLanguage.SelectedItem





Write-host $BDD
Write-host $Lang
Write-host $DestPath



#New-Item -ItemType "directory" -Path "D:\Nextcloud\PowerShell\DBApplications"
#New-Item -ItemType "file" -Path "D:\Nextcloud\PowerShell\settings.ini"


}


#Write your logic code here

[void]$Form.ShowDialog()
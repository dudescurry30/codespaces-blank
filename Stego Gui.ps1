# Raymond Mwangi
# ITT-111 Topic 5
# Date: 2/3/2025
# References: www.youtube.com/watch?v-sc7uBxuwwYg (https://github.com/I-Am-Jakoby/hak5-submissions/blob/main/Assets/logo-170-px.png?raw=true)
Add-Type -AssemblyName System.Windows.Forms

function Show-GUIPrompt {
    param(
        [string]$MessagePrompt,
        [string]$PathPrompt
    )

    $form = New-Object Windows.Forms.Form
    $form.Text = "Hide Message"
    $form.Size = New-Object Drawing.Size(400, 230)
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $form.TopMost = $true

    $labelMessage = New-Object Windows.Forms.Label
    $labelMessage.Location = New-Object Drawing.Point(10, 20)
    $labelMessage.Size = New-Object Drawing.Size(360, 20)
    $labelMessage.Text = "Enter the message you want to hide:"
    $form.Controls.Add($labelMessage)

    $textBoxMessage = New-Object Windows.Forms.TextBox
    $textBoxMessage.Location = New-Object Drawing.Point(10, 50)
    $textBoxMessage.Size = New-Object Drawing.Size(360, 20)
    $form.Controls.Add($textBoxMessage)

    $labelPath = New-Object Windows.Forms.Label
    $labelPath.Location = New-Object Drawing.Point(10, 90)
    $labelPath.Size = New-Object Drawing.Size(360, 20)
    $labelPath.Text = "Enter the path of the file to hide the message in:"
    $form.Controls.Add($labelPath)

    $textBoxPath = New-Object Windows.Forms.TextBox
    $textBoxPath.Location = New-Object Drawing.Point(10, 120)
    $textBoxPath.Size = New-Object Drawing.Size(360, 20)
    $form.Controls.Add($textBoxPath)

    $buttonOK = New-Object Windows.Forms.Button
    $buttonOK.Location = New-Object Drawing.Point(140, 160)
    $buttonOK.Size = New-Object Drawing.Size(120, 30)
    $buttonOK.Text = "OK"
    $buttonOK.DialogResult = [Windows.Forms.DialogResult]::OK
    $form.Controls.Add($buttonOK)

    $form.AcceptButton = $buttonOK

    $result = $form.ShowDialog()

    if ($result -eq [Windows.Forms.DialogResult]::OK) {
        $message = $textBoxMessage.Text
        $path = $textBoxPath.Text
        Hide-Msg -Message $message -Path $path
    }
}

function Hide-Msg {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [string]$Message,

        [Parameter(Mandatory = $True)]        
        [string]$Path
    )

    # Temporary file to store the message
    $tempFile = Join-Path $Env:TEMP "hidden_message.txt"
    Set-Content -Path $tempFile -Value "`n`n$Message"

    # Append the message to the file in a binary-safe way
    $destinationFile = "$Path"
    [System.IO.File]::AppendAllText($destinationFile, [System.IO.File]::ReadAllText($tempFile))

    # Clean up the temporary file
    Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue
}

Show-GUIPrompt

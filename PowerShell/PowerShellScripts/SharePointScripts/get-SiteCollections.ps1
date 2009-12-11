[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | out-null

new-variable -Name sites
new-variable -Name vals

$form = new-object System.windows.forms.form 
$form.Text = "Select site collections"  
$form.MinimizeBox = $false  
$form.MaximizeBox = $false  
#$form.AutoSize = $true  
$form.AutoSizeMode = "GrowAndShrink" 
$form.Width = 150
$form.Height = 200

$cbl = New-Object System.windows.Forms.CheckedListBox

$cbl.items.Add("Agent") | Out-Null
$cbl.items.Add("Carrier") | Out-Null
$cbl.items.Add("Employer") | Out-Null
$cbl.Top = 40
$cbl.Left = 10

$label = New-Object System.windows.Forms.Label
$label.text = "Please select the site collection(s) to recreate"
$label.top = 2
$label.left = 10
$label.width = 150
$label.height = 40

$go = New-Object windows.Forms.Button

$go.text = "Go"
$go.height = 20
$go.width = 40
$go.top = 140
$go.left = 20


$event = { $form.close()
		   $form.Dispose()   }

$go.add_click($event)

$form.controls.add($label)

$form.controls.add($go)

$form.controls.add($cbl)

$Form.Add_Shown({$form.Activate()})  
 
$form.ShowDialog() | Out-Null

$cbl.CheckedItems
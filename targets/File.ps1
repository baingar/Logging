﻿@{
    Name = 'File'
    Configuration = @{
        Path = @{Required = $true; Type = [string]}
        PrintBody = @{Required = $false; Type = [bool]}
        Append = @{Required = $false; Type = [bool]}
        Encoding = @{Required = $false; Type = [string]}
        Level = @{Required = $false; Type = [string]}
        Format = @{Required = $false; Type = [string]}
    }
    Logger = {
        param(
            $Log, 
            $Format, 
            [hashtable] $Configuration
        )
        
        $Params = @{}
        
        $Params['FilePath'] = Replace-Tokens -String $Configuration.Path -Source $Log
        $Text = Replace-Tokens -String $Format -Source $Log
        
        if ($Configuration.PrintBody -and $Log.body_json) {
            $Text += ': {0}' -f $Log.body_json
        }
        
        if (-not $Configuration.ContainsKey('Append')) {$Params['Append'] = $true}
        else {$Params['Append'] = $Configuration.Append}
        
        if (-not $Configuration.ContainsKey('Encoding')) {$Params['Encoding'] = 'ascii'}
        else {$Params['Encoding'] = $Configuration.Encoding}
        
        $Text | Out-File @Params
    }
}
﻿@{
    Name = 'Console'
    Configuration = @{
        Level = @{Required = $false; Type = [string]}
        Format = @{Required = $false; Type = [string]}
    }
    Logger = {
        param(
            $Log, 
            $Format, 
            $Configuration
        )
        
        $ColorMapping = @{
            'DEBUG' = 'Blue'
            'INFO' = 'Green'
            'WARNING' = 'Yellow'
            'ERROR' = 'Red'
        }
        
        $Text = Replace-Tokens -String $Format -Source $Log
        $OldColor = $ParentHost.UI.RawUI.ForegroundColor
        $ParentHost.UI.RawUI.ForegroundColor = $ColorMapping[$Log.Level]
        $ParentHost.UI.WriteLine($Text)
        $ParentHost.UI.RawUI.ForegroundColor = $OldColor
    }
}
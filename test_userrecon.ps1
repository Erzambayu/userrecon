# PowerShell Test Script for UserRecon
# This simulates the functionality of userrecon_updated.sh for testing purposes

function Test-UserRecon {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    Write-Host "Testing username: $Username on various platforms..."
    Write-Host ""
    
    $results = @()
    
    # Function to check a site
    function Check-Site {
        param (
            [string]$Platform,
            [string]$Url,
            [string]$Pattern,
            [bool]$Invert
        )
        
        Write-Host "[$Platform]: " -NoNewline
        
        try {
            $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 10 -ErrorAction SilentlyContinue
            
            if ($response) {
                $content = $response.Content
                $statusCode = $response.StatusCode
                
                $patternFound = $content -match $Pattern
                
                if (($Invert -and -not $patternFound) -or (-not $Invert -and $patternFound)) {
                    Write-Host "Found! $Url" -ForegroundColor Green
                    $results += $Url
                    return $true
                } else {
                    Write-Host "Not Found!" -ForegroundColor Yellow
                    return $false
                }
            } else {
                Write-Host "Timeout or error!" -ForegroundColor Yellow
                return $false
            }
        } catch {
            Write-Host "Error or Not Found!" -ForegroundColor Yellow
            return $false
        }
    }
    
    # Test a few platforms (limited for testing purposes)
    Check-Site -Platform "GitHub" -Url "https://github.com/$Username" -Pattern "404" -Invert $true
    Check-Site -Platform "Twitter/X" -Url "https://x.com/$Username" -Pattern "This account doesn't exist" -Invert $true
    Check-Site -Platform "Instagram" -Url "https://www.instagram.com/$Username" -Pattern "Sorry, this page" -Invert $true
    
    # Display results
    Write-Host ""
    Write-Host "Test completed! Found $($results.Count) matches."
    if ($results.Count -gt 0) {
        Write-Host "Results:"
        $results | ForEach-Object { Write-Host "- $_" }
    }
}

# Get username from user
$inputUsername = Read-Host "Enter username to test"
Test-UserRecon -Username $inputUsername

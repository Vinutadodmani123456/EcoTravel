# Create a HttpClientHandler that disables automatic redirection
$handler = New-Object System.Net.Http.HttpClientHandler
$handler.AllowAutoRedirect = $false
$client = New-Object System.Net.Http.HttpClient($handler)

$loginUrl = "http://localhost:8080/EcoTravel/auth"
$hotelUrl = "http://localhost:8080/EcoTravel/destinations"

# 1. Admin Login
$loginFields = @{
    action = "login"
    username = "admin"
    password = "admin123"
    loginType = "admin"
}

$loginContent = New-Object System.Net.Http.FormUrlEncodedContent([System.Collections.Generic.KeyValuePair[string, string][]]@(
    [System.Collections.Generic.KeyValuePair[string, string]]::new("action", $loginFields.action),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("username", $loginFields.username),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("password", $loginFields.password),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("loginType", $loginFields.loginType)
))

Write-Host "Logging in as admin..."
$loginTask = $client.PostAsync($loginUrl, $loginContent)
$loginTask.Wait()
$loginResponse = $loginTask.Result

$loginStatusCode = [int]$loginResponse.StatusCode
$loginRedirect = $loginResponse.Headers.Location.ToString()

Write-Host "Login Status Code:" $loginStatusCode
Write-Host "Login Redirect Location:" $loginRedirect

if ($loginStatusCode -eq 302 -and $loginRedirect -like "*destinations?action=admin*") {
    Write-Host "Admin Login Successful!"
} else {
    Write-Host "Admin Login Failed!"
    exit 1
}

# Extract Set-Cookie header to maintain session
$cookieHeaders = $loginResponse.Headers.GetValues("Set-Cookie")
$sessionCookie = ""
foreach ($cookie in $cookieHeaders) {
    if ($cookie -like "JSESSIONID=*") {
        $sessionCookie = $cookie.Split(";")[0]
        break
    }
}
Write-Host "Session Cookie:" $sessionCookie

# 2. Add Hotel
# Create a new HTTP request to add the hotel, passing the session cookie
$hotelRequest = New-Object System.Net.Http.HttpRequestMessage
$hotelRequest.Method = [System.Net.Http.HttpMethod]::Post
$hotelRequest.RequestUri = New-Object System.Uri($hotelUrl)

$hotelFields = @(
    [System.Collections.Generic.KeyValuePair[string, string]]::new("action", "addHotel"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("destinationId", "1"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("name", "HttpClient Eco Lodge"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("description", "A green hotel added via HttpClient testing"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("imageUrl", "https://images.unsplash.com/photo-1566073771259-6a8506099945"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("ecoRating", "4"),
    [System.Collections.Generic.KeyValuePair[string, string]]::new("pricePerNight", "1200")
)
$hotelRequest.Content = New-Object System.Net.Http.FormUrlEncodedContent([System.Collections.Generic.KeyValuePair[string, string][]]$hotelFields)
$hotelRequest.Headers.Add("Cookie", $sessionCookie)

Write-Host "Adding a hotel..."
$hotelTask = $client.SendAsync($hotelRequest)
$hotelTask.Wait()
$hotelResponse = $hotelTask.Result

$hotelStatusCode = [int]$hotelResponse.StatusCode
$hotelRedirect = $hotelResponse.Headers.Location.ToString()

Write-Host "Hotel Addition Status Code:" $hotelStatusCode
Write-Host "Hotel Addition Redirect:" $hotelRedirect

if ($hotelStatusCode -eq 302 -and $hotelRedirect -like "*hotelMsg=Hotel+Added+Successfully!*") {
    Write-Host "SUCCESS: Hotel added successfully and redirect contains hotelMsg!"
    exit 0
} else {
    Write-Host "FAILURE: Hotel addition failed or redirect was incorrect!"
    exit 1
}

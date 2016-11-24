#!/usr/bin/php
<?php
################################################################################
#GRUPO GOOGLEINURL BRASIL - PESQUISA AVANÇADA.
#SCRIPT NAME: INURLBR API face
#AUTOR:    Cleiton Pinheiro
#Nick:     Googleinurl
#Blog:     http://blog.inurl.com.br
#twitter: /@googleinurl
#facebook: /InurlBrasil
#Versão:  1.0
#-------------------------------------------------------------------------------
#PHP Version         5.4.7
#php5-curl           LIB
#php5-cli            LIB  
#cURL support        enabled
#cURL Information    7.24.0
#Apache              2.4
#allow_url_fopen     On
#permission          Reading
#Operating system    LINUX              
################################################################################
error_reporting(0);
ini_set('display_errors', 0);
!isset($_SESSION) ? session_start() : NULL;
$_SESSION['config'] = array();
system("command clear");
echo menu();
 
function getHttpResponseCode($url) {
    $curl = curl_init();
   //print_r($url);
    curl_setopt($curl, CURLOPT_URL, ($url));
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    //curl_setopt($curl, CURLOPT_PROXY,"localhost:8118");      
    return curl_exec($curl);
}
 
if (isset($argv[1]) && !empty($argv[1])) {
 
    $_SESSION['config'] = json_decode(getHttpResponseCode("http://graph.facebook.com/{$argv[1]}"), true);
    $_SESSION['config2'] = getHttpResponseCode("http://api.facebook.com/method/fql.query?query=" . urlencode("SELECT uid,username, name, first_name, middle_name, last_name, sex, locale, pic_small_with_logo, pic_big_with_logo, pic_square_with_logo, pic_with_logo, username FROM user WHERE uid ={$_SESSION['config']['id']}"));
 
    $xml = simplexml_load_string($_SESSION['config2']);
    $array_ = json_decode(json_encode((array) $xml), 1);
    $array = array($xml->getName() => $array_);
    echo
 
    "\033[1;34m
================================================================================================================
                                         DADOS FACEBOOK
================================================================================================================
\n";
    echo "\033[1;37m0x\033[0m\033[02;31mLINK:: \033[1;37m" . (isset($_SESSION['config']['link']) ? $_SESSION['config']['link'] : NULL ) . "\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mID:: \033[1;37m{$array['fql_query_response']['user']['uid']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mUSERNAME:: \033[1;37m{$array['fql_query_response']['user']['username']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mNOME:: \033[1;37m{$array['fql_query_response']['user']['name']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mPRIMEIRO NOME:: \033[1;37m{$array['fql_query_response']['user']['first_name']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mSOBRENOME:: \033[1;37m{$array['fql_query_response']['user']['last_name']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mSEXO:: \033[1;37m{$array['fql_query_response']['user']['sex']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mLOCAL:: \033[1;37m{$array['fql_query_response']['user']['locale']}\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mFOTO LOGO PEQUENA:: \033[1;37m" . urldecode($array['fql_query_response']['user']['pic_small_with_logo']) . "\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mFOTO LOGO GRANDE:: \033[1;37m" . urldecode($array['fql_query_response']['user']['pic_big_with_logo']) . "\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mFOTO LOGO:: \033[1;37m" . urldecode($array['fql_query_response']['user']['pic_square_with_logo']) . "\n\n";
    echo "\033[1;37m0x\033[0m\033[02;31mFOTO:: \033[1;37m" . urldecode($array['fql_query_response']['user']['pic_with_logo']) . "\n\n\033[0m";
 
    echo "http://www.facebook.com/ajax/typeahead_friends.php?u={$_SESSION['config']['id']}&__a=1\n";
    $_SESSION['config3'] = getHttpResponseCode("http://www.facebook.com/ajax/typeahead_friends.php?u={$_SESSION['config']['id']}&__a=1");
    echo "================================================================================================================\n";
 
 
    $cont = 0;
    $array2 = (explode('{"', $_SESSION['config3']));
    foreach ($array2 as $valores) {
        $valores = str_replace('],"viewer_id":0},"bootloadable":{},"ixData":[]}', '', str_replace(',"n":"","it":null}', '', $valores));
        $valores = str_replace('"u":', "\033[1;37mURL::\033[0m\033[1;34m", str_replace('t":', "\033[1;37mNOME::\033[0m\033[1;34m", str_replace('"i"', "\033[1;37mID::\033[0m\033[1;34m", str_replace('\/', '/', $valores))));
        echo "\033[02;31m[\033[1;37m".$cont++."\033[02;31m]\033[0m - $valores\n";
    }
} else {
 
    echo menu() . "   Falta definir parâmetro de busca, Exemplo=> php face.php usuario\n";
}
 
function menu() {
    system("command clear");
    return("
\033[1;37m _____
\033[1;37m(_____)  
\033[1;37m(\033[02;31m() ()\033[1;37m)
\033[1;37m \   /  
\033[1;37m  \ /
\033[1;37m  /=\
\033[1;37m [___] / Googleinurl - [ INURLBR API face  ]  
\033[1;37m0xNeither war between hackers, nor peace for the system.
\033[1;37m0x\033[0m\033[02;31mhttp://blog.inurl.com.br
\033[1;37m0x\033[0m\033[02;31mhttps://fb.com/InurlBrasil
\033[1;37m0x\033[0m\033[02;31mhttp://twitter.com/@googleinurl\033[0m
[+] Pesquisa dados facebook, Ex: php face.php zuck
");
}

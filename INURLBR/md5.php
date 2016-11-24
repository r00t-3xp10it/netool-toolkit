<?php
################################################################################
#GRUPO GOOGLEINURL BRASIL - PESQUISA AVANÇADA.
#SCRIPT NAME: INURLBR API DecrypterMD5
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
#permission          Reading & Writing
#User                root privilege, or is in the sudoers group
#Operating system    LINUX
#Proxy random        TOR                 
################################################################################
system("command clear");
!isset($_SESSION) ? session_start() : NULL;
$_SESSION['config'] = array();
$_SESSION['config']['cont'] = 0;
$_SESSION['config']['cont2'] = 0;
$opcoes = (PHP_SAPI === 'cli') ? getopt('h', ['md5:', 'file:', 'proxy:', 'cont']) : NULL;
$opcoes['host_tor'] = 'http://dynupdate.no-ip.com/ip.php';
echo isset($opcoes['h']) ? menu() : NULL;
function request_info($curl, $md5, $opcoes) {
    $url_ = "http://md5.gromweb.com/query/{$md5}";
    (!is_null($opcoes['proxy']) && !empty($opcoes['proxy']) ? curl_setopt($curl, CURLOPT_PROXY, $opcoes['proxy']) : NULL);
    curl_setopt($curl, CURLOPT_URL, $url_);
    curl_setopt($curl, CURLOPT_USERAGENT, 'AGENT:BLOG.INURL.COM.BR');
    curl_setopt($curl, CURLOPT_REFERER, "http://blog.inurl.com.br/" . md5(intval(rand() % 255) . intval(rand() % 255) . intval(rand() % 255) . intval(rand() % 255)));
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $corpo = curl_exec($curl);
    curl_close($curl);
    unset($curl);
    return isset($corpo) ? !empty($corpo) ? "\033[0;32m{$corpo}\033[0m" : 'NOT FOUND'  : FALSE;
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
\033[1;37m [___] / Googleinurl - [ INURLBR API DecrypterMD5  ]   
\033[1;37m0xNeither war between hackers, nor peace for the system.
\033[1;37m0x\033[0m\033[02;31mhttp://blog.inurl.com.br
\033[1;37m0x\033[0m\033[02;31mhttps://fb.com/InurlBrasil
\033[1;37m0x\033[0m\033[02;31mhttp://twitter.com/@googleinurl\033[0m
[+] Pesquisa por arquivo, Ex: php md5.php --file filemd5.txt
[+] Pesquisa simples, Ex: php md5.php --md5 21232f297a57a5a743894a0e4a801fc3
    Proxy camuflagem envio de request.
     - Exemplo: --proxy {proxy:porta}
     - Uso:     --proxy localhost:8118
                --proxy socks5://googleinurl@localhost:9050
                --proxy http://admin:12334@172.16.0.90:8080
\n\r
 ");
}
function renovaTOR() {
    echo "\n[ IP NETWORK TOR RENEWED ] \n";
    system("[ -z 'pidof tor' ] || pidof tor | xargs sudo kill -HUP;");
    $_SESSION['config']['cont'] = 0;
    /* https://pt.wikipedia.org/wiki/Pidof
     * pidof é um utilitário Linux que encontra o ID de um programa em execução.
     * Note que o próprio nome é a junção dos termos pid, que significa identidade
     * de um processo e of que significa de. Portanto pidof quer dizer identidade 
     * de processo de...
     * O equivalente no Solaris é pgrep. pidof firefox-bin O comando acima retorna 
     * o pid do processo que está executando firefox-bin.
     * Pode-se combinar o comando 'pidof' com o comando kill dessa forma:
     * kill -9 $(pidof firefox-bin) pidof é simplesmente uma ligação simbólica 
     * para o programa killall5,que está localizado em /sbin.
     */
}
function msg($md5, $opcoes) {
    if (!is_null($md5)) {
        $result = request_info($curl = curl_init(), $md5, $opcoes);
        if (!strstr($result, 'Too much requests from your host. Temporary ban applied.') && !strstr($result, '<title>MD5 conversion and MD5 reverse lookup</title>')) {
            echo "\n\033[02;31m[ {$_SESSION['config']['cont2']} ]=>MD5=>\033[1;37m{$md5}\033[0m \ SENHA:: {$result}";
            echo "\033[0m\n\r-------------------------------------------------------------------------\n\r";
            $_SESSION['config']['cont2'] ++;
        } else {
            renovaTOR();
        }
    }
}
if (isset($opcoes['md5']) && !empty($opcoes['md5'])) { //arquivo
    echo menu() . "[+]Loading...\n\r";
    msg($opcoes['md5'], $opcoes);
}
if (isset($opcoes['file']) && !empty($opcoes['file'])) { //arquivo
    $ponteiro = fopen($opcoes['file'], "r");
    echo menu() . "[+]Loading...\n\r";
    while (!feof($ponteiro)) {
        $md5 = str_replace("\t", '', str_replace("\n", '', str_replace("\r", '', fgets($ponteiro, 4096))));
        !empty($md5) ? msg($md5, $opcoes) : NULL;
    }
    fclose($ponteiro);
}
echo!isset($opcoes['file']) && !isset($opcoes['md5']) ? menu() : NULL;
unset($_SESSION);

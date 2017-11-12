
# Follow this page to avoid enter password
# http://apple.stackexchange.com/questions/236806/prevent-networksetup-from-asking-for-password
function proxy() {
    network=$(networksetup -listallnetworkservices | row 3)
    case "$1" in
    on)
        sudo networksetup -setwebproxystate $network on;
        sudo networksetup -setsecurewebproxystate $network on;
        sudo networksetup -setwebproxy $network 127.0.0.1 8888;
        sudo networksetup -setsecurewebproxy $network 127.0.0.1 8888;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxystate $network off;
        ;;
    g)
        sudo networksetup -setwebproxystate $network off;
        sudo networksetup -setsecurewebproxystate  $network off;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxy "$network" localhost 1086
        ;;
    off)
        sudo networksetup -setwebproxystate $network off;
        sudo networksetup -setsecurewebproxystate  $network off;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxystate $network off;
        ;;
    s)
        socks_status=$(networksetup -getsocksfirewallproxy $network | head -n 3;)
        socks_enable=$(echo $socks_status | head -n 1 | awk '{print $2}')
        socks_ip=$(echo $socks_status | head -n 2 | tail -n 1 | awk '{print $2}')
        socks_port=$(echo $socks_status | tail -n 1 | awk '{print $2}')

        if [ "$socks_enable" = "Yes" ]; then
            echo -e "${green}Socks: ✔${NC}" $socks_ip ":" $socks_port
        else
            echo -e "${RED}Socks: ✘${NC}" $socks_ip ":" $socks_port
        fi

        http_status=$(networksetup -getwebproxy $network | head -n 3)
        http_enable=$(echo $http_status | head -n 1 | awk '{print $2}')
        http_ip=$(echo $http_status | head -n 2 | tail -n 1 | awk '{print $2}')
        http_port=$(echo $http_status | tail -n 1 | awk '{print $2}')

        if [ "$http_enable" = "Yes" ]; then
            echo -e "${green}HTTP : ✔${NC}" $http_ip ":" $http_port
        else
            echo -e "${RED}HTTP : ✘${NC}" $http_ip ":" $http_port
        fi

        https_status=$(networksetup -getsecurewebproxy $network | head -n 3)
        https_enable=$(echo $https_status | head -n 1 | awk '{print $2}')
        https_ip=$(echo $https_status | head -n 2 | tail -n 1 | awk '{print $2}')
        https_port=$(echo $https_status | tail -n 1 | awk '{print $2}')

        if [ "$https_enable" = "Yes" ]; then
            echo -e "${green}HTTPS: ✔${NC}" $https_ip ":" $https_port
        else
            echo -e "${RED}HTTPS: ✘${NC}" $https_ip ":" $https_port
        fi
        ;;
    *)
        echo "Usage: p {on|off|g|s}"
        echo "p on : Set proxy to Charles(port 8888)"
        echo "p off: Reset proxy to system default"
        echo "p g  : Set proxy to Shadowsocks"
        echo "p s  : Show current network proxy status"
        echo "p *  : Show usage"
        ;;
    esac
}

alias p=proxy

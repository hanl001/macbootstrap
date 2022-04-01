function setup() {
    exe_cmd "setup_mac_config"
    exe_cmd "install"
    exe_cmd "link"
}

function setup_mac_config() {
    xcode-select --install | true
    # 禁用文字自动更正
    defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
    defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
    
    # 禁用三方 App 验证
    sudo spctl --master-disable
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    
    # 启用触摸板轻触点击
    defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    
    # 显示 ~/Library/ 目录
    chflags nohidden ~/Library
    
    # 显示电池电量百分比
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"
    
    # 自动展示/隐藏 dock
    defaults write com.apple.dock autohide -bool true
}

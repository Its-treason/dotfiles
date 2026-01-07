use std/dt [datetime-diff, pretty-print-duration]

def banner [] {
let foreground = $env.config.color_config?.banner_foreground? | default "attr_normal"
let highlight1 = $env.config.color_config?.banner_highlight1? | default "green"
let highlight2 = $env.config.color_config?.banner_highlight2? | default "purple"
let dt = (datetime-diff (date now) 2019-05-10T09:59:12-07:00)
let ver = (version)
let startup_time = $"(ansi $highlight1)(ansi attr_bold)Startup Time: (ansi reset)(ansi $foreground)($nu.startup-time)(ansi reset)"

let banner_msg = $"(ansi $highlight1)     __  ,(ansi reset)
(ansi $highlight1) .--\(\)°'.' (ansi reset)(ansi $foreground)Welcome to (ansi $highlight1)Nushell(ansi reset)(ansi $foreground),(ansi reset)
(ansi $highlight1)'|, . ,'   (ansi reset)(ansi $foreground)based on the (ansi $highlight1)nu(ansi reset)(ansi $foreground) language,(ansi reset)
(ansi $highlight1) !_-\(_\\    (ansi reset)(ansi $foreground)where all data is structured!

(ansi $foreground)Version: (ansi $highlight1)($ver.version) \(($ver.build_target)\)(ansi reset)

(ansi $foreground)It's been this long since (ansi $highlight1)Nushell(ansi reset)(ansi $foreground)'s first commit:(ansi reset)
(ansi $foreground)(pretty-print-duration $dt)
"
print $banner_msg;
}

banner


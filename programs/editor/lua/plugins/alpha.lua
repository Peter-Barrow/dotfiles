return {
    'goolord/alpha-nvim',

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        
        -- Set header
        dashboard.section.header.val = {
            "            :h-                                  Nhy`               ",
            "           -mh.                           h.    `Ndho               ",
            "           hmh+                          oNm.   oNdhh               ",
            "          `Nmhd`                        /NNmd  /NNhhd               ",
            "          -NNhhy                      `hMNmmm`+NNdhhh               ",
            "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
            "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
            "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
            "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
            " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
            " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
            " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
            " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
            "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
            "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
            "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
            "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
            "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
            "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
            "       //+++//++++++////+++///::--                 .::::-------::   ",
            "       :/++++///////////++++//////.                -:/:----::../-   ",
            "       -/++++//++///+//////////////               .::::---:::-.+`   ",
            "       `////////////////////////////:.            --::-----...-/    ",
            "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
            "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
            "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
            "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
            "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
            "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
            "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
            "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
            "                        .-:mNdhh:.......--::::-`                    ",
            "                           yNh/..------..`                          ",
            "                                                                    ",
        }
        
        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
            dashboard.button("s", "  > Sessions", ":Telescope persisted <CR>"),
            -- dashboard.button("s", "  > Sessions", ":Telescope session-lens search_session<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("c", "  > Confguration", ":e ~/.config/nvim/init.lua | :cd %:p:h | pwd<CR>"),
            dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
        }
        
        -- Send config to alpha
        alpha.setup(dashboard.opts)
        
        -- Disable folding on alpha buffer
        vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])

    end
}

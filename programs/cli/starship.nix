{ pkgs, ... }: {
    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            format = "
[┌───────────────────• ](bold green)$battery$directory$git_branch$git_commit$c$ocaml$python$swift$zig
[└─>](bold green) ";
            battery.display = [
                { threshold = 99; }
                { charging_symbol = "🗲\ "; }
            ];
        };
    };
}

{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    prefix = "C-a";
    shell = "/bin/zsh";
    mouse = true;
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.open
      {
        plugin = tmuxPlugins.battery;
        extraConfig = ''
        '';
      }
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = ''
            set -g @rose_pine_variant 'dawn'
            set -g @rose_pine_host 'on'
            set -g @rose_pine_date_time '%H:%M - %d/%m/%Y'
            set -g @rose_pine_directory 'on'
            set -g @rose_pine_bar_bg_disable 'on'
            set -g @rose_pine_show_current_program 'on'
            set -g @rose_pine_show_current_pane 'on'
            set -g @rose_pine_status_right_prepend_section 'Batt: #{battery_icon} #{battery_percentage}'
        '';
      }
    ];
    extraConfig = ''
      set-option -g mouse on

      set-window-option -g mode-keys vi
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      
      bind-key a send-prefix
      
      bind -n S-left  prev
      bind -n S-right next
      bind -n S-C-left  swap-window -t -1
      bind -n S-C-right swap-window -t +1
      
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      bind-key -n C-j resize-pane -U 1
      bind-key -n C-k resize-pane -D 1
      bind-key -n C-h resize-pane -L 1
      bind-key -n C-l resize-pane -R 1
      
      bind-key -n M-j resize-pane -U 10
      bind-key -n M-k resize-pane -D 10
      bind-key -n M-h resize-pane -L 10
      bind-key -n M-l resize-pane -R 10

      bind Escape copy-mode
      bind r source-file ~/.config/tmux/tmux.conf
   '';
   };
}

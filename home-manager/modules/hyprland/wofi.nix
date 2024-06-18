{ config, ... }: {
  programs.wofi = {
    enable = true;

    settings = {
      normal_window = true;
      # no_actions = false;
      hide_scroll = true;
      columns = 1;
      # image_size = 20;
      term = "foot";
      content_halign = "center";
      insensitive = true;
      allow_images = false;
      allow_markup = false;
      prompt = "";
      matching = "multi-contains";
      width = 364;
      height = 126;
      y = -30;
    };

    style =''
      * {
        all: initial;
      }

      * {
        font-family: ${config.font};
        font-weight: bold;
        font-size: 14px;
      }

      window {
        background-color: #${config.colors.bg};
      }

      #input {
        margin: 10px 5px;
        padding: 5px 10px;
        border-radius: 17px;
        border: solid #${config.colors.accent} 2px;
        background-color: #${config.colors.bg};
        color: #${config.colors.fg};
      }

      #outer-box {
        margin: 20px;
        padding: 0px;
      }

      #text {
        padding: 5px;
        color: #${config.colors.fg-dark};
      }

      #entry {
        padding: 3px 20px;
      }

      #entry:selected {
        border-radius: 9px;
        color: #${config.colors.fg};
      }

      #text:selected {
        color: #${config.colors.fg};
      }

      #img {}
      #unselected {}
    '';
  };
}

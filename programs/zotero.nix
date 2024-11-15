{config, pkgs, lib, ...}: {
    programs.zotero = {
        enabled = true;
        package = pkgs.zotero;
    };
}

{ ... }:

{
  #important! needed for automounting usbs etc 
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}

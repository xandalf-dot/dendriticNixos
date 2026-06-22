{ self, inputs, ... }: {

  flake.nixosModules.myHomeManager = { pkgs, ... }: {

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

}

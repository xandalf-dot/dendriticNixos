{inputs, self, ... }: {
  flake.nixosConfigurations.angmar2 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.angmar2Config
    ];
  };
}

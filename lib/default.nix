{ self, system, ... }:

{
  mkApp = package: {
    program = "${self.packages.${system}.${package}}/bin/${
      self.packages.${system}.${package}.meta.mainProgram
    }";
    type = "app";
  };
}

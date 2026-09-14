{
  description = "Python monorepo development shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python313.withPackages (
            ps: with ps; [
              pip
              notebook
              pandas
              matplotlib
              requests
              seaborn
              scipy
              scikit-learn
              optuna
              plotly
              jupyterlab
              ipykernel
              ipywidgets
            ]
          );
        in
        {
          default = pkgs.mkShell {
            packages = [ python ];
          };
        }
      );
    };
}

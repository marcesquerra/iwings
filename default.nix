let
  loader_builder = environment : {
    inherit environment;
    project =
      {name, modules ? "Main"}:
        environment.packages.stdenv.mkDerivation {
          inherit name;
          idris = environment.idris;
          moduleBuilder = environment.packages.basicDerivation {
            name    = "moduleBuilder";
            src = ./.;
            build = ''
              mkdir -p $out/bin
              cp $src/files/genModule.sh $out/bin/genModuleImpl.sh
              cp $src/files/iw $out/bin/iw
              chmod +x $out/bin/genModuleImpl.sh
              chmod +x $out/bin/iw
              echo "$out/bin/genModuleImpl.sh ${name} ${modules}" > $out/bin/genModule.sh
              chmod +x $out/bin/genModule.sh
                '';
          };
          buildInputs = [ environment.packages.gmp ];
        };
  };
in
  loader_builder

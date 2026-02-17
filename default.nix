{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "tq-cursor-collection";
  version = "1.0";

  # Mengambil semua file di direktori tempat default.nix berada
  src = ./.;

  # Kita menggunakan 'cp' dengan filter sederhana agar lebih bersih
  installPhase = ''
    # Buat direktori tujuan standar kursor Linux
    mkdir -p $out/share/icons

    # Loop melalui semua item di source
    for d in *; do
      # Cek apakah itu direktori dan memiliki file index.theme di dalamnya
      if [ -d "$d" ] && [ -f "$d/index.theme" ]; then
        echo "Installing cursor pack: $d"
        # Copy folder kursor tersebut ke folder icons sistem
        cp -pr "$d" $out/share/icons/
      fi
    done

    # Opsional: Hapus folder 'default' jika tidak sengaja terikut 
    # agar tidak konflik dengan Stylix
    rm -rf $out/share/icons/default
  '';

  meta = {
    description = "Koleksi kursor meme kustom untuk Linux";
    homepage = "https://github.com/TQ-See/Cursors-memes";
    license = pkgs.lib.licenses.free;
    maintainers = [ "tquilla" ];
  };
}

{colorscheme}:
with colorscheme.colors; let
  OSLogo = builtins.fetchurl rec {
    name = "OSLogo-${sha256}.png";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
  };
in ''
  *{
      font-family: JetBrainsMono Nerd Font;
      font-size: 13px;
  }


  window#waybar {
      background-color: transparent;
  }



  #workspaces button label{
      color: 	#EDEDED ;
      font-weight: bolder;
  }

  #workspaces button.active label{
      color: #181818;
      font-weight: bolder;
  }

  #workspaces{
      background-color: transparent;
      margin-top: 3px;
      margin-bottom: 10px;
      margin-right: 10px;
      margin-left: 25px;
  }
  #workspaces button{
      box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
      background-color: #181818 ;
      border-color: #181818 ;
      border-radius: 15px;
      margin-right: 10px;
      padding: 10px;
      padding-top: 1px;
      padding-bottom: 1px;
      font-weight: bolder;
      color: 	#FFFFFF ;
      transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
  }

  #workspaces button.active{
      padding-right: 20px;
      box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
      padding-left: 20px;
      padding-bottom: 0px;
      background: rgb(203,166,247);
      background: radial-gradient(circle, rgba(181,255,233,1) 0%, rgba(99,161,233,1) 50%, rgba(170,120,166,1) 100%);
      background-size: 400% 400%;
      animation: gradient 5s linear infinite;
      transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
  }

  @keyframes gradient {
  	0% {
  		background-position: 0% 50%;
  	}
  	50% {
  		background-position: 100% 30%;
  	}
  	100% {
  		background-position: 0% 50%;
  	}
  }

  @keyframes gradient_f {
  	0% {
  		background-position: 0% 200%;
  	}
      50% {
          background-position: 200% 0%;
      }
  	100% {
  		background-position: 400% 200%;
  	}
  }

  @keyframes gradient_f_nh {
  	0% {
  		background-position: 0% 200%;
  	}
  	100% {
  		background-position: 200% 200%;
  	}
  }

''

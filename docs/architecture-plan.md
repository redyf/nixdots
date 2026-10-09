# Plano: arquitetura multi-host / multi-arch para nixdots

## Contexto

O repo já tem uma base boa: `lib/mkHost.nix`, `lib/mkHome.nix`, `lib/discover.nix` (descobre `hosts/*` e `home/users/*`), `profiles/`, `myConfig.*` / `myHomeConfig.*`.
Mas tem bugs, código morto, valores pessoais vazando entre hosts, e o desenho ainda supõe "um host = desktop do redyf".
Objetivo: lista de tarefas para deixar o repo modular, com x86_64-linux primeiro e pronto para outras arquiteturas depois.

Decisões do usuário:
- **Flake puro.** Sem flake-parts e sem dendritic. Melhorar o `lib/` atual.
- **Home-manager standalone.** Manter `homeConfigurations`.
- **Arquiteturas futuras indefinidas.** Deixar a estrutura pronta, sem alvo novo agora.

## Arquitetura alvo (flake puro)

```
flake.nix               # inputs + outputs; só chama lib/
lib/
  default.nix           # exporta mkHost, mkHome, discover, systems, forAllSystems
  mkHost.nix            # nixosSystem; módulos de input só por host (via meta.nix)
  mkHome.nix            # homeManagerConfiguration; recebe metadados do host
  discover.nix          # hosts/* e home/users/*
hosts/<host>/
  meta.nix              # { system; username; roles = [ "laptop" ... ]; extraModules; }
  configuration.nix     # só o que é único do host
  hardware-configuration.nix, disko.nix, secrets.yaml
profiles/nixos/         # papéis: common, desktop-pc, laptop, gaming, nvidia, dev
profiles/home/          # papéis HM: common, desktop, dev, gaming
modules/                # só opções genéricas; nada de usuário, monitor ou path pessoal
home/                   # módulos HM (myHomeConfig.*)
home/users/<user>@<host>.nix   # chave HM = user@host
pkgs/<nome>/package.nix # via lib.packagesFromDirectoryRecursive
overlays/default.nix    # aplicado em mkHost e mkHome
```

Regras:
- `meta.nix` é a **única** fonte de `username`, `system` e `hostname`. Todo o resto lê de lá.
- Hosts escolhem **papéis** (profiles). Módulos não sabem qual host está rodando.
- Nada de `pkgs.system` nem `stdenv.isX`. Usar `pkgs.stdenv.hostPlatform.*`, que já emite warning no nixpkgs atual.

---

## TODO

### P0: bugs e quebras atuais
- [x] Formatar `modules/services/tlp.nix:30-35`. `nixfmt --check` falha, então o CI quebra.
- [~] **Ignorado** (decisão do usuário: não mexer em `pkgs/`). `pkgs/real-vnc-viewer.nix:19`: o código diz `stdenv.stdenv.isx86_64 {`, o certo é `fetchurl {`. Corrigir, ou apagar se o pacote não for usado.
- [x] `modules/system/cachy.nix:5` recebe `nix-cachyos-kernel` como argumento, mas ele não está em specialArgs. Trocar por `inputs.nix-cachyos-kernel`.
- [x] `home/cli/neve/default.nix:14`: `stdenv.hostPackages.system` parece typo de `stdenv.hostPlatform.system`. Confirmado: `stdenv ? hostPackages` é `false`.
- [x] O fallback `ci/font-flake-fallback` só exporta `tx02`. Os módulos HM pedem `monolisa`, `berkeley-mono` e `sf-mono` (`home/system/fonts/default.nix:15-18`, `home/desktop/stylix/default.nix:34`). Adicionar esses três ao fallback. Hoje o CI não pega o erro porque `flake check` não avalia `homeConfigurations`.
- [x] Overlays nunca são aplicados: `flake.nix:86` não passa `overlays`, e `overlays/bun.nix` e `overlays/opencode.nix` estão órfãos. **Apagados.**
- [ ] **Pendente:** a mudança está só no checkout principal (não commitada), fora da worktree. O diff em andamento mudou o teclado do Hyprland HM para br/abnt2. Isso afeta os dois users, mas `modules/desktop/xserver.nix:26-27` ainda usa us/intl. Mover o layout para o host ou para o user.

### P1: limpeza e docs
- [~] **Ignorado** (decisão do usuário). Apagar os pacotes mortos em `pkgs/`: apidog, artixlauncher, omasnap, real-vnc-viewer, research. Só `cymbal` é usado.
- [x] Remover inputs sem uso: `sf-mono-liga-src`. Avaliar também:
  - **Removido:** `claude-code`: o pacote vem do `llm-agents`.
  - **Mantido** (decisão do usuário): `hyprland`: o pacote vem de `pkgs.hyprland`, então o cache `hyprland.cachix.org` não ajuda.
- [x] `follows` adicionado em `serpantinum` e `hytale-launcher`. `llm-agents` fica **sem** follows: o README dele avisa que só testa contra o próprio pin e o cache `cache.numtide.com` só funciona assim.
- [ ] **Pendente:** arquivo só existe no checkout principal (não rastreado). Apagar `flake.lock.backup`, ou adicionar no `.gitignore`.
- [x] `CLAUDE.md` novo só importa `@AGENTS.md`. O `CLAUDE.md` antigo (não rastreado) no checkout principal precisa ser apagado antes do merge.
- [x] Corrigir o README: tirar `rpi-example` (seção RPi inteira, já marcada como quebrada) e `--recurse-submodules` (`:180`).
- [x] Corrigir as descrições copiadas de "Enable displayManager" em `modules/services/default.nix:7,13,16,19`.
- [x] Remover o argumento `inputs` não usado de `gamescope.nix`, `nvidia.nix` e `environment.nix`.
- [x] `amd_pstate=active` está em dois lugares: `hosts/selene/configuration.nix:64` e `modules/system/amd.nix:14`. Deixar só no módulo.

### P2: fonte única de identidade
- [x] Hosts escrevem o username na mão: `hosts/desktop/configuration.nix:33,36` e `hosts/selene/configuration.nix:19`. Usar `username` vindo do `meta.nix`, como o host `example` já faz.
- [x] Fazer `myConfig.users.username` default para o specialArg `username`. Unificar `modules/system/sops.nix:10` e `modules/nix/nix.nix:34` para lerem a mesma fonte.
- [x] `home.username`, `homeDirectory` e `stateVersion` aparecem 3 vezes (mkHome default, módulo do mkHome, user file). Deixar só no `mkHome`.
- [x] `allowUnfree` e `permittedInsecurePackages` agora vivem só em `lib/nixpkgs-config.nix`, usado pelo `mkHost` e pelo `mkHome` (como opção `nixpkgs.config` do módulo).
- [x] Corrigido o diagnóstico: o HM standalone **sempre** reimporta nixpkgs a partir das opções `nixpkgs.*` (o `pkgs` passado só fornece `pkgs.path`). Então o `mkHome` agora passa `nixpkgs.legacyPackages` e define `nixpkgs.config`/`overlays` como opção. Resultado verificado: os 6 `.drv` (3 hosts + 3 users) ficaram idênticos.

### P3: papéis (profiles) e separação desktop × laptop
- [x] `base.nix` virou os papéis `common`, `workstation`, `gaming`, `dev` e `laptop` (mais o `minimal` já existente). Não criei `desktop-pc` nem `nvidia`: o que era do desktop é do monitor, então foi para o host; NVIDIA continua no host.
- [x] `meta.nix` ganha `roles = [ ... ]`. O `mkHost` importa `modules/` e `profiles/nixos/<role>.nix` para cada role.
- [x] Selene: o usuário decidiu **manter** Hyprland + Sway, Steam, Docker e GRUB. Saíram só o autorandr e o xrandr do DP-0, que agora ficam em `hosts/desktop` (opção nova `myConfig.desktop.xserver.displaySetup`). O conflito 165 Hz × 180 Hz continua, anotado no host.
- [ ] Coisas a parametrizar, sem hardcode:
  - [ ] Monitores do Hyprland: `home/desktop/hyprland/monitors.nix:6-12` (DP-3, HDMI-A-3). Depende do P5 (HM saber o host).
  - [x] Wallpaper agora usa `home.homeDirectory`.
  - [ ] Portal padrão Hyprland (`modules/system/xdg-portal.nix:18`).
  - [x] `XDG_SESSION_TYPE=wayland` global removido (o display manager define por sessão).
- [x] Navegador padrão = **Brave** (decisão do usuário): `DEFAULT_BROWSER = lib.getExe pkgs.brave` e MIME `brave-browser.desktop`. Obs.: só o desktop liga `mime-types`.
- [x] `modules/system/power-management.nix:17` escreve no caminho `intel_pstate`. Proteger com `myConfig.system.intel.enable`.
- [ ] **Adiado** (decisão do usuário: depois do P4/P5). Dupla checagem `categoria.enable && leaf.enable`: ligar só o leaf não faz nada. Escolher: só leaf, ou categoria liga os leafs via `mkDefault`. Recomendo **só leaf**: categoria vira `mkDefault` dos filhos.
- [x] `xboxusers` e `gamemode` agora dependem de `myConfig.gaming.enable`. (Reorganizar `groups.nix` × `users/default.nix` ainda pendente, é cosmético.)
- [ ] Renomear para não confundir `myConfig.hardware.nvidia` com `myConfig.system.hardware`.

### P4: módulos de input só onde são usados
- [ ] `lib/mkHost.nix:28-32` importa hyprland, stylix, sops-nix, nvibrant e serpantinum em todo host. Deixar só stylix e sops como base. Mover o resto para `meta.nix` (`extraModules`) ou para o papel que usa:
  - nvibrant → `nvidia.nix`.
  - serpantinum → desktop.
  - hyprland → `hyprland.nix`.
- [ ] Disko: o `mkHost` nunca passa `device`, mas os dois `disko.nix` usam `device ? throw`. Ler `device` do `meta.nix`. Padronizar a estratégia: hoje o desktop usa `enableConfig = false`.
- [ ] `hosts/desktop/disko.nix:26-30` tem partição BIOS (EF02) e ESP juntas, com GRUB EFI e `device = "nodev"`. Revisar antes de reinstalar.
- [ ] `hosts/selene/hardware-configuration.nix` parece gerado numa VM: tem virtio, `kvm-intel` em CPU AMD, e não tem `not-detected.nix`. Regerar com `nixos-generate-config` no notebook real.

### P5: home-manager standalone por host
- [ ] Mudar as chaves para `homeConfigurations."<user>@<host>"`, que o home-manager e o nh tentam primeiro. Preciso confirmar que o `nh home switch` faz esse lookup. Assim o mesmo user pode ter configs diferentes por máquina.
- [ ] `discover.nix`: gerar uma config HM por host, usando `username` e `system` do `hosts/<h>/meta.nix`. Passar `hostname`, `system` e `roles` em `extraSpecialArgs`, para os módulos HM saberem onde rodam sem `osConfig`.
- [ ] `selene.nix` e `redyf.nix` são cerca de 90% iguais. Criar `profiles/home/common.nix` (e `desktop.nix`, `dev.nix`). O user file fica só com a diferença.
- [ ] Hoje `selene.nix` liga o Hyprland no HM, mas o host usa Sway com `sway.enable = false` no HM. Alinhar com o host.
- [ ] `home/cli/tools/git/default.nix:42,46` lê `/run/secrets/rendered/*`, que só existe em host NixOS com sops. Proteger com uma opção, ou usar o módulo sops-nix do HM (`sops-nix.homeManagerModules.sops`).

### P6: pronto para multi-arch
- [ ] `lib/default.nix`: exportar `systems` (lista) e `forAllSystems`. Começar só com `x86_64-linux`, e adicionar `aarch64-linux` quando houver host.
- [ ] Procurar e trocar `pkgs.system`, `stdenv.isLinux`, `stdenv.isx86_64` etc. por `pkgs.stdenv.hostPlatform.*`.
- [ ] `modules/services/displayManager.nix:15` checa `isx86_64`, então em aarch64 o display manager fica desligado sem aviso. Remover a checagem, ou usar `assert`/`warnings`.
- [ ] `overlays/bun.nix:6` tem `linux-x64` fixo. Derivar da plataforma.
- [ ] Quando houver host ARM: `boot.binfmt.emulatedSystems = [ "aarch64-linux" ]` no desktop para builds ocasionais, e `nixos-rebuild --target-host` para deploy. deploy-rs ou colmena só se passar de ~3 hosts remotos.
- [ ] Darwin: deixar para quando houver um Mac. Seria um `lib/mkDarwin.nix` paralelo ao `mkHost`. O HM standalone continua funcionando lá.

### P7: pacotes e overlays como outputs
- [ ] Reorganizar para `pkgs/<nome>/package.nix`. Expor `packages = forAllSystems (s: lib.packagesFromDirectoryRecursive { callPackage = pkgs.callPackage; directory = ./pkgs; })`.
- [ ] `overlays.default = final: prev: { ...pacotes locais... }`. Aplicar via `lib` em mkHost e mkHome.
- [ ] Trocar `callPackage ../../../../pkgs/cymbal.nix` (`home/cli/tools/cymbal/default.nix:13`) por `pkgs.cymbal`.

### P8: secrets
- [ ] `.sops.yaml`: hoje tem uma chave só. Separar em uma chave admin (a sua age key) e uma chave por host (a host key SSH convertida via `ssh-to-age`). Criar uma regra por host, por exemplo `hosts/selene/secrets.yaml`, com admin + host.
- [ ] Ligar sops no selene e usar `hashedPasswordFile`. Hoje ele não tem senha (`hosts/selene/configuration.nix:22`).
- [ ] `modules/system/sops.nix:11` monta o path `hosts/<hostname>/secrets.yaml`. Ele quebra se o arquivo não existir; documentar isso ou proteger.

### P9: CI e qualidade
- [ ] O CI deve buildar `nixosConfigurations.<h>.config.system.build.toplevel` e `homeConfigurations.<u@h>.activationPackage`. Hoje só roda `flake check`. Para isso:
  - Adicionar `checks.x86_64-linux` com esses dois por host/user, gerados pelo `lib`, para não manter lista na mão.
  - Ou usar `nix-fast-build`.
- [ ] Usar treefmt-nix (nixfmt + deadnix + statix) como `formatter`. Opcional: git-hooks.nix para pre-commit.
- [ ] Trocar o action `DeterminateSystems/magic-nix-cache-action@v7`. Ele usa uma API não oficial e pode quebrar. Alternativas: `nix-community/cache-nix-action` ou Cachix.
- [ ] Atualizar o `nix-installer-action@v13`, que é uma versão antiga. Não verifiquei qual é a atual.
- [ ] `nix.registry` e `nixPath` já vêm automáticos para nixpkgs via `nixosSystem`. Opcional: registrar os outros inputs com `nix.registry = lib.mapAttrs (_: f: { flake = f; }) inputs`.

### P10: opcional
- [ ] Reduzir `with pkgs;` (44 usos). É estilo; a comunidade prefere listas explícitas.
- [ ] A categoria `myHomeConfig.*` só repassa para opções top-level (`fonts.enable`, `git.enable`…). `fonts.enable` colide com o namespace `fonts` do HM. Mover tudo para dentro de `myHomeConfig.*`.

---

## Fluxo de execução (pedido do usuário)
1. Criar uma worktree nova a partir de `main` (EnterWorktree), branch `refactor/multi-host-arch`. Nada de código é alterado no checkout principal.
   - Atenção: as mudanças não commitadas em `main` (flake.lock, teclado do hyprland, gaming do selene, secrets.yaml) **não** vão para a worktree. Commitar antes, ou deixar fora.
2. Primeiro commit na worktree: salvar este plano em `docs/architecture-plan.md`.
3. Implementar fase por fase (ordem abaixo). Um commit por item ou grupo pequeno. Rodar a verificação a cada fase.
4. Antes de cada fase grande (P2–P5), mostrar ao usuário o que vai mudar e esperar o ok.

## Ordem sugerida
1. P0 → P1 (rápido, sem mudar arquitetura).
2. P2 → P4 (refactor de identidade e papéis; desktop e selene param de vazar config).
3. P5 (HM `user@host`).
4. P7 → P9 (outputs, secrets, CI).
5. P6 só quando aparecer um host novo.

Um commit por item ou grupo pequeno. Depois de cada passo, rodar a verificação abaixo.

## Verificação
- `nix fmt` (ou `nixfmt --check`) + `nix develop -c statix check --config ./.statix.toml .`
- `nix flake check --show-trace`
- `nix build .#nixosConfigurations.{desktop,selene,example}.config.system.build.toplevel --dry-run`
- `nix build .#homeConfigurations."selene@selene".activationPackage --dry-run` (e os outros users)
- Comparar antes e depois: `nix store diff-closures` (ou `nvd diff`) do toplevel atual × novo. Isso confirma que um refactor não mudou nada sem querer.
- `nh os switch` + `nh home switch` no selene. Testar o desktop depois.

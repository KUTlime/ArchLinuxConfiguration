  FÁZE 1: Příprava systému (dělejte v terminálu)

  Tuto část udělejte hned. Cílem je nainstalovat nástroje a nastavit oprávnění.

   1. Nainstalujte potřebné balíčky:
   1     yay -S kdotool ydotool libsecret

   2. Přidejte se do skupiny `input`:
      Tím získáte právo ovládat virtuální klávesnici.
   1     sudo usermod -aG input $USER

   3. Nastavte pravidlo pro hardware (udev):
      Tím řeknete systému, že skupina input smí zapisovat do zařízení /dev/uinput. Zkopírujte celý řádek:
   1     echo 'KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/80-uinput.rules

   4. Aplikujte změny:
   1     sudo udevadm control --reload-rules && sudo udevadm trigger

  🛑 STOP! Nyní musíte RESTARTOVAT POČÍTAČ.
  Bez restartu (nebo úplného odhlášení) se změna skupiny neprojeví a nic nebude fungovat.
  Restartujte nyní a poté se vraťte k bodu FÁZE 2.

  ---

  FÁZE 2: Nastavení služby (po restartu)

  Nyní, když máte práva, nastavíme ydotool tak, aby běžel automaticky na pozadí.

   1. Vytvořte službu pro systemd:
      Otevřete editor (vytvoří se nový soubor):
   1     mkdir -p ~/.config/systemd/user/
   2     nano ~/.config/systemd/user/ydotoold.service
      Vložte do něj tento text:
   1     [Unit]
   2     Description=ydotool daemon
   3
   4     [Service]
   5     ExecStart=/usr/bin/ydotoold --socket-path=%h/.ydotool_socket --socket-own=%U:%G
   6     Restart=always
   7
   8     [Install]
   9     WantedBy=default.target
      Uložte (Ctrl+O, Enter) a zavřete (Ctrl+X).

   2. Zapněte službu:
   1     systemctl --user daemon-reload
   2     systemctl --user enable --now ydotoold

   3. Ověřte funkčnost:
      Tento příkaz by měl napsat text do terminálu bez ptání na heslo.
   1     YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool type "funguje to"
      Pokud se text vypsal, pokračujte. Pokud ne, napište mi chybu.

  ---

  FÁZE 3: Vytvoření skriptu

  Teď, když infrastruktura funguje, vytvoříme finální skript.

   1. Uložte heslo do klíčenky:
      (Zadejte své hlavní heslo k Enpassu, až budete vyzváni).
   1     secret-tool store --label="Enpass Unlock" app enpass

   2. Vytvořte skript `unlock_enpass.sh`:
   1     nano ~/unlock_enpass.sh
      Vložte do něj toto:

    1     #!/bin/bash
    2
    3     # 1. Nastavení cesty k socketu (aby ydotool věděl, kam posílat příkazy)
    4     export YDOTOOL_SOCKET="$HOME/.ydotool_socket"
    5
    6     # 2. Spustit Enpass, pokud neběží
    7     if ! pgrep -x "enpass" > /dev/null; then
    8         enpass &
    9         sleep 3  # Čekáme na start
   10     fi
   11
   12     # 3. Najít okno Enpassu (pomocí kdotool)
   13     WID=$(kdotool search --name "Enpass" | head -n 1)
   14
   15     if [ -z "$WID" ]; then
   16         # Zkusit vyvolat z traye
   17         enpass &
   18         sleep 1
   19         WID=$(kdotool search --name "Enpass" | head -n 1)
   20     fi
   21
   22     if [ -n "$WID" ]; then
   23         # 4. Aktivovat okno
   24         kdotool windowactivate "$WID"
   25         sleep 0.5
   26
   27         # 5. Získat heslo a napsat ho
   28         PASS=$(secret-tool lookup app enpass)
   29         if [ -n "$PASS" ]; then
   30             ydotool type "$PASS"
   31             ydotool key 28:1 28:0  # Stisk Enteru
   32         fi
   33     else
   34         notify-send "Chyba" "Okno Enpass nenalezeno"
   35     fi

   3. Nastavte práva ke spuštění:
   1     chmod +x ~/unlock_enpass.sh

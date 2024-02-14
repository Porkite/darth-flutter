## Przygotowanie środowiska
### Instalacja fluttera
Polecam: https://docs.flutter.dev/get-started/install/linux
Polecam drugą metodę, czyli instalację manualną. Przy snapd miałem problemy z uruchomieniem aplikacji z poziomu IDE.

### Instalacja Android Studio
Polecam: https://developer.android.com/studio/install#linux
Będzie potrzebne, aby odpalić sobie lokalnie emulator i apkę na nim.

### Instalacja wtyczki do IntelliJ IDEA
Potrzebujemy wtyczkę do IntelliJ IDEA, aby móc uruchamiać aplikację na emulatorze, telefonie, przeglądarce.
Wchodzimy do IntelliJ IDEA -> File -> Settings -> Plugins -> Wyszukujemy "Flutter" -> Install
Wchodzimy do IntelliJ IDEA -> File -> Settings -> Plugins -> Wyszukujemy "Dart" -> Install (pewnie zadzieje się automatycznie przy flutter)
Wchodzimy do IntelliJ IDEA -> File -> Settings -> Plugins -> Wyszukujemy "Android" -> Install


## Uruchamianie z poziomu IntelliJ IDEA
### Build natywny na linuxa
Wybieramy z dropdowna Linux (desktop) i klikamy na ikonę "Run" w prawym górnym rogu.
Powinna odpalić się aplikacją w nowym oknie.

### Build na przeglądarkę
Wybieramy z dropdowna Chrome (web) i klikamy na ikonę "Run" w prawym górnym rogu.
Powinna odpalić przeglądarkę z aplikacją na adresie http://localhost:44121/

### Build na androida
Wybieramy z prawej strony okno "Device Manager" i dodajemy nowy emulator.
Jeżeli będą z tym problemy, to polecam odpalić i stworzyć nowe urządzenie z poziomu Android Studio.
Z listy gdzie wcześniej wybieraliśmy linux lub chrome, wybieramy teraz "Open Android Emulator: <nazwa urządzenia>" i klikamy na ikonę "Run" w prawym górnym rogu.
Powinna odpalić się aplikacją na emulatorze (w zakładce "Running Devices" powinno pojawić się nowe okno z aplikacją).



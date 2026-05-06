# Datenschutzrichtlinie für EnergyPriceInfo

*Stand: 6. Mai 2026*

Diese Datenschutzrichtlinie beschreibt, welche Daten die App **EnergyPriceInfo** (im Folgenden
„die App") verarbeitet, wie sie verarbeitet werden und welche Rechte Sie als Nutzer:in
haben.

## 1. Verantwortlicher im Sinne der DSGVO

Verantwortlich für die Verarbeitung personenbezogener Daten im Zusammenhang mit der App ist:

> **Stephan Schindewolf**
> Hasensprung 1
> 76228 Karlsruhe
> Deutschland
>
> E-Mail: schiwo1@gmail.com

## 2. Grundsatz: Keine Datenerhebung durch den Anbieter

EnergyPriceInfo ist eine reine Client-App, die ausschließlich auf Ihrer Apple Watch und in
der zugehörigen Komplikations-Erweiterung läuft. **Es gibt keine vom Anbieter
betriebenen Server, keine Analytics, kein Tracking und keine Werbung.** Es werden weder
personenbezogene Daten noch Nutzungsdaten an den Anbieter oder an Dritte übermittelt.

## 3. Datenverarbeitung auf dem Gerät

Damit die App ihre Funktion erfüllen kann (Anzeige der von Ihnen über Tibber bezogenen
Strompreise pro kWh), werden folgende Daten **lokal auf Ihrer Apple Watch** gespeichert:

| Datum | Zweck | Speicherort | Übermittlung |
|-------|-------|-------------|--------------|
| Tibber Personal Access Token | Authentifizierung gegenüber der Tibber-API | `UserDefaults` der App auf Ihrer Apple Watch | nein |
| Zwischengespeicherte Strompreisdaten (96 Viertelstunden-Slots heute / morgen) | Anzeige des Charts und der Komplikation, auch wenn die Watch kurz offline ist | App-Group `UserDefaults` auf Ihrer Apple Watch | nein |
| Anzeigeeinstellung „Heute / Morgen" | Wiederherstellung der zuletzt gewählten Ansicht | `UserDefaults` der App | nein |

Die Daten verlassen Ihre Apple Watch nicht, mit Ausnahme der unter Ziffer 4 beschriebenen
direkten Verbindung zu Tibber.

## 4. Direkte Kommunikation mit der Tibber-API

Zum Abruf der Strompreisdaten stellt die App **ausschließlich verschlüsselte HTTPS-
Verbindungen** zu folgendem Endpunkt her:

- `POST https://api.tibber.com/v1-beta/gql`

Die Anfrage trägt Ihren Tibber Personal Access Token im `Authorization`-Header und
fragt per GraphQL die viertelstündlichen Preisdaten Ihres bei Tibber registrierten
Anschlusses ab. Die Antwort enthält ausschließlich Strompreisdaten und Metadaten
(Währung, Preis-Level). Der Anbieter der App erhält von dieser Kommunikation nichts; sie
findet direkt zwischen Ihrer Apple Watch und Tibber statt.

Die Datenverarbeitung durch Tibber (als datenschutzrechtlich Verantwortlicher der eigenen
API) richtet sich nach den Datenschutzbestimmungen von Tibber:
<https://tibber.com/de/datenschutz>

## 5. Drittanbieter

Die App nutzt **keine** Drittanbieter-SDKs, keine Werbe- oder Tracking-Dienste, keine
Crash-Reporting-Dienste und keine externen Analyse-Tools.

Die App kommuniziert ausschließlich mit:

1. **Der Tibber-API** unter `https://api.tibber.com/v1-beta/gql`, sofern Sie dort einen
   Account besitzen und einen Personal Access Token in der App hinterlegen.
2. **Apple-Diensten**, die für den Betrieb von watchOS-Apps systembedingt erforderlich
   sind (z. B. WidgetKit, App-Group-`UserDefaults`). Für die Datenverarbeitung durch
   Apple gelten die Datenschutzbestimmungen von Apple Inc.

## 6. Rechtsgrundlage der Verarbeitung (Art. 6 DSGVO)

Soweit auf dem Gerät personenbezogene Daten (insb. Ihr Tibber-Token) verarbeitet werden,
geschieht dies auf Grundlage von Art. 6 Abs. 1 lit. b DSGVO (Erfüllung der Funktion, die
Sie mit der Installation der App nachgefragt haben) sowie Art. 6 Abs. 1 lit. f DSGVO
(berechtigtes Interesse an einem funktionierenden Produkt).

## 7. Speicherdauer

- Der Tibber-Token wird gespeichert, bis Sie ihn in der App ändern, über die Schaltfläche
  „Change Token" zurücksetzen oder die App von Ihrer Apple Watch deinstallieren.
- Zwischengespeicherte Preisdaten werden bei jedem erfolgreichen Abruf überschrieben und
  beim Deinstallieren der App vollständig entfernt.

## 8. Demo-Modus

Die App bietet einen Demo-Modus (Token = `demo`), in dem fest hinterlegte Beispieldaten
verwendet werden. Im Demo-Modus erfolgt **keinerlei Netzwerkkommunikation**.

## 9. Ihre Rechte

Da der Anbieter der App **keine Daten von Ihnen erhebt oder speichert**, gibt es seitens
des Anbieters auch keine personenbezogenen Daten, auf die sich die folgenden Rechte
beziehen könnten. Vollständigkeitshalber: Nach DSGVO stehen Ihnen grundsätzlich die
folgenden Rechte zu — Auskunft (Art. 15), Berichtigung (Art. 16), Löschung (Art. 17),
Einschränkung der Verarbeitung (Art. 18), Datenübertragbarkeit (Art. 20), Widerspruch
(Art. 21) sowie Beschwerde bei einer Aufsichtsbehörde (Art. 77).

Alle lokal auf Ihrer Apple Watch gespeicherten Daten können Sie jederzeit löschen, indem
Sie die App deinstallieren oder den Token über „Change Token" zurücksetzen.

## 10. Sicherheit

- Der Tibber Personal Access Token wird in den geräteeigenen `UserDefaults` (App-Sandbox)
  gespeichert und ist nicht für andere Apps zugänglich.
- Verbindungen zur Tibber-API erfolgen ausschließlich über HTTPS (TLS).
- Die Kommunikation zwischen der Watch-App und der Komplikations-Erweiterung erfolgt
  ausschließlich über das von Apple bereitgestellte App-Group-`UserDefaults` und
  verlässt das Gerät nicht.

## 11. Hinweis zu Markenrechten

TibberWatch ist ein unabhängiges Drittprodukt. Es steht in keiner geschäftlichen oder
personellen Verbindung zu **Tibber AS** und wird von Tibber weder unterstützt noch
gesponsert. „Tibber" ist eine Marke von Tibber AS; der Name wird hier nur zur
Beschreibung der Daten verwendet, die die App über die offizielle Tibber-API ausliest.

## 12. Änderungen dieser Datenschutzrichtlinie

Diese Datenschutzrichtlinie kann angepasst werden, wenn dies durch geänderte Funktionen
der App oder durch geänderte Rechtslage erforderlich wird. Die jeweils aktuelle Fassung
wird unter der URL veröffentlicht, die Sie im App Store als Datenschutzrichtlinie der
App finden.

## 13. Kontakt

Bei Fragen zu dieser Datenschutzrichtlinie wenden Sie sich bitte an die unter Ziffer 1
genannte Kontaktadresse.

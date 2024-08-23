-- Initialisierung und Optionen für rich.readthedocs.io
-- Beispieloptionen für rich.readthedocs.io
-- Die tatsächliche Bedeutung und Anwendung hängt vom srich.readthedocs.io ab
-- "-- init.lua" könnte darauf hindeuten, dass diese Datei eine Initialisierungsdatei ist
-- Optionen wie -j, --left, --line-numbers usw. spezifizieren Konfigurationsparameter
-- Rich-Formatierung
-- Konfiguriert das `rich`-Tool mit verschiedenen Anzeigeoptionen
local rich_options = {
    "--text-left",
    "--theme", "nord-darker",
    "--panel", "rounded",
    "--expand",
    "--line-numbers",
    "--emoji",
    "--inspect",
    "--csv",
    "--markdown",
    "--json",
    "--rst"
}

-- Plugin-Konfiguration
-- Erfordert das `omp`-Plugin und konfiguriert es
require("omp"):setup()

-- Erfordert das `full-border`-Plugin und konfiguriert es mit abgerundeten Ecken
require("full-border"):setup {
    type = ui.Border.ROUNDED,  -- Setzt die Randart für das Plugin auf abgerundet
}


-- Linemodes-Funktion
-- Gibt Dateiinformationen im Format s-[size] c-[creation] m-[modification] zurück
function Linemode:all()
    local year = os.date("%Y")
    local ctime = (self._file.cha.created or 0) // 1
    local mtime = (self._file.cha.modified or 0) // 1
    local size = self._file:size()

    -- Format creation time
    if ctime > 0 and os.date("%Y", ctime) == year then
        ctime = os.date("%d/%m/%Y|%H:%M:%S", ctime)
    else
        ctime = ctime and os.date("%d/%m/%Y", ctime) or ""
    end

    -- Format modification time
    if mtime > 0 and os.date("%Y", mtime) == year then
        mtime = os.date("%d/%m/%Y|%H:%M:%S", mtime)
    else
        mtime = mtime and os.date("%d/%m/%Y", mtime) or ""
    end

    -- Format size in a readable format
    local readable_size = size and ya.readable_size(size) or "-"

    return ui.Line(string.format(" s-%s c-%s m-%s ", readable_size, ctime, mtime))
end
-- ~/.config/yazi/init.lua
-- plugins:
require("omp"):setup()
require("full-border"):setup {
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
}

-- Linemodes:

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

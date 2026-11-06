-- Système de traduction Wind Studio
-- La langue suit la convar "esx:locale" du server.cfg (ex : setr esx:locale "en")
-- Pour ajouter une langue : copiez locales/fr.lua en locales/xx.lua et traduisez les textes.

Locales = {}

function _T(key, ...)
    local lang = GetConvar('esx:locale', 'fr')
    local text = (Locales[lang] and Locales[lang][key])
        or (Locales['fr'] and Locales['fr'][key])
        or (Locales['en'] and Locales['en'][key])
        or key
    if select('#', ...) > 0 then
        return text:format(...)
    end
    return text
end

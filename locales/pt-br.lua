local Translations = {
error = {
    you_are_already_goldpanning = 'você já está garimpando ouro!',
    you_are_mounted = 'você não pode fazer isso enquanto estiver montado!',
},
success = {
    var = 'o texto vai aqui',
},
primary = {
    you_need_the_river_to_goldpan = 'você precisa estar perto do rio para garimpar ouro',
    not_much_this_pan = 'não tem muito neste recipiente',
    looks_like_good_gold = 'parece que há ouro de qualidade',
    gold_fever_jackpot = 'jackpot da febre do ouro...',
    no_gold_this_time = 'nenhum ouro desta vez...',
},
menu = {
    var = 'o texto vai aqui',
},
commands = {
    var = 'o texto vai aqui',
},
progressbar = {
    var = 'o texto vai aqui',
},

}

if GetConvar('rsg_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

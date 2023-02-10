--[[
Copyright © 2022, MrSent
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]


_addon.name = 'PartyInMyPants'
_addon.author = 'MrSent'
_addon.version = '1.0.0'
_addon.command = 'pimp'

require 'chat'
require 'tables'
require 'strings'
require 'logger'
require 'luau'
require 'pack'
require 'actions'

packets = require('packets')
res = require ('resources')

whitelist = 
{
    "Jamel",
    "Blackthorne",
    "Heavyheart",
    "Pudge",
    "Porso",
    "Morso",
    "Sentientone",
    "Lillsuzy",
    "Evilash",
    "Samurye",
    "Neorye",
    "Xephyr",
    "Porshe",
    "Tulika",
    "Shenzi",
    "Perusalenne",
    "Rukachan",
    "Padrobond",
    "Cevion",
    "Shakes",
    "Cimme",
    "Taroto",
    "Rulk",
}

windower.register_event('chat message', function(message, sender, mode, gm)
    local msg = string.lower(message)
    local player = windower.ffxi.get_player()
    local name = string.lower(tostring(player.name))
    local target = nil

    if mode == 4 then 
        if string.find(msg, name) and string.find(msg,"pimp") then
            if sender ~= nil then
                target = sender
            end

            if string.find(msg, 'add me to ballad') then
                windower.send_command("input //sing ballad "..sender)
                sendPartyChat("Adding "..sender.. " to ballad list.")
            elseif string.find(msg, 'add me to refresh') then
                windower.send_command("input //sing refresh "..sender)
                sendPartyChat("Adding "..sender.. " to refresh list.")
            elseif string.find(msg, 'add me to haste') then
                windower.send_command("input //sing haste "..sender)
                sendPartyChat("Adding "..sender.. " to haste list.")
            elseif string.find(msg, 'reload singer') then
                windower.send_command("input //lua u singer; wait 1;  input //lua l singer")
                sendPartyChat("ATTENTION!, "..sender.." asked me to reload singer, please wait until songs start again.")
            elseif string.find(msg, 'toggle singer') then
                windower.send_command("input //singer")
                sendPartyChat("ATTENTION!, "..sender.." asked me to toggle singer.")
            elseif string.find(msg, 'restart singer') then
                windower.send_command("input //sing reset")
                sendPartyChat("ATTENTION!, "..sender.." asked me to restart singer, please wait until songs start again.")
            elseif string.find(msg, 'refa trust') then
                windower.send_command("input /refa all")
                sendPartyChat("ATTENTION!, "..sender.." asked me to get rid of all the trust.")
            elseif string.find(msg, 'call trust') then
                check_Trust(msg)
            elseif string.find(msg, 'test') then -- Debug test
                sendPartyChat("Test is working")
            end
        end
    elseif mode == 3 then
        if string.find(msg, "invite me plz") then
            for k,v in ipairs(whitelist) do
                if sender == whitelist[k] then
                    windower.send_command("input /pcmd add "..sender)
                    log(sender.." is on your whitelist, Inviting "..sender.. " to the party.") 
                end
            end
        elseif string.find(msg, "accept the invite") then
            for k,v in ipairs(whitelist) do
                if sender == whitelist[k] then
                    windower.send_command("input /join")
                    log(sender.." is on your whitelist, joining "..sender.. "'s' party.") 
                end
            end
        elseif string.find(msg, "kick") then
            for k,v in ipairs(whitelist) do
                if sender == whitelist[k] then
                    windower.send_command("input /pcmd" ..msg)
                end
            end
        end
    end
end)

function sendPartyChat(msg)
    windower.send_command("input /p " ..msg)
end

function check_Trust(msg)
    for i,value in ipairs(trusts) do
        if string.find(string.lower(msg), string.lower(trusts[i].english)) then
            windower.send_command("input /ma "..trusts[i].english.." <me>")
        end
    end
end

trusts = 
{
    [1]={id=896,japanese="シャントット",english="Shantotto",name="Shantotto",models=3000},
    [2]={id=897,japanese="ナジ",english="Naji",name="Naji",models=3001},
    [3]={id=898,japanese="クピピ",english="Kupipi",name="Kupipi",models=3002},
    [4]={id=899,japanese="エグセニミル",english="Excenmille",name="Excenmille",models=3003},
    [5]={id=900,japanese="アヤメ",english="Ayame",name="Ayame",models=3004},
    [6]={id=901,japanese="ナナー・ミーゴ",english="Nanaa Mihgo",name="NanaaMihgo",models=3005},
    [7]={id=902,japanese="クリルラ",english="Curilla",name="Curilla",models=3006},
    [8]={id=903,japanese="フォルカー",english="Volker",name="Volker",models=3007},
    [9]={id=904,japanese="アジドマルジド",english="Ajido-Marujido",name="Ajido-Marujido",models=3008},
    [10]={id=905,japanese="トリオン",english="Trion",name="Trion",models=3009},
    [11]={id=906,japanese="ザイド",english="Zeid",name="Zeid",models=3010},
    [12]={id=907,japanese="ライオン",english="Lion",name="Lion",models=3011},
    [13]={id=908,japanese="テンゼン",english="Tenzen",name="Tenzen",models=3012},
    [14]={id=909,japanese="ミリ・アリアポー",english="Mihli Aliapoh",name="MihliAliapoh",models=3013},
    [15]={id=910,japanese="ヴァレンラール",english="Valaineral",name="Valaineral",models=3014},
    [16]={id=911,japanese="ヨアヒム",english="Joachim",name="Joachim",models=3015},
    [17]={id=912,japanese="ナジャ・サラヒム",english="Naja Salaheem",name="NajaSalaheem",models=3016},
    [18]={id=913,japanese="プリッシュ",english="Prishe",name="Prishe",models=3017},
    [19]={id=914,japanese="ウルミア",english="Ulmia",name="Ulmia",models=3018},
    [20]={id=915,japanese="スカリーZ",english="Shikaree Z",name="ShikareeZ",models=3019},
    [21]={id=916,japanese="チェルキキ",english="Cherukiki",name="Cherukiki",models=3020},
    [22]={id=917,japanese="アイアンイーター",english="Iron Eater",name="IronEater",models=3021},
    [23]={id=918,japanese="ゲッショー",english="Gessho",name="Gessho",models=3022},
    [24]={id=919,japanese="ガダラル",english="Gadalar",name="Gadalar",models=3023},
    [25]={id=920,japanese="ライニマード",english="Rainemard",name="Rainemard",models=3024},
    [26]={id=921,japanese="イングリッド",english="Ingrid",name="Ingrid",models=3025},
    [27]={id=922,japanese="レコ・ハボッカ",english="Lehko Habhoka",name="LehkoHabhoka",models=3026},
    [28]={id=923,japanese="ナシュメラ",english="Nashmeira",name="Nashmeira",models=3027},
    [29]={id=924,japanese="ザザーグ",english="Zazarg",name="Zazarg",models=3028},
    [30]={id=925,japanese="アヴゼン",english="Ovjang",name="Ovjang",models=3029},
    [31]={id=926,japanese="メネジン",english="Mnejing",name="Mnejing",models=3030},
    [32]={id=927,japanese="サクラ",english="Sakura",name="Sakura",models=3031},
    [33]={id=928,japanese="ルザフ",english="Luzaf",name="Luzaf",models=3032},
    [34]={id=929,japanese="ナジュリス",english="Najelith",name="Najelith",models=3033},
    [35]={id=930,japanese="アルド",english="Aldo",name="Aldo",models=3034},
    [36]={id=931,japanese="モーグリ",english="Moogle",name="Moogle",models=3035},
    [37]={id=932,japanese="ファブリニクス",english="Fablinix",name="Fablinix",models=3036},
    [38]={id=933,japanese="マート",english="Maat",name="Maat",models=3037},
    [39]={id=934,japanese="D.シャントット",english="D. Shantotto",name="D.Shantotto",models=3038},
    [40]={id=935,japanese="星の神子",english="Star Sibyl",name="StarSibyl",models=3039},
    [41]={id=936,japanese="カラハバルハ",english="Karaha-Baruha",name="Karaha-Baruha",models=3040},
    [42]={id=937,japanese="シド",english="Cid",name="Cid",models=3041},
    [43]={id=938,japanese="ギルガメッシュ",english="Gilgamesh",name="Gilgamesh",models=3042},
    [44]={id=939,japanese="アレヴァト",english="Areuhat",name="Areuhat",models=3043},
    [45]={id=940,japanese="セミ・ラフィーナ",english="Semih Lafihna",name="SemihLafihna",models=3044},
    [46]={id=941,japanese="エリヴィラ",english="Elivira",name="Elivira",models=3045},
    [47]={id=942,japanese="ノユリ",english="Noillurie",name="Noillurie",models=3046},
    [48]={id=943,japanese="ルー・マカラッカ",english="Lhu Mhakaracca",name="LhuMhakaracca",models=3047},
    [49]={id=944,japanese="フェリアスコフィン",english="Ferreous Coffin",name="FerreousCoffin",models=3048},
    [50]={id=945,japanese="リリゼット",english="Lilisette",name="Lilisette",models=3049},
    [51]={id=946,japanese="ミュモル",english="Mumor",name="Mumor",models=3050},
    [52]={id=947,japanese="ウカ・トトゥリン",english="Uka Totlihn",name="UkaTotlihn",models=3051},
    [53]={id=948,japanese="クララ",english="Klara",name="Klara",models=3053},
    [54]={id=949,japanese="ロマー・ミーゴ",english="Romaa Mihgo",name="RomaaMihgo",models=3054},
    [55]={id=950,japanese="クイン・ハスデンナ",english="Kuyin Hathdenna",name="KuyinHathdenna",models=3055},
    [56]={id=951,japanese="ラーアル",english="Rahal",name="Rahal",models=3056},
    [57]={id=952,japanese="コルモル",english="Koru-Moru",name="Koru-Moru",models=3057},
    [58]={id=953,japanese="ピエージェ(UC)",english="Pieuje (UC)",name="Pieuje",models=3058},
    [59]={id=954,japanese="I.シールド(UC)",english="I. Shield (UC)",name="InvincibleShld",models=3060},
    [60]={id=955,japanese="アプルル(UC)",english="Apururu (UC)",name="Apururu",models=3061},
    [61]={id=956,japanese="ジャコ(UC)",english="Jakoh (UC)",name="JakohWahcondalo",models=3062},
    [62]={id=957,japanese="フラヴィリア(UC)",english="Flaviria (UC)",name="Flaviria",models=3059},
    [63]={id=958,japanese="ウェイレア",english="Babban",name="Babban",models=3067},
    [64]={id=959,japanese="アベンツィオ",english="Abenzio",name="Abenzio",models=3068},
    [65]={id=960,japanese="ルガジーン",english="Rughadjeen",name="Rughadjeen",models=3069},
    [66]={id=961,japanese="クッキーチェブキー",english="Kukki-Chebukki",name="Kukki-Chebukki",models=3070},
    [67]={id=962,japanese="マルグレート",english="Margret",name="Margret",models=3071},
    [68]={id=963,japanese="チャチャルン",english="Chacharoon",name="Chacharoon",models=3072},
    [69]={id=964,japanese="レイ・ランガヴォ",english="Lhe Lhangavo",name="LheLhangavo",models=3073},
    [70]={id=965,japanese="アシェラ",english="Arciela",name="Arciela",models=3074},
    [71]={id=966,japanese="マヤコフ",english="Mayakov",name="Mayakov",models=3075},
    [72]={id=967,japanese="クルタダ",english="Qultada",name="Qultada",models=3076},
    [73]={id=968,japanese="アーデルハイト",english="Adelheid",name="Adelheid",models=3077},
    [74]={id=969,japanese="アムチュチュ",english="Amchuchu",name="Amchuchu",models=3078},
    [75]={id=970,japanese="ブリジッド",english="Brygid",name="Brygid",models=3079},
    [76]={id=971,japanese="ミルドリオン",english="Mildaurion",name="Mildaurion",models=3080},
    [77]={id=972,japanese="ハルヴァー",english="Halver",name="Halver",models=3087},
    [78]={id=973,japanese="ロンジェルツ",english="Rongelouts",name="Rongelouts",models=3088},
    [79]={id=974,japanese="レオノアーヌ",english="Leonoyne",name="Leonoyne",models=3089},
    [80]={id=975,japanese="マクシミリアン",english="Maximilian",name="Maximilian",models=3090},
    [81]={id=976,japanese="カイルパイル",english="Kayeel-Payeel",name="Kayeel-Payeel",models=3091},
    [82]={id=977,japanese="ロベルアクベル",english="Robel-Akbel",name="Robel-Akbel",models=3092},
    [83]={id=978,japanese="クポフリート",english="Kupofried",name="Kupofried",models=3093},
    [84]={id=979,japanese="セルテウス",english="Selh\'teus",name="Selh\'teus",models=3094},
    [85]={id=980,japanese="ヨランオラン(UC)",english="Yoran-Oran (UC)",name="Yoran-Oran",models=3095},
    [86]={id=981,japanese="シルヴィ(UC)",english="Sylvie (UC)",name="Sylvie",models=3096},
    [87]={id=982,japanese="アブクーバ",english="Abquhbah",name="Abquhbah",models=3098},
    [88]={id=983,japanese="バラモア",english="Balamor",name="Balamor",models=3099},
    [89]={id=984,japanese="オーグスト",english="August",name="August",models=3100},
    [90]={id=985,japanese="ロスレーシャ",english="Rosulatia",name="Rosulatia",models=3101},
    [91]={id=986,japanese="テオドール",english="Teodor",name="Teodor",models=3103},
    [92]={id=987,japanese="ウルゴア",english="Ullegore",name="Ullegore",models=3105},
    [93]={id=988,japanese="マッキーチェブキー",english="Makki-Chebukki",name="Makki-Chebukki",models=3106},
    [94]={id=989,japanese="キング・オブ・ハーツ",english="King of Hearts",name="KingOfHearts",models=3107},
    [95]={id=990,japanese="モリマー",english="Morimar",name="Morimar",models=3108},
    [96]={id=991,japanese="ダラクァルン",english="Darrcuiln",name="Darrcuiln",models=3109},
    [97]={id=992,japanese="アークHM",english="AAHM",name="ArkHM",models=3113},
    [98]={id=993,japanese="アークEV",english="AAEV",name="ArkEV",models=3114},
    [99]={id=994,japanese="アークMR",english="AAMR",name="ArkMR",models=3115},
    [100]={id=995,japanese="アークTT",english="AATT",name="ArkTT",models=3116},
    [101]={id=996,japanese="アークGK",english="AAGK",name="ArkGK",models=3117},
    [102]={id=997,japanese="イロハ",english="Iroha",name="Iroha",models=3111},
    [103]={id=998,japanese="ユグナス",english="Ygnas",name="Ygnas",models=3118},
    [104]={id=1004,japanese="エグセニミルII",english="Excenmille [S]",name="Excenmille",models=3052},
    [105]={id=1005,japanese="アヤメ(UC)",english="Ayame (UC)",name="Ayame",models=3063},
    [106]={id=1006,japanese="マート(UC)",english="Maat (UC)",name="Maat",models=3064}, --expected models
    [107]={id=1007,japanese="アルド(UC)",english="Aldo (UC)",name="Aldo",models=3065}, --expected models
    [108]={id=1008,japanese="ナジャ(UC)",english="Naja (UC)",name="NajaSalaheem",models=3066},
    [109]={id=1009,japanese="ライオンII",english="Lion II",name="Lion",models=3081},
    [110]={id=1010,japanese="ザイドII",english="Zeid II",name="Zeid",models=3086},
    [111]={id=1011,japanese="プリッシュII",english="Prishe II",name="Prishe",models=3082},
    [112]={id=1012,japanese="ナシュメラII",english="Nashmeira II",name="Nashmeira",models=3083},
    [113]={id=1013,japanese="リリゼットII",english="Lilisette II",name="Lilisette",models=3084},
    [114]={id=1014,japanese="テンゼンII",english="Tenzen II",name="Tenzen",models=3097},
    [115]={id=1015,japanese="ミュモルII",english="Mumor II",name="Mumor",models=3104},
    [116]={id=1016,japanese="イングリッドII",english="Ingrid II",name="Ingrid",models=3102},
    [117]={id=1017,japanese="アシェラII",english="Arciela II",name="Arciela",models=3085},
    [118]={id=1018,japanese="イロハII",english="Iroha II",name="Iroha",models=3112},
    [119]={id=1019,japanese="シャントットII",english="Shantotto II",name="Shantotto",models=3110},
    [120]={id=1003,japanese="コーネリア",english="Cornelia",name="Cornelia",models=3119}, --goodbye, my love
    [121]={id=999,japanese="モンブロー",english="Monberaux",name="Monberaux",models=3120},
    [122]={id=1003,japanese="マツイP",english="Matsui-P",name="Matsui-P",models=3121},
}

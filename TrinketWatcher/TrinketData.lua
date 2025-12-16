local ns = select(2, ...)

ns.trinketData = {
    ------------------------------------------- Proc Trinkets -------------------------------------------
    -- TBC
    [27683] = { ICD = 45,  buff = {33370} }, -- Quagmirran's Eye
    [28034] = { ICD = 50,  buff = {33649} }, -- Hourglass of the Unraveller
    [28190] = { ICD = 45,  buff = {33370} }, -- Scarab of the Infinite Cycle
    [28418] = { ICD = 45,  buff = {34321} }, -- Shiffar's Nexus-Horn
    [28830] = { ICD = 20,  buff = {34775} }, -- Dragonspine Trophy
    [30447] = { ICD = 45,  buff = {37198} }, -- Tome of Fiery Redemption
    [30450] = { ICD = 30,  buff = {37174} }, -- Warp-Spring Coil
    [30626] = { ICD = 45,  buff = {38348} }, -- Sextant of Unstable Currents
    [30627] = { ICD = 45,  buff = {42084} }, -- Tsunami Talisman
    [32496] = { ICD = 50,  buff = {37656} }, -- Memento of Tyrande
    [34427] = { ICD = 45,  buff = {45040} }, -- Blackened Naaru Sliver
    [34472] = { ICD = 45,  buff = {45053} }, -- Shard of Contempt
    -- WotLK
    [37220] = { ICD = 45,  buff = {60218} }, -- Essence of Gossamer
    [37390] = { ICD = 45,  buff = {60302} }, -- Meteorite Whetstone
    [37559] = { ICD = 45,  buff = {54738} }, -- Serrah's Star
    [37657] = { ICD = 45,  buff = {60520} }, -- Spark of Life
    [37660] = { ICD = 45,  buff = {60479} }, -- Forge Ember
    [37835] = { ICD = 50,  buff = {49623} }, -- Je'Tze's Bell
    [38071] = { ICD = 45,  buff = {54839} }, -- Valonforth's Remembrance
    [38212] = { ICD = 45,  buff = {54696} }, -- Death Knight's Anguish
    [38674] = { ICD = 30,  buff = {52419} }, -- Soul Harvester's Charm
    [38675] = { ICD = 45,  buff = {52424} }, -- Signet of the Dark Brotherhood
    [39229] = { ICD = 45,  buff = {60492} }, -- Embrace of the Spider
    [40255] = { ICD = 45,  buff = {60494} }, -- Dying Curse
    [40256] = { ICD = 45,  buff = {60437} }, -- Grim Troll
    [40258] = { ICD = 45,  buff = {60530} }, -- Forethought Talisman
    [40682] = { ICD = 45,  buff = {60064} }, -- Sundial of the Exiled
    [40684] = { ICD = 50,  buff = {60065} }, -- Mirror of Truth
    [40685] = { ICD = 45,  buff = {60062} }, -- The Egg of Mortal Essence
    [40767] = { ICD = 50,  buff = {55018} }, -- Sonic Booster
    [40865] = { ICD = 50,  buff = {55019} }, -- Noise Machine
    [43573] = { ICD = 50,  buff = {58904} }, -- Tears of Bitter Anguish
    [43829] = { ICD = 45,  buff = {59345} }, -- Crusader's Locket
    [43838] = { ICD = 45,  buff = {61618} }, -- Chuchu's Tiny Box of Horrors
    [42987] = { ICD = 45,  buff = {60229, 60233, 60234, 60235} }, -- Darkmoon Card: Greatness (Strength)
    [44253] = { ICD = 45,  buff = {60229, 60233, 60234, 60235} }, -- Darkmoon Card: Greatness (Agility)
    [44254] = { ICD = 45,  buff = {60229, 60233, 60234, 60235} }, -- Darkmoon Card: Greatness (Spirit)
    [44255] = { ICD = 45,  buff = {60229, 60233, 60234, 60235} }, -- Darkmoon Card: Greatness (Intellect)
    [44912] = { ICD = 50,  buff = {60064} }, -- Flow of Knowledge
    [44914] = { ICD = 50,  buff = {60065} }, -- Anvil of Titans
    [45131] = { ICD = 45,  buff = {63250} }, -- Jouster's Fury
    [45219] = { ICD = 45,  buff = {63250} }, -- Jouster's Fury
    [45286] = { ICD = 50,  buff = {65014} }, -- Pyrite Infuser
    [45490] = { ICD = 45,  buff = {64741} }, -- Pandora's Plea
    [45507] = { ICD = 50,  buff = {64765} }, -- The General's Heart
    [45518] = { ICD = 45,  buff = {64713} }, -- Flare of the Heavens
    [45522] = { ICD = 50,  buff = {64790} }, -- Blood of the Old God
    [45535] = { ICD = 50,  buff = {64739} }, -- Show of Faith
    [45609] = { ICD = 45,  buff = {64772} }, -- Comet's Trail
    [45866] = { ICD = 45,  buff = {65004} }, -- Elemental Focus Stone
    [45929] = { ICD = 50,  buff = {65003} }, -- Sif's Remembrance
    [45931] = { ICD = 45,  buff = {65019} }, -- Mjolnir Runestone
    [46038] = { ICD = 45,  buff = {65024} }, -- Dark Matter
    [47213] = { ICD = 45,  buff = {67669} }, -- Abyssal Rune
    [47214] = { ICD = 50,  buff = {67671} }, -- Banner of Victory
    [47216] = { ICD = 50,  buff = {67631} }, -- The Black Heart
    [47115] = { ICD = 45,  buff = {67703, 67708} }, -- Death's Veredict N
    [47303] = { ICD = 45,  buff = {67703, 67708} }, -- Death's Choice N
    [47131] = { ICD = 45,  buff = {67772, 67773} }, -- Death's Veredict H
    [47464] = { ICD = 45,  buff = {67772, 67773} }, -- Death's Choice H
    [49074] = { ICD = 50,  buff = {60065} }, -- Coren's Chromium Coaster
    [49076] = { ICD = 45,  buff = {60064} }, -- Mithril Pocketwatch
    [49078] = { ICD = 45,  buff = {60062} }, -- Ancient Pickled Egg
    [50198] = { ICD = 50,  buff = {71403} }, -- Needle-Encrusted Scorpion
    [50358] = { ICD = 50,  buff = {71584} }, -- Purified Lunar Dust
    [50342] = { ICD = 45,  buff = {71401} }, -- Whispering Fanged Skull N
    [50343] = { ICD = 45,  buff = {71541} }, -- Whispering Fanged Skull H
    [50352] = { ICD = 30,  buff = {71633} }, -- Corpse Tongue Coin N
    [50349] = { ICD = 30,  buff = {71639} }, -- Corpse Tongue Coin H
    [50353] = { ICD = 45,  buff = {71601} }, -- Dislodged Foreign Object N
    [50348] = { ICD = 45,  buff = {71644} }, -- Dislodged Foreign Object H
    [50360] = { ICD = 100, buff = {71605} }, -- Phylactery of the Nameless Lich N
    [50365] = { ICD = 100, buff = {71636} }, -- Phylactery of the Nameless Lich H
    [50362] = { ICD = 105, buff = {71484, 71485, 71486, 71491, 71492} }, -- Deathbringer's Will N
    [50363] = { ICD = 105, buff = {71556, 71558, 71559, 71560, 71561} }, -- Deathbringer's Will H
    [54571] = { ICD = 45,  buff = {75477} }, -- Petrified Twilight Scale N
    [54591] = { ICD = 45,  buff = {75480} }, -- Petrified Twilight Scale H
    [54572] = { ICD = 50,  buff = {75466} }, -- Charred Twilight Scale N
    [54588] = { ICD = 50,  buff = {75473} }, -- Charred Twilight Scale H
    [54569] = { ICD = 45,  buff = {75458} }, -- Sharpened Twilight Scale N
    [54590] = { ICD = 45,  buff = {75456} }, -- Sharpened Twilight Scale H
    ------------------------------------------- 0 ICD Trinkets -------------------------------------------
    -- Vanilla
    [1490]  = { ICD = 0,   buff = {10342} }, -- Guardian Talisman
    [11302] = { ICD = 0,   buff = {10368} }, -- Uther's Strength
    [11810] = { ICD = 0,   buff = {15595} }, -- Force of Will
    [14557] = { ICD = 0,   buff = {18946} }, -- The Lion Horn of Stormwind
    [17774] = { ICD = 0,   buff = {21970} }, -- Mark of the Chosen
    [19288] = { ICD = 0,   buff = {23684} }, -- Darkmoon Card: Blue Dragon
    -- TBC
    [28785] = { ICD = 0,   buff = {37658} }, -- The Lightning Capacitor
    [28789] = { ICD = 0,   buff = {34747} }, -- Eye of Magtheridon
    [30446] = { ICD = 0,   buff = {58157} }, -- Solarian's Sapphire
    [30448] = { ICD = 0,   buff = {37508} }, -- Talon of Al'ar
    [31856] = { ICD = 0,   buff = {39439, 39441} }, -- Darkmoon Card: Crusade
    [31857] = { ICD = 0,   buff = {39443} }, -- Darkmoon Card: Wrath
    [32485] = { ICD = 0,   buff = {40459} }, -- Ashtongue Talisman of Valor
    [32487] = { ICD = 0,   buff = {40487} }, -- Ashtongue Talisman of Swiftness
    [32488] = { ICD = 0,   buff = {40483} }, -- Ashtongue Talisman of Insight
    [32492] = { ICD = 0,   buff = {40461} }, -- Ashtongue Talisman of Lethality
    [32493] = { ICD = 0,   buff = {40480} }, -- Ashtongue Talisman of Shadows
    [32505] = { ICD = 0,   buff = {40477} }, -- Madness of the Betrayer
    [44073] = { ICD = 0,   buff = {59821} }, -- Frenzyheart Insignia of Fury
    [44074] = { ICD = 0,   buff = {59789} }, -- Oracle Talisman of Ablution
    -- WotLK
    [37111] = { ICD = 0,   buff = {60515} }, -- Soul Preserver
    [38072] = { ICD = 0,   buff = {54842} }, -- Thunder Capacitor
    [44073] = { ICD = 0,   buff = {59821} }, -- Frenzyheart Insignia of Fury
    [42989] = { ICD = 0,   buff = {60196} }, -- Darkmoon Card: Berserker!
    [45308] = { ICD = 0,   buff = {65006} }, -- Eye of the Broodmother
    [40430] = { ICD = 0,   buff = {60525} }, -- Majestic Dragon Figurine
    [40431] = { ICD = 0,   buff = {60314} }, -- Fury of the Five Flights
    [40432] = { ICD = 0,   buff = {60486} }, -- Illustration of the Dragon Soul
    [47316] = { ICD = 0,   buff = {67713} }, -- Reign of the Unliving N
    [47477] = { ICD = 0,   buff = {67759} }, -- Reign of the Unliving H
    [47182] = { ICD = 0,   buff = {67713} }, -- Reign of the Unliving N
    [47188] = { ICD = 0,   buff = {67759} }, -- Reign of the Unliving H
    [47271] = { ICD = 0,   buff = {67696} }, -- Solace of the Fallen N
    [47432] = { ICD = 0,   buff = {67750} }, -- Solace of the Fallen H
    [47041] = { ICD = 0,   buff = {67696} }, -- Solace of the Defeated N
    [47059] = { ICD = 0,   buff = {67750} }, -- Solace of the Defeated H
    [50340] = { ICD = 0,   buff = {71570} }, -- Muradin's Spyglass N
    [50345] = { ICD = 0,   buff = {71572} }, -- Muradin's Spyglass H
    [50341] = { ICD = 0,   buff = {71575} }, -- Unidentifiable Organ N
    [50344] = { ICD = 0,   buff = {71577} }, -- Unidentifiable Organ H
    [50355] = { ICD = 0,   buff = {71396} }, -- Herkuml War Token
    [50351] = { ICD = 0,   buff = {71432} }, -- Tiny Abomination in a Jar H
    [50706] = { ICD = 0,   buff = {71432} }, -- Tiny Abomination in a Jar H
    ----------------------------------------- On-use Trinkets -----------------------------------------
    -- Vanilla
    [2820]  = { buff = {14530} }, -- Nifty Stopwatch
    [4397]  = { buff =  {4079} }, -- Gnomish Cloaking Device
    [5079]  = { buff =  {1139} }, -- Cold Basilisk Eye
    [15867] = { buff = {19638} }, -- Prismcharm
    [18951] = { buff = {12438} }, -- Evonice's Landin' Pilla
    [19024] = { buff = {23506} }, -- Arena Grand Master
    [21748] = { buff = {26551} }, -- Figurine - Jade Owl
    [21756] = { buff = {26571} }, -- Figurine - Golden Hare
    [21758] = { buff = {26576} }, -- Figurine - Black Pearl Panther
    [21760] = { buff = {26581} }, -- Figurine - Truesilver Crab
    [21777] = { buff = {26600} }, -- Figurine - Emerald Owl
    -- TBC
    [21473] = { buff = {26166} }, -- Eye of Moam
    [21488] = { buff = {26168} }, -- Fetish of Chitinous Spikes
    [24125] = { buff = {31039} }, -- Figurine - Dawnstone Crab
    [24126] = { buff = {31040} }, -- Figurine - Living Ruby Serpent
    [24127] = { buff = {31045} }, -- Figurine - Talasite Owl
    [24128] = { buff = {31047} }, -- Figurine - Nightseye Panther
    [24376] = { buff = {31771} }, -- Runed Fungalcap
    [24390] = { buff = {31794} }, -- Auslese's Light Channeler
    [25619] = { buff = {32355} }, -- Glowing Crystal Insignia
    [25620] = { buff = {32355} }, -- Ancient Crystal Talisman
    [25628] = { buff = {32362} }, -- Ogre Mauler's Badge
    [25633] = { buff = {32362} }, -- Uniting Charm
    [25634] = { buff = {32367} }, -- Oshu'gun Relic
    [25787] = { buff = {32600} }, -- Charm of Alacrity
    [25936] = { buff = {39201} }, -- Terokkar Tablet of Vim
    [25937] = { buff = {39200} }, -- Terokkar Tablet of Precision
    [25994] = { buff = {32955} }, -- Rune of Force
    [25995] = { buff = {32956} }, -- Star of Sha'naar
    [25996] = { buff = {32957} }, -- Emblem of Perseverance
    [27529] = { buff = {33089} }, -- Figurine of the Colossus
    [27770] = { buff = {39228} }, -- Argussian Compass
    [27828] = { buff = {33400} }, -- Warp-Scarab Brooch
    [27891] = { buff = {33479} }, -- Adamantine Figurine
    [28040] = { buff = {33662} }, -- Vengeance of the Illidari
    [28041] = { buff = {33667} }, -- Bladefist's Breadth
    [28042] = { buff = {33668} }, -- Regal Protectorate
    [28121] = { buff = {34106} }, -- Icon of Unyielding Courage
    [28223] = { buff = {34000} }, -- Arcanist's Stone
    [28288] = { buff = {33807} }, -- Abacus of Violent Odds
    [28370] = { buff = {38346} }, -- Bangle of Endless Blessings
    [28528] = { buff = {34519} }, -- Moroes' Lucky Pocket Watch
    [28590] = { buff = {38332} }, -- Ribbon of Sacrifice
    [28727] = { buff = {29601} }, -- Pendant of the Violet Eye
    [29132] = { buff = {35337} }, -- Scryer's Bloodgem
    [29179] = { buff = {35337} }, -- Xi'ri's Gift
    [29370] = { buff = {35163} }, -- Icon of the Silver Crescent
    [29376] = { buff = {35165} }, -- Essence of the Martyr
    [29383] = { buff = {35166} }, -- Bloodlust Brooch
    [29387] = { buff = {35169} }, -- Gnomeregan Auto-Blocker 600
    [29776] = { buff = {35733} }, -- Core of Ar'kelos
    [30293] = { buff = {36347} }, -- Heavenly Inspiration
    [30300] = { buff = {36372} }, -- Dabiri's Enigma
    [30340] = { buff = {36432} }, -- Starkiller's Bauble
    [30620] = { buff = {38325} }, -- Spyglass of the Hidden Fleet
    [30629] = { buff = {38351} }, -- Scarab of Displacement
    [30665] = { buff = {40402} }, -- Earring of Soulful Meditation
    [31615] = { buff = {33662} }, -- Ancient Draenei Arcane Relic
    [31617] = { buff = {33667} }, -- Ancient Draenei War Talisman
    [32501] = { buff = {40464} }, -- Shadowmoon Insignia
    [32534] = { buff = {40538} }, -- Brooch of the Immortal King
    [32483] = { buff = {40396} }, -- The Skull of Gul'dan
    [32654] = { buff = {40724} }, -- Crystalforged Trinket
    [32658] = { buff = {40729} }, -- Badge of Tenacity
    [33828] = { buff = {43710} }, -- Tome of Diabolic Remedy
    [33829] = { buff = {43712} }, -- Hex Shrunken Head
    [33830] = { buff = {43713} }, -- Ancient Aqir Artifact
    [33831] = { buff = {43716} }, -- Berserker's Call
    [34428] = { buff = {45049} }, -- Steely Naaru Sliver
    [34429] = { buff = {45042} }, -- Shifting Naaru Sliver
    [34430] = { buff = {45052} }, -- Glimmering Naaru Sliver
    [35693] = { buff = {46780} }, -- Figurine - Empyrean Tortoise
    [35700] = { buff = {46783} }, -- Figurine - Crimson Serpent
    [35702] = { buff = {46784} }, -- Figurine - Shadowsong Panther
    [35703] = { buff = {46785} }, -- Figurine - Seaspray Albatross
    [41587] = { buff = {44055} }, -- Battlemaster's Celerity
    [41588] = { buff = {44055} }, -- Battlemaster's Aggression
    [41589] = { buff = {44055} }, -- Battlemaster's Resolve
    [41590] = { buff = {44055} }, -- Battlemaster's Courage
    -- WotLK
    [35935] = { buff = {47215} }, -- Infused Coldstone Rune
    [35937] = { buff = {47217} }, -- Braxley's Backyard Moonshine
    [37555] = { buff = {48846} }, -- Warsong's Wrath
    [37556] = { buff = {48847} }, -- Talisman of the Tundra
    [37557] = { buff = {48848} }, -- Warsong's Fervor
    [37558] = { buff = {48855} }, -- Tidal Boon
    [37560] = { buff = {48865} }, -- Vial of Renewal
    [37562] = { buff = {48868} }, -- Fury of the Crimson Drake
    [38213] = { buff = {48846} }, -- Harbinger's Wrath
    [38070] = { buff = {51985} }, -- Foresight's Anticipation
    [38073] = { buff = {33662} }, -- Will of the Red Dragonflight
    [38080] = { buff = {51978} }, -- Automated Weapon Coater
    [38081] = { buff = {51987} }, -- Scarab of Isanoth
    [38760] = { buff = {48875} }, -- Mendicant's Charm
    [38761] = { buff = {61778} }, -- Talon of Hatred
    [38762] = { buff = {48875} }, -- Insignia of Bloody Fire
    [39811] = { buff = {62088} }, -- Badge of the Infiltrator
    [39819] = { buff = {48875} }, -- Bloodbinder's Runestone
    [39821] = { buff = {48875} }, -- Spiritist's Focus
    [38763] = { buff = {61426} }, -- Futuresight Rune
    [38764] = { buff = {61427} }, -- Rune of Finite Variation
    [38765] = { buff = {61428} }, -- Rune of Infinite Power
    [43836] = { buff = {61620} }, -- Thorny Rose Brooch
    [43837] = { buff = {61617} }, -- Softly Glowing Orb
    [36871] = { buff = {47806} }, -- Fury of the Encroaching Storm
    [36872] = { buff = {47807} }, -- Mender of the Oncoming Dawn
    [36874] = { buff = {47816} }, -- Horn of the Herald
    [36972] = { buff = {60471} }, -- Tome of Arcane Phenomena
    [36993] = { buff = {60214} }, -- Seal of the Pantheon
    [37166] = { buff = {60305} }, -- Sphere of Red Dragon's Blood
    [37254] = { buff = {48333} }, -- Super Simian Sphere
    [37638] = { buff = {60180} }, -- Offering of Sacrifice
    [37723] = { buff = {60299} }, -- Incisor Fragment
    [37734] = { buff = {60517} }, -- Talisman of Troll Divinity
    [37844] = { buff = {60521} }, -- Winged Talisman
    [37872] = { buff = {60215} }, -- Lavanthor's Talisman
    [37873] = { buff = {60480} }, -- Mark of the War Prisoner
    [38257] = { buff = {47816} }, -- Strike of the Seas
    [38258] = { buff = {50261} }, -- Sailor's Knotted Charm
    [38259] = { buff = {50263} }, -- First Mate's Pocketwatch
    [39257] = { buff = {60439} }, -- Loatheb's Shadow
    [39292] = { buff = {60180} }, -- Repelling Charge
    [39388] = { buff = {60527} }, -- Spirit-World Glass
    [40257] = { buff = {60286} }, -- Defender's Code
    [40372] = { buff = {60258} }, -- Rune of Repulsion
    [40531] = { buff = {60319} }, -- Mark of Norgannon
    [40683] = { buff = {60054} }, -- Valor Medal of the First War
    [42341] = { buff = {56121} }, -- Figurine - Ruby Hare
    [42395] = { buff = {68351} }, -- Figurine - Twilight Serpent
    [42413] = { buff = {56186} }, -- Figurine - Sapphire Owl
    [42128] = { buff = {55915} }, -- Battlemaster's Hostility
    [42129] = { buff = {55915} }, -- Battlemaster's Accuracy
    [42130] = { buff = {55915} }, -- Battlemaster's Avidity
    [42131] = { buff = {55915} }, -- Battlemaster's Conviction
    [42132] = { buff = {55915} }, -- Battlemaster's Bravery
    [42133] = { buff = {67596} }, -- Battlemaster's Fury
    [42134] = { buff = {67596} }, -- Battlemaster's Precision
    [42135] = { buff = {67596} }, -- Battlemaster's Vivacity
    [42136] = { buff = {67596} }, -- Battlemaster's Rage
    [42137] = { buff = {67596} }, -- Battlemaster's Ruination
    [42988] = { buff = {57350} }, -- Darkmoon Card: Illusion
    [44013] = { buff = {59657} }, -- Cannoneer's Fuselighter
    [44014] = { buff = {59658} }, -- Fezzik's Pocketwatch
    [44015] = { buff = {59657} }, -- Cannoneer's Morale
    [44063] = { buff = {59757} }, -- Figurine - Monarch Crab
    [45148] = { buff = {64712} }, -- Living Flame
    [45158] = { buff = {64763} }, -- Heart of Iron
    [45263] = { buff = {64800} }, -- Wrathstone
    [45292] = { buff = {65008} }, -- Energy Siphon
    [45313] = { buff = {65011} }, -- Furnace Stone
    [45466] = { buff = {64707} }, -- Scale of Fates
    [46021] = { buff = {65012} }, -- Royal Seal of King Llane
    [46051] = { buff = {64999} }, -- Meteorite Crystal
    [46086] = { buff = {64524} }, -- Platinum Disks of Battle
    [46087] = { buff = {64525} }, -- Platinum Disks of Sorcery
    [46088] = { buff = {64527} }, -- Platinum Disks of Swiftness
    [47734] = { buff = {67695} }, -- Mark of Supremacy
    [47735] = { buff = {67694} }, -- Glyph of Indomitability
    [48722] = { buff = {67683} }, -- Shard of the Crystal Heart
    [48724] = { buff = {67684} }, -- Talisman of Resurgence
    [49080] = { buff = {68443} }, -- Brawler's Souvenir
    [50235] = { buff = {71569} }, -- Ick's Rotting Thumb
    [50259] = { buff = {71564} }, -- Nevermelting Ice Crystal
    [50260] = { buff = {71568} }, -- Ephemeral Snowflake
    [50357] = { buff = {71579} }, -- Maghia's Misguided Quill
    [47080] = { buff = {67699} }, -- Satrina's Impeding Scarab N
    [47088] = { buff = {67753} }, -- Satrina's Impeding Scarab H
    [47290] = { buff = {67699} }, -- Juggernaut's Vitality N
    [47451] = { buff = {67753} }, -- Juggernaut's Vitality H
    [47879] = { buff = {67736} }, -- Fetish of Volatile Power N
    [48018] = { buff = {67744} }, -- Fetish of Volatile Power H
    [47726] = { buff = {67736} }, -- Talisman of Volatile Power N
    [47946] = { buff = {67744} }, -- Talisman of Volatile Power H
    [47882] = { buff = {67728} }, -- Eitrigg's Oath N
    [48021] = { buff = {67742} }, -- Eitrigg's Oath H
    [47727] = { buff = {67728} }, -- Fervor of the Frostborn N
    [47949] = { buff = {67742} }, -- Fervor of the Frostborn H
    [47881] = { buff = {67738} }, -- Vengeance of the Forsaken N
    [48020] = { buff = {67747} }, -- Vengeance of the Forsaken H
    [47725] = { buff = {67738} }, -- Victor's Call N
    [47948] = { buff = {67747} }, -- Victor's Call H
    [47880] = { buff = {67726} }, -- Binding Stone N
    [48019] = { buff = {67740} }, -- Binding Stone H
    [47728] = { buff = {67726} }, -- Binding Light N
    [47947] = { buff = {67740} }, -- Binding Light H
    [50356] = { buff = {71586} }, -- Corroded Skeleton Key
    [50361] = { buff = {71635} }, -- Sindragosa's Flawless Fang N
    [50364] = { buff = {71638} }, -- Sindragosa's Flawless Fang H
    [54573] = { buff = {75490} }, -- Glowing Twilight Scale N
    [54589] = { buff = {75495} }, -- Glowing Twilight Scale H
    ------------------------------------------ Non-buff Trinkets ------------------------------------------
    -- Vanilla
    [17691] = { CD = 120, spell = 22564 }, -- Stormpike Insignia Rank 1
    [17900] = { CD = 120, spell = 22564 }, -- Stormpike Insignia Rank 2
    [17901] = { CD = 120, spell = 22564 }, -- Stormpike Insignia Rank 3
    [17902] = { CD = 120, spell = 22564 }, -- Stormpike Insignia Rank 4
    [17903] = { CD = 120, spell = 22564 }, -- Stormpike Insignia Rank 5
    [17904] = { CD = 30,  spell = 22564 }, -- Stormpike Insignia Rank 6
    [17690] = { CD = 120, spell = 22563 }, -- Frostwolf Insignia Rank 1
    [17905] = { CD = 120, spell = 22563 }, -- Frostwolf Insignia Rank 2
    [17906] = { CD = 120, spell = 22563 }, -- Frostwolf Insignia Rank 3
    [17907] = { CD = 120, spell = 22563 }, -- Frostwolf Insignia Rank 4
    [17908] = { CD = 120, spell = 22563 }, -- Frostwolf Insignia Rank 5
    [17909] = { CD = 30,  spell = 22563 }, -- Frostwolf Insignia Rank 6
    -- TBC
    [25829] = { CD = 120, spell = 33828 }, -- Talisman of the Alliance
    [24551] = { CD = 120, spell = 32140 }, -- Talisman of the Horde
    [28234] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [28235] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [28236] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [28237] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [28238] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [30348] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [30349] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [30350] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [30351] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [37864] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [28239] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [28240] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [28241] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [28242] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [28243] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [30343] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [30344] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [30345] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [30346] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [37865] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    -- WotLK
    [39889] = { CD = 45,  spell = 55748 }, -- Horn of Argent Fury
    [37264] = { CD = 45,  spell = 60483 }, -- Pendulum of Telluric Currents
    [37064] = { CD = 45,  spell = 60307 }, -- Vestige of Haldor
    [38358] = { CD = 10,  spell = 51353 }, -- Arcane Revitalizer
    [38359] = { CD = 10,  spell = 51348 }, -- Arcane Revitalizer
    [40492] = { CD = 600, spell = 54307 }, -- Argent War Horn
    [40593] = { CD = 60,  spell = 54418 }, -- Argent Tome
    [40601] = { CD = 60,  spell = 54329 }, -- Argent Dawn Banner
    [42418] = { CD = 300, spell = 56188 }, -- Figurine - Emerald Boar
    [44579] = { CD = 120, spell = 60986 }, -- Medallion of Heroism
    [44597] = { CD = 120, spell = 60986 }, -- Medallion of Heroism
    [45631] = { CD = 600, spell = 25823 }, -- High-powered Flashlight
    [49116] = { CD = 600, spell = 68271 }, -- Bitter Balebrew Charm
    [49118] = { CD = 600, spell = 68270 }, -- Bubbling Brightbrew Charm
    [41121] = { CD = 60,  spell = 55039 }, -- Gnomish Lightning Generator
    [47215] = { CD = 45,  spell = 67666 }, -- Tears of the Vanquished
    [40382] = { CD = 45,  spell = 60538 }, -- Soul of the Dead
    [40373] = { CD = 15,  spell = 60488 }, -- Extract of Necromantic Power
    [42990] = { CD = 45,  spell = 60203 }, -- Darkmoon Card: Death
    [40371] = { CD = 45,  spell = 60443 }, -- Bandit's Insignia
    [40532] = { CD = 60,  spell = 60526 }, -- Living Ice Crystals
    [46312] = { CD = 120, spell = 64981 }, -- Vanquished Clutches of Yogg-Saron
    [38589] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [38588] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [40476] = { CD = 300, spell = 42292 }, -- Insignia of the Alliance
    [40477] = { CD = 300, spell = 42292 }, -- Insignia of the Horde
    [40483] = { CD = 300, spell = 42292 }, -- Insignia of the Scourge
    [44097] = { CD = 300, spell = 42292 }, -- Inherited Insignia of the Horde
    [44098] = { CD = 300, spell = 42292 }, -- Inherited Insignia of the Alliance
    [46081] = { CD = 120, spell = 42292 }, -- Titan-Forged Rune of Audacity
    [46082] = { CD = 120, spell = 42292 }, -- Titan-Forged Rune of Determination
    [46083] = { CD = 120, spell = 42292 }, -- Titan-Forged Rune of Accuracy
    [46084] = { CD = 120, spell = 42292 }, -- Titan-Forged Rune of Cruelty
    [46085] = { CD = 120, spell = 42292 }, -- Titan-Forged Rune of Alacrity
    [42123] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [42124] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [51377] = { CD = 120, spell = 42292 }, -- Medallion of the Alliance
    [42122] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [42126] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [51378] = { CD = 120, spell = 42292 }, -- Medallion of the Horde
    [50339] = { CD = 120, spell = 71565 }, -- Sliver of Pure Ice N
    [50346] = { CD = 120, spell = 71574 }, -- Sliver of Pure Ice H
    [50354] = { CD = 120, spell = 71607 }, -- Bauble of True Blood N
    [50726] = { CD = 120, spell = 71646 }, -- Bauble of True Blood H
    [50359] = { CD = 45,  spell = 71610 }, -- Althor's Abacus N
    [50366] = { CD = 45,  spell = 71641 }, -- Althor's Abacus H
}

for itemID, data in pairs(ns.trinketData) do
    data.itemTex = GetItemIcon(itemID)
    if data.buff then
        local buffTex = {}
        for _, spellID in ipairs(data.buff) do
            local tex = select(3, GetSpellInfo(spellID))
            if tex then
                buffTex[spellID] = tex
            end
        end
        data.buff = buffTex
    elseif data.CD then
        data.castName = GetSpellInfo(data.spell)
    end
end
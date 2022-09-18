return {
    --[[
        [Level] = {
            Level = Level;
            Name = "";
            Info = "";
            Requirements = {
                Cash = 0; -- Cash Needed
                Cows = 0; -- Cows Needed
            };
            CashPerLitre = 10;
            Upgrades = {
                Silo = {
                };
                Upgrades = {
                    Type = 10 -- Limit on upgrades
                }; 
                ...
            }
        }
    ]]
    ["1"] = {
        Level = 1;
        CashPerLitre = 10;
        LevelInfo = {
            Name = "";
            Info = "";
        };
        Requirements = {
            Cash = 0;
            Cows = 0;
        };
        Upgrades = {
            Silo = {
                Type = 3;
            }
        }
    }
}
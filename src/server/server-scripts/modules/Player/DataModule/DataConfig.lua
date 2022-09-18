return {
    playerDataStore = {
        Name = "TheCowCompanyPlayerData";
        Data = {
            CowFarmLevel = 0;
            Cash = 0;
            Milk = 0;
            Cows = 0;
            Upgrades = {
                CurrentlyCompleted = 0;
                UpgradesCompleted = {}; --[[
                    {[0, allUpgrades]}
                ]]
                UpgradesInProgress = {}; --[[
                    ["4"] = {
                        Type = type;
                        CurrentStage = 0;
                        EndStage = 100;
                    }
                ]]
            };
            LifeTime = {
                NewPlayer = true;
                CowFarmLevel = 0;
                Cash = 0;
                Milk = 0;
                Cows = 0;
                CurrentlyCompleted = 0;
            };
            Level = {
                CowStore = {
                    ["1"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Cows = 0;
                        CurrentLevel = 0;
                    };
                    ["2"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Cows = 0;
                        CurrentLevel = 0;
                    };
                    ["3"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Cows = 0;
                        CurrentLevel = 0;
                    };
                    ["4"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Cows = 0;
                        CurrentLevel = 0;
                    };
                };
                CowIncubator = {
                    Position = {x = 0, z = 0};
                    Type = 0;
                };
                MilkSilo = {
                    ["1"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Milk = 0;
                        Upgrade = {
                            Type = 0;
                            Progress = 0; -- 0 -> 1
                        }
                    };
                    ["2"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Milk = 0;
                        Upgrade = {
                            Type = 0;
                            Progress = 0; -- 0 -> 1
                        }
                    };
                    ["3"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Milk = 0;
                        Upgrade = {
                            Type = 0;
                            Progress = 0; -- 0 -> 1
                        }
                    };
                    ["4"] = {
                        Position = {x = 0, z = 0};
                        Type = 0;
                        Milk = 0;
                        Upgrade = {
                            Type = 0;
                            Progress = 0; -- 0 -> 1
                        }
                    }
                };
                MilkDelivery = {
                    Position = {x = 0, y = 0};
                    Type = 0;
                    Upgrade = {
                        Type = 0;
                        Progress = 0;
                    }
                }
            }
        }
    }
}
local type = require "eaw-abstraction-layer.types.type"
local unit_object = require "eaw-abstraction-layer.types.unit_object"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_return_method = metatables.callback_return_method

local function spawn()
    local Spawn_Unit = callback_return_method("Spawn_Unit")
    function Spawn_Unit.return_value(obj_type, location, owner)
        local unit = unit_object {
            name = obj_type.Get_Name(),
            owner = owner
        }

        function unit.Get_Planet_Location.return_value()
            return location
        end

        return { unit }
    end

    local SpawnList = callback_return_method("SpawnList")
    function SpawnList.return_value(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario)
        local return_tab = {}
        for _, type_name in pairs(type_list) do
            table.insert(
                return_tab,
                unit_object {
                    name = type(type_name),
                    owner = player
                }
            )
        end

        return return_tab
    end


    return {
        Spawn_Unit = Spawn_Unit;
        SpawnList = SpawnList;
    }
end

return spawn
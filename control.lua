--control.lua

function UpdateCeaseFires()
   local forces = game.forces
   for key,force in pairs(forces) do
      if force.name ~= "enemy" and force.name ~= "neutral" then
         connected_players = #force.connected_players
         force_entities = game.surfaces[1].find_entities_filtered{force = force}
         if connected_players > 0 then
            game.print("Cease fire deactivated for " .. force.name .. ". " .. connected_players .. " player(s) online. Activated " .. #force_entities .. " entities.")
            for key,entity in pairs(force_entities) do
               entity.active = true
            end
            game.forces["enemy"].set_cease_fire(force, false)
         else
            game.print("Cease fire activated for " .. force.name .. ". " .. connected_players .. " player(s) online. Deactivated " .. #force_entities .. " entities.")
            for key,entity in pairs(force_entities) do
               entity.active = false
            end
            game.forces["enemy"].set_cease_fire(force, true)
         end
      end
   end
end

script.on_event(defines.events.on_player_joined_game, UpdateCeaseFires)

script.on_event(defines.events.on_player_left_game, UpdateCeaseFires)

script.on_event(defines.events.on_player_changed_force, UpdateCeaseFires)
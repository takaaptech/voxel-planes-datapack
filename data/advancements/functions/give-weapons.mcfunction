#処理：phantom_spawn_eggがアイテム欄から消えるまでplaneを与える
loot give @s[advancements={weapon-data:bomb/60kg-bomb=true}] loot weapon-data:60kg-bomb

clear @s phantom_spawn_egg 1
execute store success score @s reg1 run clear @s phantom_spawn_egg 0
execute if score @s reg1 matches 1.. run function advancements:give-weapons

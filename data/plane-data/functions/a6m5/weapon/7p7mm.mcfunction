#7.7mm機銃を使用 a6m
#実行者：機体

#曳光弾判定
scoreboard players operation #is-bullet vp.reg1 = @s vp.ammunition2
scoreboard players operation #is-tracer vp.reg1 = @s vp.ammunition2
scoreboard players operation #is-bullet vp.reg1 %= #3 vp.Num
scoreboard players operation #is-tracer vp.reg1 %= #6 vp.Num

#召喚
execute if score #is-tracer vp.reg1 matches 0 run summon minecraft:armor_stand ~ ~ ~ {Invisible:1,NoGravity:1,Tags:[projectile,gun,7p7mm,gun-init,right,tracer-lightblue,entity-nohit,offset-base,tracer],Duration:25}
execute if score #is-tracer vp.reg1 matches 0 run summon minecraft:armor_stand ~ ~ ~ {Invisible:1,NoGravity:1,Tags:[projectile,gun,7p7mm,gun-init,left,tracer-lightblue,entity-nohit,offset-base,tracer],Duration:25}
execute if score #is-bullet vp.reg1 matches 0 unless score #is-tracer vp.reg1 matches 0 run summon minecraft:area_effect_cloud ~ ~ ~ {NoGravity:1,Tags:[projectile,gun,7p7mm,gun-init,right,tracer-lightblue,entity-nohit,offset-base],Duration:25}
execute if score #is-bullet vp.reg1 matches 0 unless score #is-tracer vp.reg1 matches 0 run summon minecraft:area_effect_cloud ~ ~ ~ {NoGravity:1,Tags:[projectile,gun,7p7mm,gun-init,left,tracer-lightblue,entity-nohit,offset-base],Duration:25}

#スコア付与
scoreboard players set @e[tag=gun-init,distance=..5] vp.speed 95
scoreboard players set @e[tag=gun-init,distance=..5] vp.damage 4
scoreboard players set @e[tag=gun-init,distance=..5,type=armor_stand] vp.max-age 25
scoreboard players operation @e[tag=gun-init,distance=..5] vp.plane-id = @s vp.plane-id
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetX 150
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetY 550
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetZ 2500
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetX -250
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetY 550
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetZ 2500

#5発目の弾なら曳光弾化
scoreboard players operation @s vp.reg1 = @s vp.ammunition2
scoreboard players operation @s vp.reg1 %= #5 vp.Num
execute if score @s vp.reg1 matches 0 run tag @e[tag=gun-init,distance=..10] add tracer

#発射位置に移動
function plane:position/util/calc-triangle-ratio
scoreboard players operation #sin vp.reg1 = #sin vp.return
scoreboard players operation #cos vp.reg1 = #cos vp.return
execute as @e[tag=gun-init,distance=..5] run function plane-data:util/gun-set-position

#発射したならreload時間設定
execute if entity @e[tag=gun-init,distance=..20] run scoreboard players set @s vp.w2-cooltime 2

#音
playsound minecraft:weapon.gun-7p7m.fire master @a ~ ~ ~ 1 1 1

#発射炎
#execute as @e[tag=gun-init,distance=..10] at @s run particle minecraft:cloud ^ ^ ^ 0.1 0.1 0.1 0.1 1 force

#残弾数減算
scoreboard players remove @s vp.ammunition2 1

#終了処理
tag @e[tag=gun-init,distance=..20] remove gun-init



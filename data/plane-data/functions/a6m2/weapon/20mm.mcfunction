#20mm機銃を使用 a6m2
#実行者：機体

#5発目の弾なら曳光弾化
scoreboard players operation #is-bullet vp.reg1 = @s vp.ammunition1
scoreboard players operation #is-tracer vp.reg1 = @s vp.ammunition1
scoreboard players operation #is-bullet vp.reg1 %= #3 vp.Num
scoreboard players operation #is-tracer vp.reg1 %= #6 vp.Num

#召喚
execute if score #is-tracer vp.reg1 matches 0 run summon armor_stand ~ ~ ~ {NoGravity:1,Invisible:1,Tags:[projectile,gun,20mm,gun-init,right,tracer-yellow,entity-nohit,offset-base,tracer],Duration:30}
execute if score #is-tracer vp.reg1 matches 0 run summon armor_stand ~ ~ ~ {NoGravity:1,Invisible:1,Tags:[projectile,gun,20mm,gun-init,left,tracer-yellow,entity-nohit,offset-base,tracer],Duration:30}
execute if score #is-bullet vp.reg1 matches 0 unless score #is-tracer vp.reg1 matches 0 run summon area_effect_cloud ~ ~ ~ {Tags:[projectile,gun,20mm,gun-init,right,tracer-yellow,entity-nohit,offset-base],Duration:30}
execute if score #is-bullet vp.reg1 matches 0 unless score #is-tracer vp.reg1 matches 0 run summon area_effect_cloud ~ ~ ~ {Tags:[projectile,gun,20mm,gun-init,left,tracer-yellow,entity-nohit,offset-base],Duration:30}

#スコア付与
scoreboard players set @e[tag=gun-init,distance=..5] vp.speed 75
scoreboard players set @e[tag=gun-init,distance=..5] vp.damage 60
scoreboard players set @e[tag=gun-init,distance=..5,type=armor_stand] vp.max-age 30
scoreboard players operation @e[tag=gun-init,distance=..5] vp.plane-id = @s vp.plane-id
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetX 1950
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetY 200
scoreboard players set @e[tag=gun-init,tag=left,distance=..5] vp.offsetZ 2100
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetX -2050
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetY 200
scoreboard players set @e[tag=gun-init,tag=right,distance=..5] vp.offsetZ 2200

#発射位置に移動
function plane:position/util/calc-triangle-ratio
scoreboard players operation #sin vp.reg1 = #sin vp.return
scoreboard players operation #cos vp.reg1 = #cos vp.return
execute as @e[tag=gun-init,distance=..5] run function plane-data:util/gun-set-position

#発射したならreload時間設定
execute if entity @e[tag=gun-init,distance=..20] run scoreboard players set @s vp.w1-cooltime 3

#音
playsound minecraft:weapon.heavy-muchingun.fire master @a ~ ~ ~ 1 1 1

#発射炎
#execute as @e[tag=gun-init,distance=..10] at @s run particle minecraft:cloud ^ ^ ^ 0.1 0.1 0.1 0.1 1 force

#残弾数減算
scoreboard players remove @s vp.ammunition1 1

#終了処理
tag @e[tag=gun-init,distance=..20] remove gun-init



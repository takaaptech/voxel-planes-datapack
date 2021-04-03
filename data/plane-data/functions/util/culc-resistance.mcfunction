#> plane-data:util/culc-resistance
#
# 空気抵抗値を計算
#
# @input
#   storage voxel-planes:input input:{weight,flight-model.engine.horse-power,flight-model.speed.max-speed}
# @output
#   score #resistance vp.return
# @within
#   function plane-data:**

#空気抵抗最大値計算
execute store result score #weight vp.reg1 run data get storage voxel-planes:input input.weight
execute store result score #horse-power vp.reg1 run data get storage voxel-planes:input input.flight-model.engine.horse-power
execute store result score #max-speed vp.reg1 run data get storage voxel-planes:input input.flight-model.speed.max-speed 34.72
scoreboard players set #resistance vp.return 1837500

scoreboard players operation #resistance vp.return /= #weight vp.reg1
scoreboard players operation #resistance vp.return *= #horse-power vp.reg1
scoreboard players operation #resistance vp.return /= #max-speed vp.reg1 

#tellraw @p [{"score":{"name":"#resistance","objective":"vp.return"}}]

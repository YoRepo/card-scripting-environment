--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 不死之魔王 骸骨恶魔  (ID: 59969392)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Zombie
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 69
--
-- Effect Text:
-- 「僵尸带菌者」＋调整以外的不死族怪兽2只以上
-- 自己场上表侧表示存在的不死族怪兽不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--アンデット・スカル・デーモン
function c59969392.initial_effect(c)
	aux.AddMaterialCodeList(c,33420078)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,33420078),aux.NonTuner(Card.IsRace,RACE_ZOMBIE),2)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	e1:SetValue(1)
	c:RegisterEffect(e1)
end

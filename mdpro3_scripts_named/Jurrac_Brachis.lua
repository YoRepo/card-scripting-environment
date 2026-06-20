--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 朱罗纪腕龙  (ID: 8594079)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 34
--
-- Effect Text:
-- 场上有这张卡以外的名字带有「朱罗纪」的怪兽表侧表示存在的场合，这张卡不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ブラキス
function c8594079.initial_effect(c)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c8594079.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c8594079.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x22)
end
function c8594079.indcon(e)
	return Duel.IsExistingMatchingCard(c8594079.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end

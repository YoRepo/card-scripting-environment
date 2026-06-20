--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 三死青蛙  (ID: 9910360)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 18
--
-- Effect Text:
-- 「死亡青蛙」＋「死亡青蛙」＋「死亡青蛙」
-- 这只怪兽融合召唤只能使用上述的卡进行。这张卡的攻击力上升自己墓地存在的「黄泉青蛙」的数量×500的数值。
--[[ __CARD_HEADER_END__ ]]

--ガエル・サンデス
function c9910360.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,84451804,3,false,false)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c9910360.atkval)
	c:RegisterEffect(e2)
end
function c9910360.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,12538374)*500
end

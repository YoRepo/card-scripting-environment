--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 入魔曼德拉草  (ID: 8814959)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 4
-- ATK 1550 | DEF 1450
-- Setcode: 10
--
-- Effect Text:
-- ①：对方场上的怪兽数量比自己场上的怪兽多的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・マンドラゴ
function c8814959.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c8814959.spcon)
	c:RegisterEffect(e1)
end
function c8814959.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)<Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)
end

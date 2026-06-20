--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 电子龙  (ID: 70095154)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 5
-- ATK 2100 | DEF 1600
-- Setcode: 4243
--
-- Effect Text:
-- ①：只有对方场上才有怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--サイバー・ドラゴン
function c70095154.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c70095154.spcon)
	c:RegisterEffect(e1)
end
function c70095154.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 入侵蠕虫  (ID: 97466712)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 1
-- ATK 400 | DEF 0
-- Setcode: 62
--
-- Effect Text:
-- ①：对方场上没有怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ハック・ワーム
function c97466712.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c97466712.hspcon)
	c:RegisterEffect(e1)
end
function c97466712.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end

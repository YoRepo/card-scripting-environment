--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Cyber Shark  (ID: 32393580)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 2100 | DEF 2000
-- Setcode: 0x93, 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a WATER monster, you can Normal Summon this card without Tributing.
--[[ __CARD_HEADER_END__ ]]

--サイバー・シャーク
function c32393580.initial_effect(c)
	--summon without tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32393580,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c32393580.ntcon)
	c:RegisterEffect(e1)
end
function c32393580.ntfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c32393580.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c32393580.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

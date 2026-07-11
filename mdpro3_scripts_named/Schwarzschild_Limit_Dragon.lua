--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Schwarzschild Limit Dragon  (ID: 6930746)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 8
-- ATK 2000 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster with 2000 or more ATK, you can Special Summon this card (from
-- your hand).
--[[ __CARD_HEADER_END__ ]]

--限界竜シュヴァルツシルト
function c6930746.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c6930746.spcon)
	c:RegisterEffect(e1)
end
function c6930746.filter(c)
	return c:IsFaceup() and c:IsAttackAbove(2000)
end
function c6930746.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c6930746.filter,tp,0,LOCATION_MZONE,1,nil)
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Unknown Synchron  (ID: 15310033)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x1017
-- Scope: OCG / TCG
--
-- Effect Text:
-- If only your opponent controls a monster, you can Special Summon this card (from your hand).
-- You can only Special Summon "Unknown Synchron" once per Duel this way.
--[[ __CARD_HEADER_END__ ]]

--アンノウン・シンクロン
function c15310033.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,15310033+EFFECT_COUNT_CODE_OATH+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c15310033.spcon)
	c:RegisterEffect(e1)
end
function c15310033.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Reed Butterfly  (ID: 71353388)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 1
-- ATK 300 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a face-up Synchro Monster(s) and you control no face-up Synchro Monsters,
-- you can Special Summon this card from your hand.
--[[ __CARD_HEADER_END__ ]]

--リード・バタフライ
function c71353388.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c71353388.spcon)
	c:RegisterEffect(e1)
end
function c71353388.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c71353388.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c71353388.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
		and	not Duel.IsExistingMatchingCard(c71353388.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

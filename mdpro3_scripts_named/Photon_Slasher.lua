--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Photon Slasher  (ID: 9718968)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 5
-- ATK 2100 | DEF 1000
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a face-up Xyz Monster is on the field, you can Special Summon this card (from your hand) in
-- face-up Defense Position.
--[[ __CARD_HEADER_END__ ]]

--フォトン・スレイヤー
function c9718968.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c9718968.spcon)
	c:RegisterEffect(e1)
end
function c9718968.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c9718968.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c9718968.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

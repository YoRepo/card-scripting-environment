--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Blackwing - Kris the Crack of Dawn  (ID: 81105204)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 4
-- ATK 1900 | DEF 300
-- Setcode: 0x33
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Blackwing" monster other than "Blackwing - Kris the Crack of Dawn", you can
-- Special Summon this card (from your hand).
-- You can only Special Summon "Blackwing - Kris the Crack of Dawn" once per turn this way.
-- The first time this card on the field would be destroyed by Spell/Trap effect each turn, it is not
-- destroyed.
--[[ __CARD_HEADER_END__ ]]

--BF－残夜のクリス
function c81105204.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,81105204+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81105204.spcon)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c81105204.valcon)
	c:RegisterEffect(e2)
end
function c81105204.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and not c:IsCode(81105204)
end
function c81105204.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81105204.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c81105204.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end

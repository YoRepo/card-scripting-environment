--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Hazy Flame Griffin  (ID: 74010769)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Winged Beast
-- Level: 6
-- ATK 200 | DEF 2100
-- Setcode: 0x107d
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster, and all the monsters (if any) on your side of the field and in
-- your Graveyard are FIRE (and only FIRE), you can Special Summon this card (from your hand).
-- Your opponent cannot target this card with card effects.
--[[ __CARD_HEADER_END__ ]]

--陽炎獣 グリプス
function c74010769.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c74010769.spcon)
	c:RegisterEffect(e2)
end
function c74010769.cfilter(c)
	return (c:IsFacedown() or c:IsNonAttribute(ATTRIBUTE_FIRE)) and c:IsType(TYPE_MONSTER)
end
function c74010769.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c74010769.cfilter,c:GetControler(),LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
end

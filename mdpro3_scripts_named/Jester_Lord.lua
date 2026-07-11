--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Jester Lord  (ID: 72992744)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 1
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is the only monster on the field, it gains 1000 ATK for each card in the Spell &
-- Trap Card Zones.
--[[ __CARD_HEADER_END__ ]]

--ジェスター・ロード
function c72992744.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c72992744.atkcon)
	e1:SetValue(c72992744.atkval)
	c:RegisterEffect(e1)
end
function c72992744.atkcon(e)
	return not Duel.IsExistingMatchingCard(nil,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c72992744.filter(c)
	return c:GetSequence()<5
end
function c72992744.atkval(e,c)
	return Duel.GetMatchingGroupCount(c72992744.filter,0,LOCATION_SZONE,LOCATION_SZONE,nil)*1000
end

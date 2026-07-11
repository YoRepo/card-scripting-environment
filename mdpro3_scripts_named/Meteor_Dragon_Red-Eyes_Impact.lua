--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Meteor Dragon Red-Eyes Impact  (ID: 17871506)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Dragon
-- Level: 6
-- ATK 1800 | DEF 2000
-- Setcode: 0x3b
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● Other "Red-Eyes" monsters you control cannot be destroyed by battle or card effects.
--[[ __CARD_HEADER_END__ ]]

--真紅眼の凶星竜－メテオ・ドラゴン
function c17871506.initial_effect(c)
	aux.EnableDualAttribute(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c17871506.indtg)
	e1:SetValue(1)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
end
function c17871506.indtg(e,c)
	return c:IsSetCard(0x3b) and c~=e:GetHandler()
end

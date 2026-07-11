--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Theban Nightmare  (ID: 51838385)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 4
-- ATK 1500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 1500 ATK while you have no cards in your hand nor in your Spell & Trap Zones.
--[[ __CARD_HEADER_END__ ]]

--ナイトメアテーベ
function c51838385.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c51838385.atkcon)
	e1:SetValue(1500)
	c:RegisterEffect(e1)
end
function c51838385.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		+Duel.GetFieldGroupCount(tp,LOCATION_SZONE,0)==0
end

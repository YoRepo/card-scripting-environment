--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Phantom King Hydride  (ID: 6901008)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1500 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you use this card you control as Synchro Material, you can treat it as a non-Tuner.
--[[ __CARD_HEADER_END__ ]]

--幻影王 ハイド・ライド
function c6901008.initial_effect(c)
	--nontuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_NONTUNER)
	e1:SetValue(c6901008.tnval)
	c:RegisterEffect(e1)
end
function c6901008.tnval(e,c)
	return e:GetHandler():IsControler(c:GetControler())
end

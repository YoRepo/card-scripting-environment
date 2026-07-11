--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Star Staring Starling  (ID: 34244455)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1000 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains an effect based on your Main Monster Zone it is in.
-- ● Leftmost: Increase its Level by 4.
-- ● Rightmost: Increase its Level by 3.
-- ● Center: Increase its Level by 2.
-- ● Others: Increase its Level by 1.
--[[ __CARD_HEADER_END__ ]]

--星向鳥
function c34244455.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetCondition(c34244455.lvcon)
	e1:SetValue(c34244455.lvval)
	c:RegisterEffect(e1)
end
function c34244455.lvcon(e)
	return e:GetHandler():GetSequence()<5
end
function c34244455.lvval(e,c)
	local seq=c:GetSequence()
	if seq==0 then return 4 end
	if seq==4 then return 3 end
	if seq==2 then return 2 end
	return 1
end

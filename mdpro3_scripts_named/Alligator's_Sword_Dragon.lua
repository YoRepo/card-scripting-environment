--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Alligator's Sword Dragon  (ID: 3366982)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level: 5
-- ATK 1700 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Baby Dragon" + "Alligator's Sword"
-- This card can attack your opponent directly if the only face-up monsters they control are EARTH,
-- WATER, or FIRE.
--[[ __CARD_HEADER_END__ ]]

--ドラゴンに乗るワイバーン
function c3366982.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,88819587,64428736,true,true)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c3366982.dircon)
	c:RegisterEffect(e2)
end
function c3366982.filter(c)
	return c:IsFaceup() and c:IsAttribute(0xf8)
end
function c3366982.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and not Duel.IsExistingMatchingCard(c3366982.filter,tp,0,LOCATION_MZONE,1,nil)
end

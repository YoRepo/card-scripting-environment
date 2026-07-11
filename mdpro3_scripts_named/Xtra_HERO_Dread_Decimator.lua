--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Xtra HERO Dread Decimator  (ID: 63813056)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Warrior
-- Link Rating: 3
-- Link Arrows: Bottom-Left, Bottom, Bottom-Right
-- ATK 2500
-- Setcode: 0x8
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ "HERO" monsters
-- This card, also any "HERO" monsters it points to, gains 100 ATK for each "HERO" monster with
-- different names in your GY.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--X・HERO ドレッドバスター
function c63813056.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x8),2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c63813056.atktg)
	e1:SetValue(c63813056.atkval)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c63813056.atktg(e,c)
	return c==e:GetHandler()
		or c:IsFaceup() and c:IsSetCard(0x8) and e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c63813056.atkfilter(c)
	return c:IsSetCard(0x8) and c:IsType(TYPE_MONSTER)
end
function c63813056.atkval(e,c)
	return Duel.GetMatchingGroup(c63813056.atkfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)*100
end

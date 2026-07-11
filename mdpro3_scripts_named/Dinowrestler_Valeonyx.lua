--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dinowrestler Valeonyx  (ID: 80831552)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 3
-- ATK 1600 | DEF 0
-- Setcode: 0x11a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If only your opponent controls a monster, you can Special Summon this card (from your hand).
-- While you control a Link-3 or higher "Dinowrestler" monster, face-up monsters you control are
-- unaffected by the activated effects of your opponent's Link-3 or lower monsters.
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・バーリオニクス
function c80831552.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80831552.sprcon)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c80831552.immcon)
	e2:SetValue(c80831552.efilter)
	c:RegisterEffect(e2)
end
function c80831552.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c80831552.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11a) and c:IsLinkAbove(3)
end
function c80831552.immcon(e)
	return Duel.IsExistingMatchingCard(c80831552.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c80831552.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
		and re:IsActiveType(TYPE_MONSTER) and re:IsActivated() and re:GetHandler():IsLinkBelow(3)
end

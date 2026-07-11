--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Familiar-Possessed - Wynn  (ID: 31764353)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 4
-- ATK 1850 | DEF 1500
-- Setcode: 0x10c0
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand or Deck) by sending 1 face-up "Wynn the Wind
-- Charmer" and 1 face-up WIND monster you control to the GY.
-- If this card Special Summoned by its effect attacks a Defense Position monster, inflict piercing
-- battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--憑依装着－ウィン
function c31764353.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCondition(c31764353.spcon)
	e1:SetTarget(c31764353.sptg)
	e1:SetOperation(c31764353.spop)
	e1:SetValue(SUMMON_VALUE_SELF)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetCondition(c31764353.condition)
	c:RegisterEffect(e2)
end
function c31764353.spfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c31764353.fselect(g,tp)
	return aux.mzctcheck(g,tp) and aux.gffcheck(g,Card.IsCode,37744402,Card.IsAttribute,ATTRIBUTE_WIND)
end
function c31764353.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c31764353.spfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c31764353.fselect,2,2,tp)
end
function c31764353.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c31764353.spfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c31764353.fselect,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c31764353.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c31764353.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end

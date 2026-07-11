--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Familiar-Possessed - Aussa  (ID: 31887905)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level: 4
-- ATK 1850 | DEF 1500
-- Setcode: 0x10c0
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand or Deck) by sending 1 face-up "Aussa the Earth
-- Charmer" and 1 face-up EARTH monster you control to the GY.
-- If this card Special Summoned by its effect attacks a Defense Position monster, inflict piercing
-- battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--憑依装着－アウス
function c31887905.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCondition(c31887905.spcon)
	e1:SetTarget(c31887905.sptg)
	e1:SetOperation(c31887905.spop)
	e1:SetValue(SUMMON_VALUE_SELF)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetCondition(c31887905.condition)
	c:RegisterEffect(e2)
end
function c31887905.spfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c31887905.fselect(g,tp)
	return aux.mzctcheck(g,tp) and aux.gffcheck(g,Card.IsCode,37970940,Card.IsAttribute,ATTRIBUTE_EARTH)
end
function c31887905.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c31887905.spfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c31887905.fselect,2,2,tp)
end
function c31887905.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c31887905.spfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c31887905.fselect,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c31887905.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c31887905.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end

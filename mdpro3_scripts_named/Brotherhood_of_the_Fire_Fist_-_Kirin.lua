--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Kirin  (ID: 89856523)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 8
-- ATK 2000 | DEF 2800
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 FIRE Tuner + 1 or more non-Tuner "Fire Fist" monsters
-- When this card is Synchro Summoned: You can Set 1 "Fire Formation" Spell/Trap Card directly from
-- your Deck.
-- All monsters your opponent controls lose 100 ATK for each face-up Spell/Trap Card you control.
--[[ __CARD_HEADER_END__ ]]

--罡炎星－リシュンキ
function c89856523.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),aux.NonTuner(Card.IsSetCard,0x79),1)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89856523,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c89856523.setcon)
	e1:SetTarget(c89856523.settg)
	e1:SetOperation(c89856523.setop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c89856523.atkval)
	c:RegisterEffect(e2)
end
function c89856523.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c89856523.filter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c89856523.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89856523.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c89856523.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c89856523.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c89856523.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c89856523.atkval(e,c)
	return Duel.GetMatchingGroupCount(c89856523.atkfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)*-100
end

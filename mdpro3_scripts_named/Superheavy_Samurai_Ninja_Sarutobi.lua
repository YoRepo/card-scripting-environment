--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Ninja Sarutobi  (ID: 76471944)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 2000 | DEF 2800
-- Setcode: 0x9a, 0x2b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Machine-Type Tuner + 1 or more non-Tuner "Superheavy Samurai" monsters
-- This card can attack while in face-up Defense Position.
-- If it does, apply its DEF for damage calculation.
-- Once per turn, during either player's turn, if you have no Spell/Trap Cards in your Graveyard: You
-- can target 1 Spell/Trap Card on the field; destroy it, and if you do, inflict 500 damage to your
-- opponent.
--[[ __CARD_HEADER_END__ ]]

--超重忍者サルト－B
function c76471944.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),aux.NonTuner(Card.IsSetCard,0x9a),1)
	c:EnableReviveLimit()
	--defense attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DEFENSE_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76471944,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c76471944.descon)
	e2:SetTarget(c76471944.destg)
	e2:SetOperation(c76471944.desop)
	c:RegisterEffect(e2)
end
function c76471944.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c76471944.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c76471944.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c76471944.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c76471944.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c76471944.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c76471944.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end

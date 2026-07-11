--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Explosive Magician  (ID: 33413279)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 6
-- ATK 2500 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner Spellcaster monsters
-- You can remove 2 Spell Counters from your field, then target 1 Spell/Trap your opponent controls;
-- destroy that target.
--[[ __CARD_HEADER_END__ ]]

--エクスプローシブ・マジシャン
function c33413279.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_SPELLCASTER),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33413279,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c33413279.descost)
	e1:SetTarget(c33413279.destg)
	e1:SetOperation(c33413279.desop)
	c:RegisterEffect(e1)
end
function c33413279.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1,2,REASON_COST)
end
function c33413279.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c33413279.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c33413279.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33413279.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33413279.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33413279.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Shiranui Shogunsaga  (ID: 83283063)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Zombie
-- Level: 8
-- ATK 3000 | DEF 0
-- Setcode: 0xd9
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Zombie-Type Tuner + 1 or more non-Tuner Zombie-Type monsters
-- If this card is Special Summoned: You can banish 1 Zombie-Type monster from your Graveyard; this
-- card gains ATK equal to the banished monster's original ATK, until the end of this turn.
-- If this card on the field is destroyed by battle or card effect and sent to the Graveyard: You can
-- target 1 of your banished Zombie-Type monsters with 0 DEF; return it to the Graveyard.
-- You can only Special Summon "Shiranui Shogunsaga(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--戦神－不知火
function c83283063.initial_effect(c)
	c:SetSPSummonOnce(83283063)
	--synchro summon
	aux.AddSynchroProcedure(c,c83283063.synfilter,aux.NonTuner(c83283063.synfilter),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83283063,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCost(c83283063.cost)
	e1:SetOperation(c83283063.operation)
	c:RegisterEffect(e1)
	--add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83283063,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c83283063.tgcon)
	e2:SetTarget(c83283063.tgtg)
	e2:SetOperation(c83283063.tgop)
	c:RegisterEffect(e2)
end
function c83283063.synfilter(c)
	return c:IsRace(RACE_ZOMBIE)
end
function c83283063.cfilter(c)
	return c:IsRace(RACE_ZOMBIE) and c:GetBaseAttack()>0 and c:IsAbleToRemoveAsCost()
end
function c83283063.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83283063.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c83283063.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetBaseAttack())
end
function c83283063.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c83283063.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c83283063.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsDefense(0)
end
function c83283063.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c83283063.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83283063.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c83283063.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c83283063.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	end
end

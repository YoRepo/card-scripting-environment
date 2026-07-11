--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Glacier Aqua Madoor  (ID: 11449436)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 6
-- ATK 1200 | DEF 3000
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of the Damage Step, if your Normal Monster battles an opponent's monster: You can
-- reveal this card in your hand; discard 1 card, and if you do, your monster cannot be destroyed by
-- that battle.
-- At the start of the Damage Step, if this card battles an opponent's monster: You can reveal 1 Normal
-- Monster in your hand; discard 1 card, and if you do, destroy that opponent's monster.
--[[ __CARD_HEADER_END__ ]]

--氷河のアクア・マドール
function c11449436.initial_effect(c)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11449436,0))
	e1:SetCategory(CATEGORY_HANDES_SELF)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c11449436.indescon)
	e1:SetCost(c11449436.indescost)
	e1:SetTarget(c11449436.indestg)
	e1:SetOperation(c11449436.indesop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11449436,1))
	e2:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCost(c11449436.descost)
	e2:SetTarget(c11449436.destg)
	e2:SetOperation(c11449436.desop)
	c:RegisterEffect(e2)
end
function c11449436.indescon(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	e:SetLabelObject(a)
	return a and d and a:IsFaceup() and a:IsType(TYPE_NORMAL)
end
function c11449436.indescost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c11449436.indestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,1)
end
function c11449436.indesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=e:GetLabelObject()
	if Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)>0 and a
		and a:IsRelateToBattle() and a:IsControler(tp) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
	end
end
function c11449436.cfilter(c)
	return c:IsType(TYPE_NORMAL) and not c:IsPublic()
end
function c11449436.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11449436.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c11449436.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c11449436.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(tc)
	if chk==0 then return tc and tc:IsControler(1-tp) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c11449436.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)>0 then
		local tc=e:GetLabelObject()
		if tc and tc:IsRelateToBattle() and tc:IsControler(1-tp) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end

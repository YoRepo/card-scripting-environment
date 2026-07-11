--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Vulcan the Divine  (ID: 98012938)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 6
-- ATK 2000 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- If this card is Synchro Summoned: Target 1 face-up card you control and 1 face-up card your opponent
-- controls; return those targets to the hand, but for the rest of this turn, you cannot activate
-- cards, or the effects of cards, with the same name as those returned to the hand by this effect.
-- You can only use this effect of "Vulcan the Divine" once per turn.
--[[ __CARD_HEADER_END__ ]]

--獣神ヴァルカン
function c98012938.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98012938,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,98012938)
	e1:SetCondition(c98012938.condition)
	e1:SetTarget(c98012938.target)
	e1:SetOperation(c98012938.operation)
	c:RegisterEffect(e1)
end
function c98012938.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c98012938.filter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c98012938.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c98012938.filter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingTarget(c98012938.filter,tp,0,LOCATION_ONFIELD,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g1=Duel.SelectTarget(tp,c98012938.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g2=Duel.SelectTarget(tp,c98012938.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
		g1:Merge(g2)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
	end
end
function c98012938.hfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsFaceup()
end
function c98012938.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	g=g:Filter(c98012938.hfilter,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		local tc=g:GetFirst()
		while tc do
			if tc:IsLocation(LOCATION_HAND) then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
				e1:SetCode(EFFECT_CANNOT_ACTIVATE)
				e1:SetTargetRange(1,0)
				e1:SetValue(c98012938.aclimit)
				e1:SetLabel(tc:GetCode())
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
			end
			tc=g:GetNext()
		end
	end
end
function c98012938.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end

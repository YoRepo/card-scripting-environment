--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dewloren, Tiger King of the Ice Barrier  (ID: 70583986)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Beast
-- Level: 6
-- ATK 2000 | DEF 1400
-- Setcode: 0x2f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner WATER monsters
-- You can target any number of other face-up cards you control; return those targets to the hand,
-- then, this card gains 500 ATK for each card returned to the hand by this effect, until the end of
-- this turn.
-- You can only use this effect of "Dewloren, Tiger King of the Ice Barrier" once per turn.
--[[ __CARD_HEADER_END__ ]]

--氷結界の虎王 ドゥローレン
function c70583986.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WATER),1)
	c:EnableReviveLimit()
	--to hand, atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70583986,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,70583986)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c70583986.target)
	e1:SetOperation(c70583986.operation)
	c:RegisterEffect(e1)
end
function c70583986.filter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c70583986.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c70583986.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c70583986.filter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c70583986.filter,tp,LOCATION_ONFIELD,0,1,12,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c70583986.thfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
end
function c70583986.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetTargetsRelateToChain()
	local rg=tg:Filter(c70583986.thfilter,nil,tp)
	Duel.SendtoHand(rg,nil,REASON_EFFECT)
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.BreakEffect()
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_HAND)
		if ct>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
			e1:SetValue(ct*500)
			c:RegisterEffect(e1)
		end
	end
end

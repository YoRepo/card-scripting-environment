--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Last Resort  (ID: 97970833)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent's monster declares an attack.
-- You can select 1 "Ancient City - Rainbow Ruins" from your Deck and activate it.
-- If your opponent had an active Field Spell Card when this card was activated, they can draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--ラスト・リゾート
function c97970833.initial_effect(c)
	aux.AddCodeList(c,34487429)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c97970833.condition)
	e1:SetTarget(c97970833.target)
	e1:SetOperation(c97970833.activate)
	c:RegisterEffect(e1)
end
function c97970833.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c97970833.filter(c,tp)
	return c:IsCode(34487429) and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function c97970833.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97970833.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function c97970833.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(c97970833.filter,tp,LOCATION_DECK,0,nil,tp)
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		fc=Duel.GetFieldCard(1-tp,LOCATION_FZONE,0)
		local te=tc:GetActivateEffect()
		te:UseCountLimit(tp,1,true)
		Duel.RaiseEvent(tc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
		if fc and fc:IsFaceup() and Duel.IsPlayerCanDraw(1-tp,1) and Duel.SelectYesNo(1-tp,aux.Stringid(97970833,0)) then
			Duel.BreakEffect()
			Duel.Draw(1-tp,1,REASON_EFFECT)
		end
	end
end

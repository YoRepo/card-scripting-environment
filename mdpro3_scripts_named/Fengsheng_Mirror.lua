--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Fengsheng Mirror  (ID: 37406863)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Look at your opponent's hand.
-- Select and discard 1 Spirit monster to the Graveyard if Spirit monsters exist in his/her hand.
--[[ __CARD_HEADER_END__ ]]

--封神鏡
function c37406863.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c37406863.target)
	e1:SetOperation(c37406863.activate)
	c:RegisterEffect(e1)
end
c37406863.has_text_type=TYPE_SPIRIT
function c37406863.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetTargetPlayer(tp)
end
function c37406863.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_SPIRIT)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
			local sg=tg:Select(p,1,1,nil)
			Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
		end
		Duel.ShuffleHand(1-p)
	end
end

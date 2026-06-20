--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 墓穴的同路人  (ID: 16435215)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：双方各自把对方手卡确认，从那之中选1张卡丢弃。那之后，双方各自从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--墓穴の道連れ
function c16435215.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c16435215.condition)
	e1:SetTarget(c16435215.target)
	e1:SetOperation(c16435215.activate)
	c:RegisterEffect(e1)
end
function c16435215.condition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>1
	else
		return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
	end
end
function c16435215.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
end
function c16435215.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 then return end
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g2=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.ConfirmCards(tp,g1)
	Duel.ConfirmCards(1-tp,g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local sg2=g2:Select(1-tp,1,1,nil)
	sg1:Merge(sg2)
	Duel.SendtoGrave(sg1,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(tp)
	Duel.ShuffleHand(1-tp)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end

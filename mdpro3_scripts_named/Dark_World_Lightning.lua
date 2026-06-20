--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 暗黑界之雷  (ID: 93554166)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 6
--
-- Effect Text:
-- ①：以场上盖放的1张卡为对象才能发动。那张盖放的卡破坏。那之后，选自己1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--暗黒界の雷
function c93554166.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c93554166.target)
	e1:SetOperation(c93554166.activate)
	c:RegisterEffect(e1)
end
function c93554166.filter(c)
	return c:IsFacedown()
end
function c93554166.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c93554166.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c93554166.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
		and Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,e:GetHandler())>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c93554166.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c93554166.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
		if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then
			Duel.BreakEffect()
			Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
	end
end

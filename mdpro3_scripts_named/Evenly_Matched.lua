--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 颉颃胜负  (ID: 15693423)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上没有卡存在的场合，这张卡的发动从手卡也能用。
-- ①：对方场上的卡数量比自己场上的卡多的场合，自己·对方的战斗阶段结束时才能发动。直到变成和自己场上的卡数量相同为止，对方必须选自身场上的卡里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--拮抗勝負
function c15693423.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_END)
	e1:SetCondition(c15693423.condition)
	e1:SetTarget(c15693423.target)
	e1:SetOperation(c15693423.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15693423,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c15693423.handcon)
	c:RegisterEffect(e2)
end
function c15693423.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c15693423.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local ct=g:GetCount()-Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	if e:GetHandler():IsLocation(LOCATION_HAND) then ct=ct-1 end
	if chk==0 then return Duel.IsPlayerCanRemove(1-tp)
		and ct>0 and g:IsExists(Card.IsAbleToRemove,1,nil,1-tp,POS_FACEDOWN,REASON_RULE) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,ct,0,0)
end
function c15693423.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanRemove(1-tp) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local ct=g:GetCount()-Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
		local sg=g:FilterSelect(1-tp,Card.IsAbleToRemove,ct,ct,nil,1-tp,POS_FACEDOWN,REASON_RULE)
		Duel.Remove(sg,POS_FACEDOWN,REASON_RULE,1-tp)
	end
end
function c15693423.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_ONFIELD,0)==0
end

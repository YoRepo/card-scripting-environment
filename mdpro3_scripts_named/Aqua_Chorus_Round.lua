--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 水之轮唱  (ID: 59131526)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：选自己1张手卡除外。下次的自己准备阶段，可以把最多2张这个效果除外的卡的同名卡从卡组加入手卡。对方场上没有卡存在的状态把这张卡发动过的场合，直到发动的回合的结束时自己不能把这个效果除外的卡以及原本
-- 卡名和那张卡相同的卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--アクアの輪唱
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)==0 then e:SetLabel(1) else e:SetLabel(0) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc or Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)==0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetLabel(Duel.GetTurnCount(),tc:GetCode())
	e1:SetCondition(s.condition)
	e1:SetOperation(s.operation)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	Duel.RegisterEffect(e1,tp)
	if e:GetLabel()==1 and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ACTIVATE)
		e2:SetTargetRange(1,0)
		e2:SetValue(s.aclimit)
		e2:SetLabel(tc:GetOriginalCodeRule())
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()>(e:GetLabel())
end
function s.filter(c,_,...)
	return c:IsCode(...) and c:IsAbleToHand()
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local t={e:GetLabel()}
	e:Reset()
	if not (Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,table.unpack(t))
		and Duel.SelectYesNo(tp,aux.Stringid(id,1))) then return end
	Duel.Hint(HINT_CARD,0,id)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,2,nil,table.unpack(t))
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function s.aclimit(e,re)
	return re:GetOwner():IsOriginalCodeRule(table.unpack{e:GetLabel()})
end

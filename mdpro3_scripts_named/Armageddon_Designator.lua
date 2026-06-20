--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 终焉之指名者  (ID: 28493337)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把1张手卡从游戏中除外才能发动。双方玩家在这次决斗中不能把为这张卡发动而除外的卡以及那些同名卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--終焉の指名者
function c28493337.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c28493337.cost)
	e1:SetTarget(c28493337.target)
	e1:SetOperation(c28493337.activate)
	c:RegisterEffect(e1)
end
function c28493337.cfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function c28493337.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.IsExistingMatchingCard(c28493337.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c28493337.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c28493337.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return true
	end
end
function c28493337.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c28493337.aclimit)
	e1:SetLabel(e:GetLabel())
	Duel.RegisterEffect(e1,tp)
end
function c28493337.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel())
end

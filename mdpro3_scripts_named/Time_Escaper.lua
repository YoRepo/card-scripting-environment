--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 时间逃脱者  (ID: 73625877)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 2
-- ATK 500 | DEF 100
--
-- Effect Text:
-- 把这张卡从手卡丢弃，选择自己场上表侧表示存在的1只念动力族怪兽发动。选择的怪兽直到下次的自己的准备阶段时从游戏中除外。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--タイム・エスケーパー
function c73625877.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73625877,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c73625877.rmcost)
	e1:SetTarget(c73625877.rmtg)
	e1:SetOperation(c73625877.rmop)
	c:RegisterEffect(e1)
end
function c73625877.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c73625877.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO) and c:IsAbleToRemove()
end
function c73625877.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c73625877.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c73625877.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c73625877.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c73625877.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)==0 then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetCondition(c73625877.retcon)
		e1:SetOperation(c73625877.retop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
			e1:SetLabel(0)
		else
			e1:SetLabel(Duel.GetTurnCount())
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c73625877.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c73625877.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
	e:Reset()
end

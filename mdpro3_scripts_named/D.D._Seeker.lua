--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 异次元的探求者  (ID: 89015998)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Psychic
-- Level 3
-- ATK 1500 | DEF 800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：以自己场上1只表侧表示怪兽为对象才能发动。那只怪兽直到下个回合的结束阶段除外。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--異次元の探求者
function c89015998.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,89015998)
	e1:SetTarget(c89015998.rmtg)
	e1:SetOperation(c89015998.rmop)
	c:RegisterEffect(e1)
end
function c89015998.rmfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c89015998.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c89015998.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89015998.rmfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c89015998.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c89015998.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		tc:RegisterFlagEffect(89015998,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END,2)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(c89015998.retcon)
		e1:SetOperation(c89015998.retop)
		e1:SetLabel(Duel.GetTurnCount())
		Duel.RegisterEffect(e1,tp)
	end
end
function c89015998.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(89015998)~=0
end
function c89015998.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end

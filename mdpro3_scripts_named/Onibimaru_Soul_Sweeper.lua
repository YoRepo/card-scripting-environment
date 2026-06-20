--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 神隐鬼火丸  (ID: 9486959)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Fiend
-- Rank 2
-- ATK 1900 | DEF 1600
--
-- Effect Text:
-- 2星怪兽×2只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把这张卡1个超量素材取除，以对方场上1只怪兽为对象才能发动。那只怪兽直到对方结束阶段除外。
-- ②：持有超量素材的这张卡被对方破坏的场合，以最多有这张卡持有的超量素材数量的自己·对方的除外状态的怪兽为对象才能发动。那些怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--神隠し鬼火丸
function c9486959.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2,nil,nil,99)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,9486959)
	e1:SetCost(c9486959.rmcost)
	e1:SetTarget(c9486959.rmtg)
	e1:SetOperation(c9486959.rmop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,9486960)
	e2:SetCondition(c9486959.tdcon)
	e2:SetTarget(c9486959.tdtg)
	e2:SetOperation(c9486959.tdop)
	c:RegisterEffect(e2)
end
function c9486959.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c9486959.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c9486959.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		tc:RegisterFlagEffect(9486959,RESET_EVENT+RESETS_STANDARD,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(c9486959.retcon)
		e1:SetOperation(c9486959.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c9486959.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetFlagEffect(9486959)~=0 and Duel.GetTurnPlayer()==1-tp
end
function c9486959.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c9486959.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c9486959.tdfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAbleToDeck()
end
function c9486959.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c9486959.tdfilter(chkc) end
	local ct=e:GetHandler():GetPreviousOverlayCountOnField()
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c9486959.tdfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=Duel.SelectTarget(tp,c9486959.tdfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c9486959.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end

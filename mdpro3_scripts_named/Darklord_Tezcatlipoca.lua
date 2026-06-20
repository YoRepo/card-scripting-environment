--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 堕天使 特斯卡特利波卡  (ID: 88234365)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 9
-- ATK 2800 | DEF 2100
-- Setcode: 239
--
-- Effect Text:
-- 自己对「堕天使 特斯卡特利波卡」1回合只能有1次特殊召唤，那个②的效果1回合只能使用1次。
-- ①：自己场上的「堕天使」怪兽被战斗·效果破坏的场合，可以作为代替把手卡的这张卡丢弃。
-- ②：支付1000基本分，以自己墓地1张「堕天使」魔法·陷阱卡为对象才能发动。那张魔法·陷阱卡的效果适用。那之后，墓地的那张卡回到卡组。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--堕天使テスカトリポカ
function c88234365.initial_effect(c)
	c:SetSPSummonOnce(88234365)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c88234365.reptg)
	e1:SetValue(c88234365.repval)
	e1:SetOperation(c88234365.repop)
	c:RegisterEffect(e1)
	--copy effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88234365,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,88234365)
	e2:SetCost(c88234365.cpcost)
	e2:SetTarget(c88234365.cptg)
	e2:SetOperation(c88234365.cpop)
	c:RegisterEffect(e2)
end
function c88234365.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xef) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c88234365.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and eg:IsExists(c88234365.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c88234365.repval(e,c)
	return c88234365.repfilter(c,e:GetHandlerPlayer())
end
function c88234365.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT+REASON_DISCARD)
end
function c88234365.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c88234365.cpfilter(c)
	return c:IsSetCard(0xef) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck() and c:CheckActivateEffect(false,true,false)~=nil
end
function c88234365.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then return Duel.IsExistingTarget(c88234365.cpfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c88234365.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(false,true,true)
	Duel.ClearTargetCard()
	g:GetFirst():CreateEffectRelation(e)
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c88234365.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	if not te:GetHandler():IsRelateToEffect(e) then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	Duel.BreakEffect()
	Duel.SendtoDeck(te:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end

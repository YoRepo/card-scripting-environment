--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 月女神之镞  (ID: 2263869)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方不能对应这张卡的发动把怪兽的效果发动。
-- ①：从额外卡组把1只怪兽送去墓地，以和那只怪兽相同种类（融合·同调·超量·灵摆·连接）的对方场上1只怪兽为对象才能发动。那只怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--月女神の鏃
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function s.tgfilter(c,tp)
	return c:IsAbleToGraveAsCost() and Duel.IsExistingTarget(s.tdfilter,tp,0,LOCATION_MZONE,1,nil,c:GetType())
end
function s.tdfilter(c,type)
	return c:IsFaceup() and c:IsAbleToDeck() and c:GetType()&type&(TYPE_FUSION|TYPE_SYNCHRO|TYPE_XYZ|TYPE_PENDULUM|TYPE_LINK)>0
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and s.tdfilter(chkc,e:GetLabel()) end
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_EXTRA,0,1,nil,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
	local type=g:GetFirst():GetType()
	e:SetLabel(type)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tg=Duel.SelectTarget(tp,s.tdfilter,tp,0,LOCATION_MZONE,1,1,nil,type)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,1,0,0)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(s.chainlm)
	end
end
function s.chainlm(re,rp,tp)
	return tp==rp or not re:GetHandler():IsType(TYPE_MONSTER)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end

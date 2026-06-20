--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 奏悦机组 λ羔羊刃  (ID: 17188206)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 1400 | DEF 1400
-- Setcode: 463
--
-- Effect Text:
-- 这张卡召唤·特殊召唤的场合：可以从卡组把「奏悦机组 λ羔羊刃」以外的1张「奏悦机组」卡送去墓地。
-- 对方主要阶段，这张卡在「奏悦机组」连接怪兽所连接区存在的场合（诱发即时效果）：可以支付1400基本分，以对方场上1只怪兽为对象；这张卡破坏，得到作为对象的怪兽的控制权。这个效果得到控制权的怪兽在结束阶
-- 段破坏。
-- 「奏悦机组 λ羔羊刃」的每个效果1回合各能使用1次。
--[[ __CARD_HEADER_END__ ]]

--R.B. Lambda Blade
local s,id,o=GetID()
function s.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.tgtg)
	e1:SetOperation(s.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.clcon)
	e3:SetCost(s.clcost)
	e3:SetTarget(s.cltg)
	e3:SetOperation(s.clop)
	c:RegisterEffect(e3)
end
function s.tgfilter(c)
	return not c:IsCode(id) and c:IsSetCard(0x1cf) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function s.ecfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1cf) and c:IsType(TYPE_LINK)
end
function s.clcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsMainPhase() or Duel.GetTurnPlayer()==tp then return false end
	local lg=Duel.GetMatchingGroup(s.ecfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local lg2=Group.CreateGroup()
	for lc in aux.Next(lg) do
		lg2:Merge(lc:GetLinkedGroup())
	end
	return lg2 and lg2:IsContains(e:GetHandler()) and Duel.GetTurnPlayer()==1-tp
end
function s.clcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1400) end
	Duel.PayLPCost(tp,1400)
end
function s.cltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)
		and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil,true)
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil,true)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function s.clop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToChain() and Duel.Destroy(c,REASON_EFFECT)~=0
		and tc:IsRelateToChain() and tc:IsType(TYPE_MONSTER) and Duel.GetControl(tc,tp)~=0 then
		tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetCondition(s.descon)
		e1:SetOperation(aux.EPDestroyOperation)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(id)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end

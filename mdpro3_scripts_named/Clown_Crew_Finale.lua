--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 道化一座『终演』  (ID: 84031736)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 476
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：上级召唤的怪兽在自己场上存在的场合，把手卡任意数量丢弃，以那个数量的场上的表侧表示卡为对象才能发动。那些卡破坏。
-- ②：把墓地的这张卡除外，把自己的手卡·场上1只仪式·融合·同调·超量·灵摆·连接怪兽解放才能发动。原本的等级·阶级·连接的数值和那只怪兽不同的1只「道化一座」怪兽从自己的卡组·墓地加入手卡。
--[[ __CARD_HEADER_END__ ]]

--道化の一座『終演』
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_MAIN_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.condition)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	local rt=Duel.GetTargetCount(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local ct=Duel.DiscardHand(tp,Card.IsDiscardable,1,rt,REASON_COST+REASON_DISCARD,nil)
	e:SetLabel(ct)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
		and e:IsCostChecked() end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,ct,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local rg=Duel.GetTargetsRelateToChain()
	if rg:GetCount()>0 then
		Duel.Destroy(rg,REASON_EFFECT)
	end
end
function s.cfilter2(c,tp)
	return c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_PENDULUM+TYPE_LINK)
		and s.lv_rk_lk(c)>0
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c)
end
function s.lv_rk_lk(c)
	if c:GetOriginalLevel()>0 then
		return c:GetOriginalLevel()
	elseif c:GetOriginalRank()>0 then
		return c:GetOriginalRank()
	elseif c:GetLink()>0 then
		return c:GetLink()
	end
	return 0
end
function s.thfilter(c,tc)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1dc)
		and s.lv_rk_lk(c)>0 and s.lv_rk_lk(c)~=s.lv_rk_lk(tc)
		and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not e:IsCostChecked() then return false end
		return Duel.CheckReleaseGroupEx(tp,s.cfilter2,1,REASON_COST,true,nil,tp)
	end
	local g=Duel.SelectReleaseGroupEx(tp,s.cfilter2,1,1,REASON_COST,true,nil,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.Release(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tc)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

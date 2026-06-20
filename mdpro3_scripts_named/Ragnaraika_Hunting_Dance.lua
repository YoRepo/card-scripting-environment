--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 蕾祸大轮首狩舞  (ID: 89824842)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 427
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以最多有自己场上的昆虫族·植物族·爬虫类族连接怪兽的种族种类数量的对方场上的卡为对象才能发动。那些卡破坏。
-- ②：这个回合没有送去墓地的这张卡在墓地存在的状态，自己场上的表侧表示的昆虫族·植物族·爬虫类族怪兽被战斗·效果破坏的场合，把这张卡除外，以对方场上1只怪兽为对象才能发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--蕾禍大輪首狩舞
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.destg)
	e1:SetOperation(s.desop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.descon2)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.destg2)
	e2:SetOperation(s.desop2)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT+RACE_PLANT+RACE_REPTILE) and c:IsType(TYPE_LINK)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil)
	local gc=g:GetClassCount(Card.GetRace)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,gc,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
function s.cfilter2(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and bit.band(c:GetPreviousRaceOnField(),RACE_INSECT+RACE_PLANT+RACE_REPTILE)~=0
		and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function s.descon2(e,tp,eg,ep,ev,re,r,rp)
	return aux.exccon(e) and eg:IsExists(s.cfilter2,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function s.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

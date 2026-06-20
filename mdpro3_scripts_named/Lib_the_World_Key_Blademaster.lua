--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 星键士 利娃  (ID: 39752820)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 2000 | LINK
--
-- Effect Text:
-- 怪兽2只
-- 这张卡在自己墓地有「星遗物」卡存在的场合才能连接召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从卡组选1张「星遗物」魔法·陷阱卡在自己场上盖放。这个回合，自己墓地没有「星遗物」怪兽存在的场合，那张卡不能发动。
-- ②：连接召唤的这张卡作为连接素材送去墓地的场合才能发动。选场上1张卡回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--星鍵士リイヴ
function c39752820.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2)
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_COST)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCost(c39752820.spcost)
	c:RegisterEffect(e0)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39752820,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,39752820)
	e1:SetTarget(c39752820.sttg)
	e1:SetOperation(c39752820.stop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39752820,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,39752821)
	e2:SetCondition(c39752820.tdcon)
	e2:SetTarget(c39752820.tdtg)
	e2:SetOperation(c39752820.tdop)
	c:RegisterEffect(e2)
end
function c39752820.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,1,nil,0xfe)
end
function c39752820.stfilter(c)
	return c:IsSetCard(0xfe) and c:IsSSetable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c39752820.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39752820.stfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c39752820.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c39752820.stfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetCondition(c39752820.aclimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c39752820.actfilter(c)
	return c:IsSetCard(0xfe) and c:IsType(TYPE_MONSTER)
end
function c39752820.aclimit(e)
	return not e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED) and not Duel.IsExistingMatchingCard(c39752820.actfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil)
end
function c39752820.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_LINK) and r==REASON_LINK and c:IsLocation(LOCATION_GRAVE)
end
function c39752820.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c39752820.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end

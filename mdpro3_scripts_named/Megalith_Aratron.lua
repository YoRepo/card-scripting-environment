--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 巨石遗物·阿拉施龙  (ID: 25726386)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 2000 | DEF 3000
-- Setcode: 312
--
-- Effect Text:
-- 「巨石遗物」卡降临。这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，把这张卡从手卡丢弃才能发动。等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「巨石遗物」仪式怪兽仪式召唤。
-- ②：自己场上的卡为对象的对方的效果发动时才能发动。从自己墓地选1只仪式怪兽回到卡组最下面，那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--メガリス・アラトロン
function c25726386.initial_effect(c)
	c:EnableReviveLimit()
	--ritual summon
	local e1=aux.AddRitualProcGreater2(c,c25726386.filter,nil,nil,c25726386.matfilter,true)
	e1:SetDescription(aux.Stringid(25726386,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,25726386)
	e1:SetCondition(c25726386.rscon)
	e1:SetCost(c25726386.rscost)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25726386,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,25726387)
	e2:SetCondition(c25726386.discon)
	e2:SetTarget(c25726386.distg)
	e2:SetOperation(c25726386.disop)
	c:RegisterEffect(e2)
end
function c25726386.filter(c,e,tp,chk)
	return c:IsSetCard(0x138) and (not chk or c~=e:GetHandler())
end
function c25726386.matfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c25726386.rscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c25726386.rscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c25726386.tfilter(c,tp)
	return c:IsOnField() and c:IsControler(tp)
end
function c25726386.disfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c25726386.discon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c25726386.tfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c25726386.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c25726386.disfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c25726386.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c25726386.disfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_EFFECT)~=0 then
		if g:GetFirst():IsLocation(LOCATION_DECK) and Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end

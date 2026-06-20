--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 凭依共鸣-薇茵  (ID: 60516416)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Spellcaster
-- Level 5
-- ATK 1850 | DEF 1500
-- Setcode: 4288
--
-- Effect Text:
-- 魔法师族怪兽＋风属性怪兽
-- 这个卡名在规则上也当作「凭依装着」卡使用。这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡融合召唤的场合，从自己墓地让1只风属性怪兽回到卡组最下面，以对方场上1只怪兽为对象才能发动。得到那只怪兽的控制权。
-- ②：对方回合，以包含自己场上的风属性怪兽的场上2张卡为对象才能发动。那些卡用喜欢的顺序回到卡组下面。
--[[ __CARD_HEADER_END__ ]]

--憑依共鳴－ウィン
local s,id,o=GetID()
function s.initial_effect(c)
	--material
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WIND),true)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.cocon)
	e1:SetCost(s.cocost)
	e1:SetTarget(s.cotg)
	e1:SetOperation(s.coop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,id)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(s.tdcon)
	e2:SetTarget(s.tdtg)
	e2:SetOperation(s.tdop)
	c:RegisterEffect(e2)
end
function s.cocon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToDeckAsCost()
end
function s.cocost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_COST)
end
function s.filter(c,tp)
	return c:IsControlerCanBeChanged()
end
function s.cotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and s.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function s.coop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and tc:IsType(TYPE_MONSTER) then
		Duel.GetControl(tc,tp)
	end
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function s.tdfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_MONSTER)
end
function s.gcheck(g,tp)
	return g:IsExists(s.tdfilter,1,nil,tp)
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local rg=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToDeck,Card.IsCanBeEffectTarget),tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if chk==0 then return rg:CheckSubGroup(s.gcheck,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tg=rg:SelectSubGroup(tp,s.gcheck,false,2,2,tp)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,2,0,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetsRelateToChain():Filter(Card.IsOnField,nil)
	if tg:GetCount()>0 then
		aux.PlaceCardsOnDeckBottom(tp,tg)
	end
end

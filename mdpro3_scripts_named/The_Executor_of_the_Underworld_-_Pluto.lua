--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 冥府的执行者 普鲁托  (ID: 37706769)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: DARK
-- Race: Fairy
-- Level 5
-- ATK 2300 | DEF 0
-- Setcode: 68
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名在规则上也当作「代行者」卡使用。这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，从自己墓地把1只怪兽除外，以场上1只效果怪兽为对象才能发动。那只怪兽变成里侧守备表示。场上或者墓地有「天空的圣域」存在的场合，这个效果在对方回合也能发动。
-- ②：把墓地的这张卡除外才能发动。从自己的卡组·墓地选1张「天空的圣域」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--冥府の執行者 プルート
function c37706769.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	aux.AddCodeList(c,56433456)
	c:EnableReviveLimit()
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37706769,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c37706769.noqkcon)
	e1:SetCost(c37706769.poscost)
	e1:SetTarget(c37706769.postg)
	e1:SetOperation(c37706769.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(c37706769.qkcon)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37706769,1))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,37706770)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c37706769.thtg)
	e3:SetOperation(c37706769.thop)
	c:RegisterEffect(e3)
end
function c37706769.qkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(56433456,PLAYER_ALL,LOCATION_ONFIELD+LOCATION_GRAVE)
end
function c37706769.noqkcon(e,tp,eg,ep,ev,re,r,rp)
	return not c37706769.qkcon(e,tp,eg,ep,ev,re,r,rp)
end
function c37706769.poscostfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c37706769.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37706769.poscostfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37706769.poscostfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37706769.posfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsCanTurnSet()
end
function c37706769.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c37706769.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37706769.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c37706769.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c37706769.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
function c37706769.thfilter(c)
	return c:IsCode(56433456) and c:IsAbleToHand()
end
function c37706769.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37706769.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c37706769.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c37706769.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

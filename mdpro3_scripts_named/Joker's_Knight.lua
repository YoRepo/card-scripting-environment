--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 王牌骑士  (ID: 29284413)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 5
-- ATK 2000 | DEF 1400
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从卡组把「王后骑士」「卫兵骑士」「国王骑士」之内1只送去墓地才能发动。这张卡从手卡特殊召唤。这个效果特殊召唤的这张卡直到结束阶段当作和送去墓地的怪兽同名卡使用。
-- ②：自己·对方的结束阶段，以这张卡以外的自己墓地1只战士族·光属性怪兽为对象才能发动。那只怪兽回到卡组，墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ジョーカーズ・ナイト
function c29284413.initial_effect(c)
	aux.AddCodeList(c,25652259,64788463,90876561)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29284413,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,29284413)
	e1:SetCost(c29284413.spcost)
	e1:SetTarget(c29284413.sptg)
	e1:SetOperation(c29284413.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29284413,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,29284414)
	e2:SetTarget(c29284413.thtg)
	e2:SetOperation(c29284413.thop)
	c:RegisterEffect(e2)
end
function c29284413.cfilter(c)
	return c:IsCode(25652259,64788463,90876561) and c:IsAbleToGraveAsCost()
end
function c29284413.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29284413.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c29284413.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SendtoGrave(g,REASON_COST)
end
function c29284413.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29284413.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local code=e:GetLabel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c29284413.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_WARRIOR) and c:IsAbleToDeck()
end
function c29284413.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c29284413.tdfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c29284413.tdfilter,tp,LOCATION_GRAVE,0,1,c) and c:IsAbleToHand() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c29284413.tdfilter,tp,LOCATION_GRAVE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
end
function c29284413.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA)
		and c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end

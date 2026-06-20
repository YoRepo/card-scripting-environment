--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 地中族导师  (ID: 16428514)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Dragon
-- Level 4
-- ATK 1600 | DEF 1800
-- Setcode: 237
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡反转的场合才能发动。从卡组把「地中族导师」以外的1张「地中族」卡加入手卡。
-- ②：以场上1只其他的表侧表示怪兽为对象才能发动（自己场上有其他的「地中族」卡存在的场合，这个效果在对方回合也能发动）。那只怪兽和这张卡变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--サブテラーの導師
function c16428514.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16428514,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,16428514)
	e1:SetTarget(c16428514.thtg)
	e1:SetOperation(c16428514.thop)
	c:RegisterEffect(e1)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16428514,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,16428515)
	e2:SetCondition(c16428514.setcon1)
	e2:SetTarget(c16428514.settg)
	e2:SetOperation(c16428514.setop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCondition(c16428514.setcon2)
	c:RegisterEffect(e3)
end
function c16428514.thfilter(c)
	return c:IsSetCard(0xed) and not c:IsCode(16428514) and c:IsAbleToHand()
end
function c16428514.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c16428514.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c16428514.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c16428514.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c16428514.setcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xed)
end
function c16428514.setcon1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c16428514.setcfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c16428514.setcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c16428514.setcfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c16428514.setfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c16428514.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc~=c and c16428514.setfilter(chkc) end
	if chk==0 then return c16428514.setfilter(c)
		and Duel.IsExistingTarget(c16428514.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c16428514.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,2,0,0)
end
function c16428514.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local g=Group.FromCards(c,tc)
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end

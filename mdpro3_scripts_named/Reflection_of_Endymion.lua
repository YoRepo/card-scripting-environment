--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 恩底弥翁的皇后  (ID: 39000945)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 7
-- Pendulum Scales: L2 / R2
-- ATK 1850 | DEF 2700
-- Setcode: 298
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：每次自己或者对方把魔法卡发动，给这张卡放置1个魔力指示物。
-- ②：把这张卡3个魔力指示物取除才能发动。手卡1只可以放置魔力指示物的怪兽和灵摆区域的这张卡特殊召唤，给那2只各放置1个魔力指示物。
-- 【怪兽效果】
-- 自己对「恩底弥翁的皇后」1回合只能有1次特殊召唤。
-- ①：这张卡特殊召唤成功的场合，以自己场上1张其他的有魔力指示物放置的卡和对方场上1张卡为对象才能发动。那些自己以及对方的卡回到持有者手卡。那之后，从自己场上回到手卡的卡放置的数量的魔力指示物给这张卡放
-- 置。
-- ②：有魔力指示物放置的这张卡被战斗破坏时才能发动。从卡组把1张「恩底弥翁」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--エンプレス・オブ・エンディミオン
function c39000945.initial_effect(c)
	--Pendulum Summon
	c:EnableCounterPermit(0x1,LOCATION_PZONE+LOCATION_MZONE)
	aux.EnablePendulumAttribute(c)
	c:SetSPSummonOnce(39000945)
	--Add Counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetOperation(aux.chainreg)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetOperation(c39000945.counterop)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(39000945,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCost(c39000945.spcost)
	e3:SetTarget(c39000945.sptg)
	e3:SetOperation(c39000945.spop)
	c:RegisterEffect(e3)
	--Special Summon Success
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(39000945,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e4:SetTarget(c39000945.rthtg)
	e4:SetOperation(c39000945.rthop)
	c:RegisterEffect(e4)
	--Deck Search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(39000945,2))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_DESTROYED)
	e5:SetCondition(c39000945.thcon)
	e5:SetTarget(c39000945.thtg)
	e5:SetOperation(c39000945.thop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_LEAVE_FIELD_P)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetOperation(c39000945.regop)
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
end
function c39000945.counterop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0 then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c39000945.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1,3,REASON_COST)
end
function c39000945.spfilter(c,e,tp)
	return c:IsCanHaveCounter(0x1) and Duel.IsCanAddCounter(tp,0x1,1,c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39000945.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsCanAddCounter(tp,0x1,1,c)
		and Duel.IsExistingMatchingCard(c39000945.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,2,tp,LOCATION_HAND)
end
function c39000945.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c39000945.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		g:AddCard(c)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		for tc in aux.Next(g) do
			tc:AddCounter(0x1,1)
		end
	end
end
function c39000945.rthfilter(c)
	return c:IsAbleToHand() and c:GetCounter(0x1)>0
end
function c39000945.rthtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c39000945.rthfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
		and Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectTarget(tp,c39000945.rthfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,g1:GetCount(),0,LOCATION_ONFIELD)
end
function c39000945.rthop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	local ctable={}
	for tc in aux.Next(g) do
		if tc:IsControler(tp) then
			ctable[tc]=tc:GetCounter(0x1)
		end
	end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local ct=0
	for tc,num in pairs(ctable) do
		if og:IsContains(tc) and tc:IsLocation(LOCATION_HAND) then
			ct=ct+num
		end
	end
	if ct>0 then
		Duel.BreakEffect()
		e:GetHandler():AddCounter(0x1,ct)
	end
end
function c39000945.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()>0
end
function c39000945.thfilter(c)
	return c:IsSetCard(0x12a) and c:IsAbleToHand()
end
function c39000945.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39000945.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c39000945.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c39000945.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c39000945.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(e:GetHandler():GetCounter(0x1))
end

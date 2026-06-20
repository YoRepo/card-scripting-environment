--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 失乐之堕天使  (ID: 35306215)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fairy
-- ATK 1600 | LINK
-- Setcode: 239
--
-- Effect Text:
-- 天使族怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己作需要怪兽2只解放的天使族怪兽的上级召唤的场合，可以不把怪兽2只解放而从自己墓地把2只怪兽除外来上级召唤。
-- ②：丢弃1张手卡才能发动。从卡组选1只「堕天使」怪兽加入手卡或送去墓地。
-- ③：自己结束阶段发动。自己回复场上的天使族怪兽数量×500基本分。
--[[ __CARD_HEADER_END__ ]]

--失楽の堕天使
function c35306215.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_FAIRY),2,2)
	--summon proc
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35306215,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c35306215.otcon)
	e1:SetTarget(c35306215.ottg)
	e1:SetOperation(c35306215.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e4)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35306215,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,35306215)
	e2:SetCost(c35306215.thcost)
	e2:SetTarget(c35306215.thtg)
	e2:SetOperation(c35306215.thop)
	c:RegisterEffect(e2)
	--recover
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(35306215,2))
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c35306215.reccon)
	e3:SetTarget(c35306215.rectg)
	e3:SetOperation(c35306215.recop)
	c:RegisterEffect(e3)
end
function c35306215.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c35306215.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc<=2 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c35306215.rmfilter,tp,LOCATION_GRAVE,0,2,nil)
end
function c35306215.ottg(e,c)
	local mi,ma=c:GetTributeRequirement()
	return mi<=2 and ma>=2 and c:IsRace(RACE_FAIRY)
end
function c35306215.otop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c35306215.rmfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	c:SetMaterial(nil)
end
function c35306215.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c35306215.thfilter(c)
	return c:IsSetCard(0xef) and c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c35306215.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35306215.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c35306215.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c35306215.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end
function c35306215.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c35306215.recfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c35306215.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rec=Duel.GetMatchingGroupCount(c35306215.recfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*500
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c35306215.recop(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c35306215.recfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end

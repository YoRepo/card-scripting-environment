--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 提斯蒂娜的变晶  (ID: 86553594)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 420
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：可以从以下效果选择1个发动。
-- ●自己场上有「提斯蒂娜」怪兽存在的场合才能发动。对方墓地1张卡里侧除外。
-- ●从额外卡组特殊召唤的「提斯蒂娜」怪兽在自己场上存在的场合才能发动。对方墓地的卡全部里侧除外。
-- ②：把墓地的这张卡除外，以自己墓地1只「提斯蒂娜」怪兽为对象才能发动。那只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ティスティナの変晶
local s,id,o=GetID()
function s.initial_effect(c)
	--remove 1 card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--remove all
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.recon)
	e2:SetTarget(s.retg)
	e2:SetOperation(s.reop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,id)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(s.thtg)
	e3:SetOperation(s.thop)
	c:RegisterEffect(e3)
end
function s.filter(c)
	return c:IsSetCard(0x1a4) and c:IsFaceup()
end
function s.filter1(c,tp)
	return c:IsAbleToRemove(tp,POS_FACEDOWN)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,1,nil)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter1,tp,0,LOCATION_GRAVE,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_GRAVE)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,s.filter1,tp,0,LOCATION_GRAVE,1,1,nil,tp)
	if #g>0 then
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
	end
end
function s.refilter(c)
	return c:IsSetCard(0x1a4) and c:IsSummonLocation(LOCATION_EXTRA) and c:IsFaceup()
end
function s.recon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.refilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter1,tp,0,LOCATION_GRAVE,1,nil,tp) end
	local g=Duel.GetMatchingGroup(s.filter1,tp,0,LOCATION_GRAVE,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),1-tp,LOCATION_GRAVE)
end
function s.reop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.filter1,tp,0,LOCATION_GRAVE,nil,tp)
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
function s.thfilter(c)
	return c:IsSetCard(0x1a4) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return s.thfilter(chkc) and chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(s.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,s.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 元素灵剑士·波涛  (ID: 46425662)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 3
-- ATK 1500 | DEF 1000
-- Setcode: 16397
--
-- Effect Text:
-- ①：1回合1次，从手卡把1只「元素灵剑士」怪兽送去墓地，以自己墓地1只「元素灵剑士·波涛」以外的「元素灵剑士」怪兽或者「灵神」怪兽为对象才能发动。那只怪兽加入手卡。
-- ②：这张卡在墓地存在的场合，1回合1次，宣言1个属性才能发动。墓地的这张卡直到回合结束时变成宣言的属性。
--[[ __CARD_HEADER_END__ ]]

--エレメントセイバー・ナル
function c46425662.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46425662,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCost(c46425662.thcost)
	e1:SetTarget(c46425662.thtg)
	e1:SetOperation(c46425662.thop)
	c:RegisterEffect(e1)
	--att change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46425662,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetTarget(c46425662.atttg)
	e2:SetOperation(c46425662.attop)
	c:RegisterEffect(e2)
end
function c46425662.costfilter(c)
	return c:IsSetCard(0x400d) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c46425662.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local fe=Duel.IsPlayerAffectedByEffect(tp,61557074)
	local loc=LOCATION_HAND
	if fe then loc=LOCATION_HAND+LOCATION_DECK end
	if chk==0 then return Duel.IsExistingMatchingCard(c46425662.costfilter,tp,loc,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,c46425662.costfilter,tp,loc,0,1,1,nil):GetFirst()
	if tc:IsLocation(LOCATION_DECK) then
		Duel.Hint(HINT_CARD,0,61557074)
		fe:UseCountLimit(tp)
	end
	Duel.SendtoGrave(tc,REASON_COST)
end
function c46425662.thfilter(c)
	return c:IsSetCard(0x400d,0x113) and c:IsType(TYPE_MONSTER) and not c:IsCode(46425662) and c:IsAbleToHand()
end
function c46425662.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c46425662.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46425662.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c46425662.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c46425662.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c46425662.atttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local att=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL&~e:GetHandler():GetAttribute())
	e:SetLabel(att)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function c46425662.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

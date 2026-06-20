--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 方界法  (ID: 1218214)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 227
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从手卡把1张「方界」卡送去墓地，自己从卡组抽1张。
-- ②：只要这张卡在魔法与陷阱区域存在，自己的「方界」怪兽的战斗发生的对自己的战斗伤害变成0。
-- ③：把墓地的这张卡除外，以自己墓地1只「方界」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--方界法
function c1218214.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c1218214.filter)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,1218214)
	e3:SetTarget(c1218214.drawtg)
	e3:SetOperation(c1218214.drawop)
	c:RegisterEffect(e3)
	--To hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,1218215)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(c1218214.thtg)
	e4:SetOperation(c1218214.thop)
	c:RegisterEffect(e4)
end
function c1218214.filter(e,c)
	return c:IsSetCard(0xe3)
end
function c1218214.cfilter(c)
	return c:IsSetCard(0xe3)
end
function c1218214.drawtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c1218214.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c1218214.drawop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,c1218214.cfilter,1,1,REASON_EFFECT)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c1218214.thfilter(c)
	return c:IsSetCard(0xe3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c1218214.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1218214.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1218214.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c1218214.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c1218214.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

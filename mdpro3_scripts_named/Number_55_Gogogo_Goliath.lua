--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: No.55 隆隆隆巨无霸  (ID: 46871387)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank 4
-- ATK 2400 | DEF 1200
-- Setcode: 4718681
--
-- Effect Text:
-- 4星怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己场上的怪兽的守备力上升800。
-- ②：把这张卡1个超量素材取除，以自己墓地1只岩石族·地属性·4星怪兽为对象才能发动。那只岩石族·地属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--No.55 ゴゴゴゴライアス
function c46871387.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46871387,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,46871387)
	e1:SetCost(c46871387.thcost)
	e1:SetTarget(c46871387.thtg)
	e1:SetOperation(c46871387.thop)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(800)
	c:RegisterEffect(e2)
end
aux.xyz_number[46871387]=55
function c46871387.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c46871387.filter(c)
	return c:IsRace(RACE_ROCK) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsLevel(4) and c:IsAbleToHand()
end
function c46871387.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c46871387.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46871387.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c46871387.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c46871387.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_ROCK) and tc:IsAttribute(ATTRIBUTE_EARTH) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

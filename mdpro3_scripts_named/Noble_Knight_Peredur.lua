--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 圣骑士 珀西瓦尔  (ID: 73359475)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1900 | DEF 300
-- Setcode: 4218
--
-- Effect Text:
-- ①：只要这张卡有「圣剑」装备魔法卡装备，这张卡等级上升1星并变成暗属性。
-- ②：有「圣剑」装备魔法卡装备的这张卡被送去墓地的场合，以自己墓地1张「圣剑」卡为对象发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--聖騎士パーシヴァル
function c73359475.initial_effect(c)
	--Attribute Dark
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c73359475.eqcon2)
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_LEVEL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(73359475,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c73359475.thcon)
	e4:SetTarget(c73359475.thtg)
	e4:SetOperation(c73359475.thop)
	c:RegisterEffect(e4)
end
function c73359475.eqcon2(e)
	return e:GetHandler():GetEquipGroup():IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c73359475.thcon(e,tp,eg,ep,ev,re,r,rp)
	return c73359475.eqcon2(e) and e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c73359475.thfilter(c)
	return c:IsSetCard(0x207a) and c:IsAbleToHand()
end
function c73359475.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c73359475.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c73359475.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c73359475.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c73359475.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

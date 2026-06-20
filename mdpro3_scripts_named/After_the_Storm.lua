--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 战火的残余  (ID: 82263578)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：双方场上没有其他卡存在的场合，以自己墓地1只水·风属性怪兽为对象才能发动。那只水·风属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--戦火の残滓
function c82263578.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c82263578.condition)
	e1:SetTarget(c82263578.target)
	e1:SetOperation(c82263578.activate)
	c:RegisterEffect(e1)
end
function c82263578.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
end
function c82263578.filter(c)
	return c:IsAttribute(ATTRIBUTE_WATER+ATTRIBUTE_WIND) and c:IsAbleToHand()
end
function c82263578.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c82263578.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82263578.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c82263578.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c82263578.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttribute(ATTRIBUTE_WATER+ATTRIBUTE_WIND) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

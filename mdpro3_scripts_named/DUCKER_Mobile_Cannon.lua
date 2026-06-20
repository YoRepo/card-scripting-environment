--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 二足炮台  (ID: 14506878)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 500
--
-- Effect Text:
-- ①：这张卡反转的场合，以自己墓地1只4星怪兽为对象发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ダッカー
function c14506878.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14506878,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c14506878.thtg)
	e1:SetOperation(c14506878.thop)
	c:RegisterEffect(e1)
end
function c14506878.filter(c)
	return c:IsLevel(4) and c:IsAbleToHand()
end
function c14506878.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c14506878.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c14506878.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c14506878.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 暗之量产工厂  (ID: 90928333)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己墓地2只通常怪兽为对象才能发动。那些怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--闇の量産工場
function c90928333.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90928333.target)
	e1:SetOperation(c90928333.activate)
	c:RegisterEffect(e1)
end
function c90928333.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToHand()
end
function c90928333.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c90928333.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90928333.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c90928333.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,2,0,0)
end
function c90928333.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end

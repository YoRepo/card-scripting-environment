--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: DD征募  (ID: 8643186)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 175
--
-- Effect Text:
-- 「DD征募」在1回合只能发动1张。
-- ①：对方场上的怪兽数量比自己场上的怪兽多的场合，以最多有那个相差数量的自己墓地的「DD」怪兽或者「契约书」卡为对象才能发动。那些卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--DDリクルート
function c8643186.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,8643186+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c8643186.condition)
	e1:SetTarget(c8643186.target)
	e1:SetOperation(c8643186.operation)
	c:RegisterEffect(e1)
end
function c8643186.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
end
function c8643186.filter(c)
	return ((c:IsSetCard(0xaf) and c:IsType(TYPE_MONSTER)) or c:IsSetCard(0xae)) and c:IsAbleToHand()
end
function c8643186.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c8643186.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8643186.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c8643186.filter,tp,LOCATION_GRAVE,0,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c8643186.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end

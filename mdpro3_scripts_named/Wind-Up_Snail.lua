--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 发条蜗牛  (ID: 58475908)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 100 | DEF 2000
-- Setcode: 88
--
-- Effect Text:
-- 自己的主要阶段时，可以选择场上盖放的1张卡回到持有者手卡。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゼンマイマイ
function c58475908.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58475908,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c58475908.target)
	e1:SetOperation(c58475908.operation)
	c:RegisterEffect(e1)
end
function c58475908.filter(c)
	return c:IsFacedown() and c:IsAbleToHand()
end
function c58475908.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c58475908.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58475908.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c58475908.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c58475908.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

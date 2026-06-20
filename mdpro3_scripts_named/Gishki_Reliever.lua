--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 遗式杀手  (ID: 37557626)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 500 | DEF 800
-- Setcode: 58
--
-- Effect Text:
-- 这张卡召唤·反转召唤成功时，自己场上有这张卡以外的名字带有「遗式」的怪兽表侧表示存在的场合，可以选择这张卡以外的自己场上存在的1只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--リチュア・キラー
function c37557626.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37557626,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c37557626.condition)
	e1:SetTarget(c37557626.target)
	e1:SetOperation(c37557626.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c37557626.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3a)
end
function c37557626.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c37557626.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c37557626.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c37557626.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c37557626.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

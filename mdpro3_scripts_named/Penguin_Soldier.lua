--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 企鹅士兵  (ID: 93920745)
-- Type: Monster / Effect / Toon
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 750 | DEF 500
-- Setcode: 90
--
-- Effect Text:
-- ①：这张卡反转的场合，以场上最多2只怪兽为对象才能发动。那些怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--ペンギン・ソルジャー
function c93920745.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93920745,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetTarget(c93920745.target)
	e1:SetOperation(c93920745.operation)
	c:RegisterEffect(e1)
end
function c93920745.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c93920745.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if tg then
		local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end

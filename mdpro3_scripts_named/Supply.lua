--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 物资调达员  (ID: 44072894)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1300 | DEF 800
--
-- Effect Text:
-- 反转：通过「融合」而送去自己的墓地的2只融合素材怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--物資調達員
function c44072894.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44072894,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c44072894.target)
	e1:SetOperation(c44072894.operation)
	c:RegisterEffect(e1)
end
function c44072894.filter(c,e)
	return c:IsReason(REASON_FUSION) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function c44072894.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44072894.filter(chkc,e) end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c44072894.filter,tp,LOCATION_GRAVE,0,nil,e)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,2,2,nil)
		Duel.SetTargetCard(sg)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,2,0,0)
	end
end
function c44072894.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	g=g:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==2 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

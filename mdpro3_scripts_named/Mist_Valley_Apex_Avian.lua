--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 霞之谷的巨神鸟  (ID: 29587993)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 7
-- ATK 2700 | DEF 2000
-- Setcode: 55
--
-- Effect Text:
-- 这张卡的效果在同一连锁上只能发动1次。
-- ①：魔法·陷阱·怪兽的效果发动时，以自己场上1张「霞之谷」卡为对象才能发动。那张自己的「霞之谷」卡回到持有者手卡，那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--霞の谷の巨神鳥
function c29587993.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29587993,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e1:SetCondition(c29587993.discon)
	e1:SetTarget(c29587993.distg)
	e1:SetOperation(c29587993.disop)
	c:RegisterEffect(e1)
end
function c29587993.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c29587993.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x37) and c:IsAbleToHand()
end
function c29587993.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c29587993.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c29587993.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c29587993.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c29587993.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
	if not tc:IsLocation(LOCATION_HAND) then return end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end

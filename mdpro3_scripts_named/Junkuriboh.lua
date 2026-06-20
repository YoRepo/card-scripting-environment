--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 废品栗子球  (ID: 38491199)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 10747971
--
-- Effect Text:
-- ①：给与自己伤害的魔法·陷阱·怪兽的效果由对方发动时，把自己的手卡·场上的这张卡送去墓地才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ジャンクリボー
function c38491199.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38491199,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c38491199.negcon)
	e1:SetCost(c38491199.negcost)
	e1:SetTarget(c38491199.negtg)
	e1:SetOperation(c38491199.negop)
	c:RegisterEffect(e1)
end
function c38491199.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c38491199.negcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c38491199.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c38491199.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end

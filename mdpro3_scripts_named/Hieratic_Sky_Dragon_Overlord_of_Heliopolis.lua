--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 圣刻天龙-九神龙  (ID: 3292267)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Dragon
-- Rank 8
-- ATK 3000 | DEF 2400
-- Setcode: 105
--
-- Effect Text:
-- 8星怪兽×2
-- ①：1回合1次，以自己的场上·墓地的卡或者除外的自己的卡为对象的魔法·陷阱·怪兽的效果由对方发动时，把这张卡1个超量素材取除才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--聖刻天龍－エネアード
function c3292267.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,8,2)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3292267,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c3292267.discon)
	e1:SetCost(c3292267.discost)
	e1:SetTarget(c3292267.distg)
	e1:SetOperation(c3292267.disop)
	c:RegisterEffect(e1)
end
function c3292267.tfilter(c,tp)
	return c:IsLocation(LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED) and c:IsControler(tp)
end
function c3292267.discon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c3292267.tfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c3292267.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c3292267.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c3292267.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
